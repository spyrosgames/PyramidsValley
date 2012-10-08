using UnityEngine;
using System.Collections;
using System.Collections.Generic;

/// A small data structure class hold that values for Gestures and GestureTemplates.
[System.Serializable]
public class Gesture
{
	///The human readable name of the gesture template.
	public string Name;
	///The raw recorded input points that represent the gesture template.
	public List<Vector2> Points;
	///This is used internally to handle editor windows.
	[HideInInspector]
	public bool openforedit = false;
}

///A ScriptableObject class that represents collections of gesture templates. 
///As well as settings to initialize the HyperGlyph recognizer with.
public class GestureSet: ScriptableObject
{
	/**
	This is the number of vectors all input and template gestures will be resampled to.\n
	The larger this number is the slower the recognizer runs. You want to smallest value\n
	that give good results.\n
	*/
	//public  int ResampleSize = 64;
	public  int ResampleSize = 16;
	/**
	All input and template gestures will be resized (preserving aspect ratio) to fit inside a box of this size.\n
	Changing this value makes very little difference in the recognition process.\n
	The default value can almost always be used to produce good results.\n
	But if you have some very nuanced very curvy shapes as templates it may help to set it larger.\n
	Likewise if all you templates are very simple shapes and you are taking in input from a low res screen\n
	feel free to set it smaller.
	*/	
	public  float ScaleSize = 512.0f;
	//public  float ScaleSize = 64.0f;

	/**
	The smaller this value is the more closely the input needs to be to the template be accepted as a match.\n
	How strict do you want the recognizer to be while matching input to templates?\n
	Depending on your template set, values between 25 and 75 tend to produce the best results.\n
	If this value is set too low the recognizer may reject some good matches. \n
	If it is set too high the recognizer may accept some false positives.\n
	*/
	public  int RejectionWindow = 60;
	//public  int RejectionWindow = 15;
	/**
	If set true the recognizer will preform an additional elastic matching based comparison.
	This greatly increase the recognizer's accuracy but warps the input in the process.\n
	This can make it difficult to determine how well the input gesture was preformed based\n
	off the match score. If you intend to give users feedback or ratings on how well their drawn\n
	input matches your templates you may want to turn this off.
	*/	
	public  bool UseDymanicTimeWarp = true;
	/**
	If set true input gestures will be accepted no matter how they are rotated.\n
	Accuracy is increased by leaving this enabled. If you need to differentiate \n
	between two gestures that are the same shape but differ in rotation. For example\n
	and line to the top right corner and a line to the bottom right corner (slashUp and slashDown)\n
	it is better to leave rotationInvariant turned on and only have 1 line template\n
	Then determine the direction after the recognition happens through checking, HyperGlyphResult.direction.
	*/	
	public  bool rotationInvariant = true;

	///This is the collection of templates stored in this gesture set.
	public List<Gesture> Templates;


    /// <summary>
    /// Creates a new gesture template and adds it to the GestureSet.
    /// </summary>
    /// <returns>The newly created Gesture</returns>
	public Gesture AddTemplate()
	{
		Gesture newGesture = new Gesture();
		Templates.Add(newGesture);
		return newGesture;
	}

    /// <summary>
    /// Creates a new gesture template and adds it to the GestureSet.
    /// </summary>
    /// <param name="name">The new gesture will be created with this as it's name</param>
    /// <returns>The newly created Gesture</returns>
	public Gesture AddTemplate(string name)
	{
		Gesture newGesture = new Gesture();
		newGesture.Name = name;
		Templates.Add(newGesture);
		return newGesture;
	}

    /// <summary>
    /// Removes the given gesture from the GestureSet.
    /// </summary>
    /// <param name="remove">The gesture that is to be removed.</param>
    /// <returns>If the GestureSet contains any other gestures after the given gesture is removed\n
    ///          this function will return the gesture that was previous to the removed gesture.\n
    ///          If the set is now empty this function will return null. 
    /// </returns>
	public Gesture RemoveTemplate(Gesture remove)
	{
		int newIndex = Templates.IndexOf(remove) -1;
		Templates.Remove(remove);
		if(newIndex<0)
		{
			if(Templates.Count > 0)
				return Templates[0];
			else
				return null;
		}
		return Templates[newIndex];
	}
}
