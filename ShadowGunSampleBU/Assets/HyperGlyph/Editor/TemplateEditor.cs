using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;

/// A class that implements a custom Unity utility window for editing GestureTemplates.
public class TemplateEditor : EditorWindow 
{
	static EditorWindow window = null;
	static List<Vector2> InputPoints;
	static List<Vector2> TemplatePoints;
	private bool isDrawing = false;
	public static Color GridColor;
	public static Color LineColor;
	public static Color TemplateColor;
	public static float GridBoost = 2.5f;

	public static Gesture Template;

	public static void Init(Gesture template)
	{
		if(window != null)
		{
			window.ShowNotification(new GUIContent("Please close this " + Template.Name +" template editor\nbefore editing template " + template.Name+"."));
			window.Repaint();
			return;
		}
			

		Template = template;
		window = ScriptableObject.CreateInstance<TemplateEditor>();
		window.position = new Rect(Screen.width/2,Screen.height/2, 800, 600);
		window.minSize = new Vector2(400,300);
		window.wantsMouseMove = true;
		window.title = Template.Name + " - HyperGlyph Gesture Template Editor";
		window.ShowUtility();

		Template.openforedit = true;

		InputPoints = new List<Vector2>();

		if(Template.Points == null)
			TemplatePoints = new List<Vector2>();
		else
			TemplatePoints = Template.Points;

		setColors();
	}

	private static void setColors()
	{
		if( EditorGUIUtility.isProSkin)
		{
			float c = 75.0f/255.0f;
			GridColor = new Color(c,c,c,c);
			LineColor = new Color(166/255.0f,226/255.0f,46/255.0f);
			TemplateColor = new Color(102/255.0f,217/255.0f,239/255.0f);
		}
		else
		{
			GridColor = new Color(97/255.0f,111/255.0f,135/255.0f,75/255.0f);
			GridBoost = 1.5f;
			LineColor = new Color(223/255.0f,78/255.0f,42/255.0f);
			TemplateColor = new Color(86/255.0f,106/255.0f,206/255.0f);
		}
	}

	public void Update()
	{
		if(isDrawing)
			Repaint();
	}

    void OnGUI()
    {
    	if(TemplatePoints.Count <= 3 && InputPoints.Count <= 0)
    		window.ShowNotification(new GUIContent("Draw your gesture template\n anywhere in this window."));
    	HandleMouseEvents();
    	HyperDraw.Grid(new Rect(0,0,Screen.width,Screen.height),GridColor,1.0f,GridBoost);
    	HyperDraw.Path(TemplatePoints,TemplateColor,2.5f);
    	HyperDraw.Path(InputPoints,LineColor,2.5f);
    }

    void OnDestroy() 
    {
    	Template.openforedit = false;
    }

	public void HandleMouseEvents()
	{
		if(Event.current.type == EventType.MouseDrag)
		{
			window.RemoveNotification();
			InputPoints.Add(Event.current.mousePosition);
			isDrawing = true;
		}
		if(Event.current.type == EventType.MouseUp && Event.current.button == 0)
		{
			TemplatePoints = new List<Vector2>(InputPoints);
			Template.Points = new List<Vector2>(TemplatePoints);
			InputPoints.Clear();
			isDrawing = false;
		}	
		if (Event.current.type == EventType.MouseMove)
            Repaint ();
	}
}
