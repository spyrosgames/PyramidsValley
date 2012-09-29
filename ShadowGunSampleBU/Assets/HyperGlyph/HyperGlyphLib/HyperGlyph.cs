using UnityEngine;
using System.Collections.Generic;
using System.Collections;

///This is the data structure class that is returned by the recognizer.
[System.Serializable]
public class HyperGlyphResult
{
	///the name of the template that is the closest match to the input.
	public string glyphname;
	/**the score of the match.
	From 0 to 100%, higher is better.
	*/
	public float score;
	/**a bounding box of the input. 
	This can be used to discriminate between size of the input gesture.\n
	For instance if you wanted to have two different, big circle and small circle\n
	gestures. You could have a single circle template, and use these bounds\n
	to determine the size after recognition happens.
	*/
	public Rect bounds;
	/**the general direction of the input.
	If you need to differentiate between two gestures that are the same shape\n
	but differ in rotation. For example a line to the top right corner and\n
	a line to the bottom right corner (slashUp and slashDown) it is better\n
	to leave rotationInvariant turned on and only have 1 line template\n
	Then determine the direction after the recognition happens through checking\n
	the value of this direction.\n\n

	The direction is represented in degrees relative to the 2D x axis.\n
	So lines to the right will have a direction near 0.\n
	And lines to the left will have a direction near 180.
	*/
	public float direction;
}

/**
The main class of the HyperGlyph Recognizer.

A simple C# example of use:
\code
using UnityEngine;
using System.Collections;

public class SimpleGestureExample : MonoBehaviour {
	public GestureSet myGestures;
	public HyperGlyphResult match;

	void Start () {
		HyperGlyph.Init(myGestures);
	}
	
	void Update () {
		if(Input.GetMouseButton(0))
			HyperGlyph.AddPoint(Input.mousePosition);

		if(Input.GetMouseButtonUp(0))
			match = HyperGlyph.Recognize();
	}

	void OnGUI(){
		GUILayout.Label(match.glyphname);
	}
}
\endcode

A simple UnityScript/JavaScript example:
\code
var myGestures : GestureSet;
var match : HyperGlyphResult;

function Start () {
	HyperGlyph.Init(myGestures);
}

function Update () {
	if(Input.GetMouseButton(0))
		HyperGlyph.AddPoint(Input.mousePosition);

	if(Input.GetMouseButtonUp(0))
		match = HyperGlyph.Recognize();
}

function OnGUI (){
	GUILayout.Label(match.glyphname);
}
\endcode

*/	
public class HyperGlyph
{
	static int ResampleSize = 128;
	static float ScaleSize = 512.0f;
	static int RejectionWindow = 45;

	static bool UseDymanicTimeWarp = true;
	static bool rotationInvariant = true;

	static List<Gesture> Templates;
	static List<Gesture> ResampledTemplates;
	static List<Vector2> InputPath;

	public static HyperGlyphResult result;

	private static float[,] timeWarp;
	private static int _sn = 0;
    private static int _sm = 0;
	private static bool Ready;
	
    public static void Init(GestureSet Set)
    {
    	Ready = false;
		ResampleSize = Set.ResampleSize;
		ScaleSize = Set.ScaleSize;
		RejectionWindow = Set.RejectionWindow;

		UseDymanicTimeWarp = Set.UseDymanicTimeWarp;
		rotationInvariant = Set.rotationInvariant;

    	InputPath = new List<Vector2>();

        Templates = Set.Templates;
        ResampledTemplates = new List<Gesture>();

    	foreach(Gesture gesture in Templates)
    	{
    		//Debug.Log("HyperGlyph: Normalizing and Adding " + gesture.Name);
    		Gesture tempResampledGest = new Gesture();
    		tempResampledGest.Name = gesture.Name;
    		tempResampledGest.Points = Normalize(gesture.Points);
    		ResampledTemplates.Add(tempResampledGest);
    	}
    	//Debug.Log("HyperGlyph: Finished initialization.");
        Ready = true; 	
    }
	
	static float FindDistance(Vector2 p1, Vector2 p2)
	{
		float dx = p2.x - p1.x;
		float dy = p2.y - p1.y;
		float distance = Mathf.Sqrt((dx * dx) + (dy * dy));
		return distance;
	}		
	
	static Rect FindBounds(List<Vector2> points)
	{
		float minX = Mathf.Infinity;
		float maxX = Mathf.NegativeInfinity; 
		float minY = Mathf.Infinity;
		float maxY = Mathf.NegativeInfinity; 
		for (int i = 0; i < points.Count; i++)
		{
			if (points[i].x < minX)
				minX = points[i].x;
			if (points[i].x > maxX)
				maxX = points[i].x;
			if (points[i].y < minY)
				minY = points[i].y;
			if (points[i].y > maxY)
				maxY = points[i].y;
		}
		Rect bounds = new Rect(minX, minY, (maxX - minX), (maxY - minY));
		return bounds;
	}

	static float FindLength(List<Vector2> points)
	{
		float distance = 0;
		for (int i = 1; i < points.Count; i++)
			distance += FindDistance(points[i - 1], points[i]);
		return distance;
	}
		
	static Vector2 FindCentroid(List<Vector2> points)
	{
		float x = 0.0f, y = 0.0f;
		for (int i = 0; i < points.Count; i++)
		{
			x += points[i].x;
			y += points[i].y;
		}
		x /= points.Count;
		y /= points.Count;
		return new Vector2(x, y);	
	}

	static float FindDirection(List<Vector2> points)
	{
		Vector2 c = FindCentroid(points);
		return  180 - Mathf.Rad2Deg * (Mathf.Atan2((points[0].y - c.y),(points[0].x - c.x)));
	}
	
	static float AverageVetorAngle(List<Vector2> vectorpath)
	{
		float  ang = 0.0f;
		for (int i = 0 ;  i < vectorpath.Count; i++)
		{
			ang += vectorpath[i].x;
		}
		ang /= vectorpath.Count;
		return ang;       
	}

	static List<Vector2> Rotate(List<Vector2> points, float rotation) 
	{
		Vector2 c = FindCentroid(points);
		float cosine = Mathf.Cos(rotation);	
		float sine = Mathf.Sin(rotation);	
		List<Vector2> newPoints = new List<Vector2>();
		for(int i = 1; i < points.Count; i++)
		{
			Vector2 point = (Vector2)points[i];
			float qx = (point.x - c.x) * cosine - (point.y - c.y) * sine + c.x;
			float qy = (point.x - c.x) * sine + (point.y - c.y) * cosine + c.y;
			newPoints.Add( new Vector2(qx, qy));
		}
		return newPoints;
	}

	static List<Vector2> Scale(List<Vector2> points)
	{
		Rect bounds = FindBounds(points);	
		List<Vector2> newPoints = new List<Vector2>();
		float ScaleFactor = (ScaleSize / Mathf.Max(bounds.width,bounds.height));
		for (int i = 0; i < points.Count; i++)
		{
			Vector2 p = (Vector2)points[i];
			float scaledX = p.x * ScaleFactor;
			float scaledY = p.y * ScaleFactor;
			newPoints.Add( new Vector2(scaledX, scaledY));
		}
		return newPoints;
	}
	
	static List<Vector2> Translate(List<Vector2> points,float x, float y)
	{
		Vector2 c = FindCentroid(points);
		List<Vector2> newPoints = new List<Vector2>();
		for (int i = 0; i < points.Count; i++)
		{
			float qx = (points[i].x - c.x) + x;
			float qy = (points[i].y - c.y) + y;
			newPoints.Add(new Vector2(qx, qy));
		}
		return newPoints;
	}
			
	static float VectorPathDifference(List<Vector2> vecs1,List<Vector2> vecs2)
	{
		float difference = 0.0f;
		for (int i = 0; i < vecs1.Count; i++) 
			difference += Mathf.Abs( vecs1[i].x - vecs2[i].x);  

		//Debug.Log("Vec Difference = " + difference/vecs1.Count );

		if(UseDymanicTimeWarp)
		{
			if(difference/vecs1.Count < RejectionWindow)
			{   
				float dwtdif = DTWPathDistance(vecs1,vecs2)/vecs1.Count;
				//Debug.Log("DTW Difference = " + dwtdif/vecs1.Count );       
				return dwtdif/vecs1.Count;
			}
			else
				return Mathf.Infinity;    
		}
		else
		{
			if(difference/vecs1.Count < RejectionWindow)   
			    return difference/vecs1.Count;
			else
				return Mathf.Infinity;
		}     
    }	

    static float DTWPathDistance(List<Vector2> vecs1,List<Vector2> vecs2) 
    {
        int n = vecs1.Count;
        int m = vecs2.Count;
        if ((n > _sn) || (m > _sm))
        {
            _sn = n;
            _sm = m;
            timeWarp = new float[n, m];
            for (int i = 1; i < m; i++)
                timeWarp[0, i] = float.MaxValue;
            for (int i = 1; i < n; i++)
                timeWarp[i, 0] = float.MaxValue;
            timeWarp[0, 0] = 0;
        }
        for (int i = 1; i < n; i++)
        {
            for (int j = 1; j < m; j++)
            {
                float cost = Mathf.Abs( vecs1[i].x - vecs2[i].x);

                timeWarp[i, j] = Mathf.Min(Mathf.Min(
                    timeWarp[i - 1, j] + cost,          
                    timeWarp[i, j - 1] + cost),          
                    timeWarp[i - 1, j - 1] + cost);      
            }
        }
        return timeWarp[n - 1, m - 1];
    }    

	static List<Vector2> Resample(List<Vector2> points)
	{
		float interval = FindLength(points) / (ResampleSize - 1);
		float D = 0.0f;
		List<Vector2> newPoints = new List<Vector2>();
		newPoints.Add(points[0]);
	    for(int i = 1; i < points.Count; i++)
		{
			Vector2 currentPoint  = (Vector2)points[i];
			Vector2 previousPoint = (Vector2)points[i-1];
			float d = FindDistance(previousPoint, currentPoint);
			if ((D + d) >= interval)
			{
				float qx = previousPoint.x + ((interval - D) / d) * (currentPoint.x - previousPoint.x);
				float qy = previousPoint.y + ((interval - D) / d) * (currentPoint.y - previousPoint.y);
				Vector2 temppoint = new Vector2(qx, qy);
				newPoints.Add(temppoint);
				points.Insert(i, temppoint);
				D = 0.0f;
			}
			else D += d;
		}
		if (newPoints.Count == (ResampleSize - 1))
		{
			Vector2 back = (Vector2)points[points.Count -1];
			newPoints.Add( new Vector2(back.x, back.y));
		}
		return newPoints;
	}
	
	static Vector2 Points2Vector(Vector2 p1, Vector2 p2)
	{
		float XMag, YMag, tempAngle, tempMag;
		XMag = p1.x - p2.x;
        YMag = p1.y - p2.y;
		tempMag = Mathf.Sqrt((XMag * XMag) + (YMag * YMag));
		tempAngle = Mathf.Rad2Deg * (Mathf.Atan2((p1.y - p2.y),(p1.x - p2.x)));
		return new Vector2(tempAngle, tempMag);	
	} 	
	
    static List<Vector2> BuildVectors(List<Vector2> points)
	{
        List<Vector2> vectors = new List<Vector2>();
 		for (int i = 1; i < points.Count; i++){
			vectors.Add(Points2Vector(points[i],points[i-1]));   
        }  
        return vectors;
	}   	
	
	static List<Vector2> NormalizeRotation(List<Vector2> points)
	{
       Vector2 c = FindCentroid(points);
	   float rotation = Mathf.Atan2(c.y - points[0].y, c.x - points[0].x);
	   return Rotate(points, -rotation);
	}	
 	
	static List<Vector2> Normalize(List<Vector2> points)
	{  
		List<Vector2> newpoints = new List<Vector2>(points);
	  	newpoints = Resample(newpoints);
		if (rotationInvariant)
	 		newpoints = NormalizeRotation(newpoints);
		newpoints = Scale(newpoints);
		newpoints = Translate(newpoints,0.0f,0.0f);
		return newpoints;
	}

    /// <summary>
    /// Adds a point to the recognizer's internal temporary input path storage.
    /// It is designed to take mouse and touch positions. (Where (0,0) is to bottom left of the screen)
    /// </summary>
    /// <param name="point"> Usually you will be  calling this function from inside of Update\n
    /// and passing Input.mousePosition or Touch.position as the parameter.</param>
	public static void AddPoint(Vector2 point)
	{
		InputPath.Add(new Vector2 (point.x,Screen.height - point.y));
	}

    /// <summary>
    /// Clears the recognizer's internal temporary input path storage.\n
    /// It will be cleared automatically when you call Recognize()\n
    /// But if you ever need to clear it manually you can call this 
    /// </summary>
	public static void ClearPoints()
	{
		InputPath.Clear();
	}	

    /// <summary>
    /// This will run the recognizer on whatever is stored in it's internal path storage and return the results.\n
    /// After the recognition is run the internal path will be cleared.
    /// </summary>
    /// <returns>The results of the recognition.</returns>
	public static HyperGlyphResult Recognize()
	{
		result = Recognize(InputPath);
		InputPath.Clear();
		return result;
	}
	
    /// <summary>
    /// This will run the recognizer on a given list of points and return the results.\n
    /// After the recognition is run the internal path will be cleared.
    /// You can use this function if you are building your own paths of points,
    /// maybe from Kinect, Plastation move, or other input devices. 
    /// </summary>
    /// <returns>The results of the recognition.</returns>	
	public static  HyperGlyphResult Recognize(List<Vector2> points)
	{
		HyperGlyphResult result = new HyperGlyphResult();
		result.bounds = FindBounds(points);
		result.direction =FindDirection(points);

		int indexOfBestMatch = -1;
		float score = 0;

		if (ResampledTemplates.Count == 0)
		{
			Debug.LogWarning("No templates loaded so no glyphs to match.\n");
			result.glyphname = "Unknown";
			result.score = 0.0f;
			return result;
		}
		if(!Ready)
		{
			Debug.LogWarning("Recognizer Not ready.\n");
			result.glyphname = "Recognizer Not ready";
			result.score = 0.0f;
			return result;				
		}

		points = Normalize(points);
		
		List<Vector2> tempvectors = new List<Vector2>();
		List<Vector2>  vectors = BuildVectors(points);
		
		float bestDifference = Mathf.Infinity;
		   
		for (int i = 0; i < ResampledTemplates.Count; i++)
		{
			tempvectors = BuildVectors(ResampledTemplates[i].Points);
			//Debug.Log("Template: " +ResampledTemplates[i].Name);
			float difference = VectorPathDifference(vectors, tempvectors); 
			
		  	if (difference < bestDifference)
			{
				bestDifference = difference;
				indexOfBestMatch = i;
			} 
		}
           
		score = Mathf.Abs((1.0f - (bestDifference/180.0f)) * 100.0f);
        
		if (-1 == indexOfBestMatch)
		{
			//Debug.Log("Couldn't find a good match.\n");
			result.glyphname = "Unknown";
			result.score = 0.0f;
			return result;
		}
		//Debug.Log("Best match found is " + ResampledTemplates[indexOfBestMatch].Name + " Confidence = " + score + "%"); 
		result.glyphname = ResampledTemplates[indexOfBestMatch].Name;
		result.score = score;
		return result;
	}	 
}
