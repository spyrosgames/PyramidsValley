using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.Reflection;

/// A class that implements a custom Unity inspector for editing GestureSets.
[CustomEditor(typeof(GestureSet))]
public class GestureSetEditor : Editor
{
	string[] views;
	int view;

	Texture2D titleBack = null;
	Texture2D HelpButtonNormal;
	Texture2D HelpButtonPressed;
	Texture2D MiniLogo;
	Texture2D NameLeft;
	Texture2D NameRight;
	Texture2D NameBack;
	Texture2D DeleteTex;
	Texture2D ViewTex;
	Texture2D EditTex;
	bool TexturesLoaded = false;

	//Dictionary<string, int> Stats = new Dictionary<string, int>();

	Dictionary<string, bool> DisplayOptions = new Dictionary<string, bool>();

	bool ShowHelp = false;

	bool ShowNewGesureWindow = false;
	string BaseGestureName = "";

	Gesture SelectedTemplate = null;

	static Rect PreviewBounds = new Rect(0,0,0,0);

	private GestureSet Set;
	GUIStyle TemplateName;
	GUIStyle NameRightStyle;
	GUIStyle NameLeftStyle;
	GUIStyle TitleStyle;
	GUIStyle MiniLogoStyle;
	GUIStyle HelpButtonText;
	GUIStyle HelpButtonTitle;
	GUIStyle HelpButtonStyle;
	GUIStyle toolbarStyle;
	GUIStyle NiceButton;
	GUIStyle NicePopup;
	GUIStyle PreviewPopup;
	bool StylesBuilt = false;

	Color StripeColor;
	Color SelectedColor;
	Color BoxColor;
	Color TemplatePreviewColor;
	Color PointColor;
	Color CenterColor;

	bool SettingOpen = false;
	int SelectedGestureIndex = 0;

	string[] scaleSizeDecs = new string[3] {"Normal","Large","Small"};
	int[] scaleSizeValues = new int[3] {512,1024,256};

	void Awake()
    {
    	views = new string[2]{"Gesture Template", "Vectorized Resample"};
    	view = 0;
		Set=(GestureSet)target;
		SetColors();
		LoadTextures();
		BuildStyles();
		SetupDisplayOptions();
	}

	void SetColors()
	{
		StripeColor = new Color(210/255.0f,230/255.0f,1.0f);
		SelectedColor = new Color(1.0f,194/255.0f,221/255.0f);
		BoxColor = new Color(249/255.0f,100/255.0f,170/255.0f);
		TemplatePreviewColor = new Color(102/255.0f,217/255.0f,239/255.0f);
		PointColor = new Color(166/255.0f,226/255.0f,46/255.0f);
		CenterColor = new Color(246/255.0f,157/255.0f,70/255.0f);

		if( EditorGUIUtility.isProSkin)
		{
			StripeColor = new Color(210/255.0f,230/255.0f,1.0f);
			SelectedColor = new Color(1.0f,194/255.0f,221/255.0f);
		}
		else
		{
			StripeColor = new Color(185/255.0f,208/255.0f,238/255.0f);
			SelectedColor = new Color(1.0f,226/255.0f,145/255.0f);
		}
	}

	void LoadTextures()
	{
		float c;
		if(! TexturesLoaded)
		{
			if( EditorGUIUtility.isProSkin)
			{
				NameLeft = (Texture2D)UnityEngine.Resources.Load( "NameLeft", typeof( Texture2D ) );
				NameRight = (Texture2D)UnityEngine.Resources.Load( "NameRight", typeof( Texture2D ) );
				NameBack = (Texture2D)UnityEngine.Resources.Load( "NameBack", typeof( Texture2D ) );
				DeleteTex = (Texture2D)UnityEngine.Resources.Load( "delete", typeof( Texture2D ) );
				c = 81.0f/255.0f;
			}
			else
			{
				NameLeft = (Texture2D)UnityEngine.Resources.Load( "LightNameLeft", typeof( Texture2D ) );
				NameRight = (Texture2D)UnityEngine.Resources.Load( "LightNameRight", typeof( Texture2D ) );
				NameBack = (Texture2D)UnityEngine.Resources.Load( "LightNameback", typeof( Texture2D ) );
				DeleteTex = (Texture2D)UnityEngine.Resources.Load( "Lightdelete", typeof( Texture2D ) );
				c = 150.0f/255.0f;
			}

			HelpButtonPressed = (Texture2D)UnityEngine.Resources.Load( "HelpPushed", typeof( Texture2D ) );
			HelpButtonNormal = (Texture2D)UnityEngine.Resources.Load( "Help", typeof( Texture2D ) );
			MiniLogo = (Texture2D)UnityEngine.Resources.Load( "HyperGlyphMiniLogo", typeof( Texture2D ) );
			ViewTex = (Texture2D)UnityEngine.Resources.Load( "view", typeof( Texture2D ) );
			EditTex = (Texture2D)UnityEngine.Resources.Load( "edit", typeof( Texture2D ) );

            titleBack = new Texture2D(1, 1, TextureFormat.ARGB32, true);
            titleBack.SetPixel(0, 1, new Color(c,c,c));
            titleBack.Apply();

            TexturesLoaded = true;
        }
	}

	void BuildStyles()
	{
		if(!StylesBuilt)
		{
			HelpButtonStyle = new GUIStyle();
			HelpButtonStyle.fixedHeight = 18;
			HelpButtonStyle.fixedWidth = 18;
			HelpButtonStyle.alignment = TextAnchor.MiddleRight;
			HelpButtonStyle.margin.top = 3;
			HelpButtonStyle.margin.left = 7;
			HelpButtonStyle.margin.right = -5;
			HelpButtonStyle.normal.background = HelpButtonNormal;

			TemplateName = new GUIStyle();
			TemplateName.normal.background = NameBack;
			TemplateName.active.background = NameBack;
			TemplateName.focused.background = NameBack;
			TemplateName.alignment = TextAnchor.MiddleCenter;
			TemplateName.fixedHeight = 16;
			TemplateName.margin.right = 0;
			TemplateName.margin.left = 0;
			TemplateName.margin.top = 4;
			if(EditorGUIUtility.isProSkin)
			{
				float c = 180.0f/255.0f;
				Color lightgrey =  new Color(c,c,c);
				TemplateName.normal.textColor = lightgrey;
				TemplateName.active.textColor = lightgrey;
				TemplateName.focused.textColor = lightgrey;
			}

			NameRightStyle = new GUIStyle();
			NameRightStyle.margin.left = -7;
			NameRightStyle.margin.top = 4;
			NameRightStyle.fixedHeight = TemplateName.fixedHeight;
			NameRightStyle.fixedWidth = 12;
			NameRightStyle.stretchHeight = false;
			NameRightStyle.stretchWidth= true;
			NameRightStyle.normal.background = NameRight;

			NameLeftStyle = new GUIStyle(NameRightStyle);
			NameLeftStyle.normal.background = NameLeft;
			NameLeftStyle.margin.left = -3;

			MiniLogoStyle = new GUIStyle();
			MiniLogoStyle.normal.background = MiniLogo;
			MiniLogoStyle.margin.top = 0;
			MiniLogoStyle.fixedHeight = 15;
			MiniLogoStyle.fixedWidth = 18;

			StylesBuilt = true;
		}
	}

	void SetupDisplayOptions()
	{
		DisplayOptions.Add("Show Bounding Box",false);
		DisplayOptions.Add("Show Template's Centroid",false);
		DisplayOptions.Add("Show Rawish Input Points",false);
		DisplayOptions.Add("Show Resampled Points",false);
		DisplayOptions.Add("",false);
		DisplayOptions.Add("Use AntiAliasing",true);
	}

	public override void OnInspectorGUI()
	{
		if(EditorApplication.isPlaying)
		{
			EditorGUILayout.HelpBox("You cannot edit the gesture set while in Play mode.",MessageType.Warning);
			return;
		} 
		DisplayTitle();
		GUILayout.Space (4);
		DisplaySettings();
		DisplayHelp();
        DisplayTemplateList();

        if (GUI.changed)
        	EditorUtility.SetDirty(Set);
	}

	void DisplayTitle()
	{
		TitleStyle = new GUIStyle(EditorStyles.toolbarButton);
		TitleStyle.font = EditorStyles.boldFont;
		TitleStyle.normal.background = null;
		TitleStyle.active.background = titleBack;
		TitleStyle.alignment = TextAnchor.UpperLeft;
		TitleStyle.overflow.left = 60;
		TitleStyle.overflow.right = 60;
		TitleStyle.overflow.top = 3;
		TitleStyle.margin.top = -7;
		TitleStyle.margin.bottom = -5;

		HelpButtonText = new GUIStyle(EditorStyles.label);
		HelpButtonText.alignment = TextAnchor.UpperRight;
		HelpButtonText.font = EditorStyles.miniFont;
		HelpButtonText.margin.top = -5;

		HelpButtonTitle = new GUIStyle();
		HelpButtonTitle.fixedHeight = 18;
		HelpButtonTitle.fixedWidth = 18;
		HelpButtonTitle.alignment = TextAnchor.UpperRight;
		HelpButtonTitle.margin.top = -7;
		HelpButtonTitle.normal.background = HelpButtonNormal;
		HelpButtonTitle.active.background = HelpButtonPressed;

		EditorGUILayout.BeginHorizontal();
		GUILayout.Space (48);
		if( GUILayout.Button("HyperGlyph Settings",TitleStyle))
			SettingOpen = !SettingOpen;

		if( GUILayout.Button("Help",HelpButtonText,GUILayout.MaxWidth(30)) 
			|| GUILayout.Button("",HelpButtonTitle,GUILayout.MaxWidth(22)))
		{
			ShowHelp = !ShowHelp;
			//if(ShowHelp)
			//	SettingOpen = true;
		}

		GUILayout.EndHorizontal();
		if(EditorApplication.isPlaying)
			return;
		SettingOpen = EditorGUI.Foldout(new Rect(4,50,15,15),SettingOpen, "",EditorStyles.foldout);
		GUI.Label(new Rect(23,52,17,17),"",MiniLogoStyle);
	}

	void DisplaySettings()
	{
		if(SettingOpen)
		{
			//DisplayStats();
			Set.ResampleSize = EditorGUILayout.IntSlider(new GUIContent ("Points in Resample:", "The larger this value is the slower the recognizer runs. You want the smallest value that gives good results.\nSuggested default: 64"), Set.ResampleSize,8,256);
			GUILayout.Space (4);

			Set.RejectionWindow = EditorGUILayout.IntSlider(new GUIContent ("Rejection Window:", "How strict do you want the recognizer to be while matching input to templates? Values between 25 and 75 tend to produce the best results.  If this value is set too low the recognizer may reject some good matches.  If it is set too high the recognizer may accept some false positives.\nSuggested default: 45"),Set.RejectionWindow, 1, 180);
			GUILayout.Space (4);
	
		    EditorGUILayout.BeginHorizontal();
			Set.ScaleSize = (float)EditorGUILayout. IntPopup("Normalization Size:", (int)Set.ScaleSize,scaleSizeDecs,scaleSizeValues);
			Set.ScaleSize = EditorGUILayout.FloatField(Set.ScaleSize,GUILayout.MaxWidth(50));
			GUILayout.EndHorizontal();
			GUILayout.Space (4);

			EditorGUILayout.BeginHorizontal();
			GUILayout.Label(new GUIContent ("Rotation Invariant:", "If set true input gestures will be accepted no matter how they are rotated. See online docs for more notes."),GUILayout.MaxWidth(115));
			Set.rotationInvariant = EditorGUILayout.Toggle( Set.rotationInvariant,GUILayout.MaxWidth(15));
			GUILayout.FlexibleSpace();
			string warpstring = (Screen.width > 299) ? "Dymanic Time Warp:" : "Dymanic Warp:";
			GUILayout.Label(new GUIContent (warpstring, "If set true the recognizer will preform an additional elastic matching based comparison. See online docs for more notes."),GUILayout.MaxWidth((Screen.width > 299)?130:95));
			Set.UseDymanicTimeWarp = EditorGUILayout.Toggle(Set.UseDymanicTimeWarp,GUILayout.MaxWidth(15));
			GUILayout.FlexibleSpace();
			GUILayout.EndHorizontal();
			
			GUILayout.Space (8);
		}
	}

	void DisplayHelp()
	{
		if(ShowHelp)
		{

			GUIStyle helptext = new GUIStyle(EditorStyles.miniLabel);
			helptext.alignment = TextAnchor.UpperCenter;

			GUILayout.Label("Welcome to HyperGlyph\nGesture Recognition System.\nv1.0 Developed by\nJacob Pennock\nUnicorn Forest Games 2012",helptext);
			if(GUILayout.Button("Open Online Script Reference"))
				Application.OpenURL("http://unicornforestgames.com/UnityPlugins/HyperGlyph/ScriptReference/");

			GUILayout.Space (4);
			string HelpMessage = "You can click the title bar above to configure various options of the recognizer. All of the options have tooltips to explain what they are for.\n\nYou can create new gestures by clicking the button on the toolbar below to the right. The dropdown on the left lets to filter your gestures by gesture name.";

			EditorGUILayout.HelpBox(HelpMessage,MessageType.Info);
		}
	}

	/*
	void DisplayStats()
	{	
		foreach(Gesture template in Set.Templates)
		{
			if (Stats.ContainsKey(template.Name))
				Stats[template.Name]++;
			else
				Stats.Add(template.Name,1);
		}
		string StatsInfo = "This Gesture Set Contains:\n"+
							Stats.Count + " Unique Gestures with\n"+
							Set.Templates.Count + " total templates between them.";

		GUILayout.Label(StatsInfo,CenterMiniLabel);
	}*/

	void DisplayTemplateList()
	{
		toolbarStyle = new GUIStyle( EditorStyles.toolbar );
		toolbarStyle.fixedHeight = 25;

		NiceButton = new GUIStyle(EditorStyles.toolbarButton);
		NiceButton.fixedHeight = 25;
		NiceButton.font = EditorStyles.miniFont;

		NicePopup = new GUIStyle(EditorStyles.toolbarPopup);
		NicePopup.fixedHeight = 25;
		NicePopup.fontSize = 16;
		NicePopup.alignment = TextAnchor.MiddleCenter;

		Gesture removedTemplate = null;

 		EditorGUILayout.BeginHorizontal(toolbarStyle);

 		string[] GestureNames = new string[Set.Templates.Count+1];
 		GestureNames[0] = (Screen.width > 299) ? "All Templates" : "All";

 		for(int i = 0; i<Set.Templates.Count; i++)
		{
			GestureNames[i+1] = Set.Templates[i].Name;
		}

 		SelectedGestureIndex = EditorGUILayout.Popup(SelectedGestureIndex,GestureNames,NicePopup,GUILayout.MinHeight(25));

 		if(SelectedGestureIndex == 0)
 			GUI.enabled = false;
 		if(GUILayout.Button("Add Template",NiceButton))
 		{
 			if(SelectedGestureIndex != 0 )
 			{
 				if(GestureNames[SelectedGestureIndex] != null)
 				{
 					SelectedTemplate = Set.AddTemplate(GestureNames[SelectedGestureIndex]);
 					TemplateEditor.Init(SelectedTemplate);
 				}
 			}
 		}
 		GUI.enabled = true;
 					
 		if(GUILayout.Button("New Gesture",NiceButton))
 			ShowNewGesureWindow = !ShowNewGesureWindow;

		GUILayout.EndHorizontal();

		if(ShowNewGesureWindow)
			DisplayNewGestureWindow();

		GUILayout.Space(2);

		int Stripe = 0;

		foreach(Gesture template in Set.Templates)
		{
			if(template.Name == GestureNames[SelectedGestureIndex] || SelectedGestureIndex == 0 )
			{
				Stripe++;
				if(Stripe%2==0)
					GUI.backgroundColor = StripeColor;
				if(template == SelectedTemplate)
					GUI.backgroundColor = SelectedColor;

		 		EditorGUILayout.BeginHorizontal(toolbarStyle);

		 		if(GUILayout.Button(new GUIContent("View",ViewTex),NiceButton,GUILayout.Width(60),GUILayout.Height(25)))
		 		{
		 			SelectedTemplate = template;
		 		}
		 		
	 			if(GUILayout.Button(new GUIContent("Edit",EditTex),NiceButton,GUILayout.Width(60),GUILayout.Height(25)))
	 			{
	 				SelectedTemplate = template;
	 				if(!template.openforedit)
	 					TemplateEditor.Init(template);
	 			}

	 			GUILayout.Space(4);
	 			GUILayout.Label("",NameLeftStyle);
	 			template.Name = GUILayout.TextField(template.Name,TemplateName);
	 			GUILayout.Label("",NameRightStyle);

	 			GUILayout.Space(4);
	 			//GUI.contentColor = DeleteColor;
	 			if(GUILayout.Button(DeleteTex,NiceButton,GUILayout.Height(25),GUILayout.Width(30)))
	 				removedTemplate = template;
	 			//GUI.contentColor = Color.white;

	 			GUILayout.EndHorizontal();
	 			GUILayout.Space(2);
	 		}
	 		GUI.backgroundColor = Color.white;
		}
		GUI.backgroundColor = Color.white;
		if(removedTemplate != null)
		{
			SelectedTemplate = Set.RemoveTemplate(removedTemplate);
			EditorUtility.SetDirty(Set);
		}
			
	}

	void DisplayNewGestureWindow()
	{
		string [] ExistingGestures = new string[Set.Templates.Count + 1];
		ExistingGestures[0] = "None Selected";
 		for(int i = 0; i<Set.Templates.Count; i++)
		{
			ExistingGestures[i+1] = Set.Templates[i].Name;
		}

    	GUILayout.Space(5);
    	GUIStyle NiceLabel = new GUIStyle(EditorStyles.largeLabel);
    	GUIStyle NiceBold = new GUIStyle(EditorStyles.boldLabel);
    	GUIStyle NiceText = new GUIStyle(EditorStyles.textField);
    	GUIStyle NiceDropdown = new GUIStyle(EditorStyles.popup);
		//NiceDropdown.fixedHeight = 25;
		NiceDropdown.alignment = TextAnchor.MiddleCenter;
    	NiceLabel.alignment = TextAnchor.MiddleCenter;
    	NiceLabel.wordWrap = true;
    	NiceLabel.fontSize = 16;
    	NiceBold.fontSize = 14;
    	NiceText.fontSize = 14;
    	NiceText.alignment = TextAnchor.MiddleLeft;
    	NiceText.font = EditorStyles.boldFont;
    	NiceText.padding.left = 8;

    	GUILayout.Label("Please enter a name for your new Gesture.",NiceLabel);
    	GUILayout.Space(5);
    	EditorGUILayout.BeginHorizontal();
    	GUILayout.FlexibleSpace();
    	GUILayout.Label("New Gesture : ",NiceBold,GUILayout.MaxWidth(120));
    	BaseGestureName = EditorGUILayout.TextField(BaseGestureName,NiceText,GUILayout.MinHeight(24));
    	GUILayout.FlexibleSpace();
    	EditorGUILayout.EndHorizontal();

    	GUILayout.Space(8);//GUILayout.MaxWidth(200)
    	EditorGUILayout.BeginHorizontal();
    	GUILayout.FlexibleSpace();
    	GUILayout.Label("Or if you would like to add an additional template to an existing gesture please select it in the drop down menu.",NiceLabel,GUILayout.MaxWidth(350));
    	GUILayout.FlexibleSpace();
    	EditorGUILayout.EndHorizontal();
    	//GUILayout.Space(8);
    	EditorGUILayout.BeginHorizontal();
    	GUILayout.FlexibleSpace();
    	SelectedGestureIndex = EditorGUILayout.Popup(SelectedGestureIndex,ExistingGestures,NiceDropdown,GUILayout.MinWidth(250));
    	GUILayout.FlexibleSpace();
    	EditorGUILayout.EndHorizontal();
    	GUILayout.Space(15);

    	EditorGUILayout.BeginHorizontal();
    	GUILayout.Space(5);
    	GUILayout.FlexibleSpace();
    	if(GUILayout.Button("Cancel",GUILayout.MinHeight(45),GUILayout.MinWidth(120)))
    		ShowNewGesureWindow = false;
		GUILayout.FlexibleSpace();
    	if(GUILayout.Button("Create",GUILayout.MinHeight(45),GUILayout.MinWidth(120)))
    	{
    		if(SelectedGestureIndex != 0)
    		{
    			SelectedTemplate = Set.AddTemplate(ExistingGestures[SelectedGestureIndex]);
 				TemplateEditor.Init(SelectedTemplate);
 				ShowNewGesureWindow = false;
    		}
    		else 
    		if(BaseGestureName != "")
    		{
    			SelectedTemplate = Set.AddTemplate(BaseGestureName);
 				TemplateEditor.Init(SelectedTemplate);
 				ShowNewGesureWindow = false;
    		}
    	}
    	GUILayout.FlexibleSpace();
    	EditorGUILayout.EndHorizontal();
    	GUILayout.Space(10);
	}

	public override GUIContent GetPreviewTitle()
	{
		if(SelectedTemplate == null)
			return new GUIContent("Select a Template to Preview.");
		else
			return new GUIContent(SelectedTemplate.Name);
	}

	public override bool HasPreviewGUI()
	{
		return true;
	}

	public override void OnPreviewGUI(Rect r, GUIStyle background)
	{

		PreviewPopup = new GUIStyle(EditorStyles.toolbarPopup);
		PreviewPopup.fixedHeight = 16;
		PreviewPopup.margin.top = 1;
		PreviewPopup.alignment = TextAnchor.MiddleCenter;

		if( r.y >= 100.0f)
		{
			PreviewBounds.x = Screen.width - 120;
			PreviewBounds.y = r.y;
			PreviewBounds.height = 1;
			PreviewBounds.width= 1;
		}

		float c = 75.0f/255.0f;
		Color GridColor = new Color(c,c,c,c);
		HyperDraw.Grid(r,GridColor,1.0f,2.5f);

		if(SelectedTemplate != null && SelectedTemplate.Points != null && SelectedTemplate.Points.Count >= 3)
		{
	    	List<Vector2> PreviewPath = scaleToPreview(SelectedTemplate.Points, r);
	    	PreviewPath = translatePath(PreviewPath,r );
			switch(view)
			{
				case 0:
					HyperDraw.Path(PreviewPath,TemplatePreviewColor,2.5f);
				break;
				case 1:
					HyperDraw.VectorPath(resample(PreviewPath),new Color(169/255.0f,100/255.0f,213/255.0f),new Color(130/255.0f,132/255.0f,225/255.0f));
				break;
			}
			DrawSelectedDisplayOptions(PreviewPath);
		}
	}

	public override void OnPreviewSettings()
	{
		if(SelectedTemplate != null)
		{
			GUIStyle SettingsLabel = new GUIStyle(EditorStyles.miniLabel);
			SettingsLabel.alignment = TextAnchor.UpperRight;
			SettingsLabel.margin.top = 2;

			GUILayout.Label("Preview:",SettingsLabel);
			view = EditorGUILayout.Popup(view,views,PreviewPopup);

			if(GUILayout.Button("Display Options",PreviewPopup))
			{
				List<string> items = new List<string>(DisplayOptions.Keys);
				List<int> selected = new List<int>();
				for(int i = 0; i < DisplayOptions.Count; i++)
				{
					if(DisplayOptions[items[i]])
						selected.Add(i);
				}

				object[] param = new object[ 5 ];
				param[ 0 ] = new Rect( Screen.width - 100, PreviewBounds.y, 1, 1 ); //PreviewBounds
				param[ 1 ] = items.ToArray();
				param[ 2 ] = selected.ToArray();
				param[ 3 ] = new EditorUtility.SelectMenuItemFunction( SetDisplayOptionsDelegate );
				param[ 4 ] = null;

				typeof( EditorUtility ).InvokeMember( "DisplayCustomMenu", BindingFlags.InvokeMethod | BindingFlags.NonPublic, null, typeof( EditorUtility ), param );			
			}
			GUILayout.Space (2);
		}
	}  

	private void SetDisplayOptionsDelegate( object userData, string[] options, int selected )
	{
		List<string> option = new List<string>(DisplayOptions.Keys);
			DisplayOptions[option[selected]] = !DisplayOptions[option[selected]];
	} 
	
    void DrawSelectedDisplayOptions(List<Vector2> template)
    {
    	if(!DisplayOptions.ContainsKey(""))
    		return;
    	if(DisplayOptions["Show Bounding Box"])
    		HyperDraw.Box(boundingBox(template),BoxColor,1.0f);
    	if(DisplayOptions["Show Template's Centroid"])
    		Drawcentroid(template, CenterColor );
    	if(DisplayOptions["Show Rawish Input Points"])
    		HyperDraw.Points(template,PointColor);
    	if(DisplayOptions["Show Resampled Points"])
    		HyperDraw.Points(resample(template), new Color(169/255.0f,100/255.0f,213/255.0f));
    }

	List<Vector2> scaleToPreview(List<Vector2> points, Rect PreviewRect)
	{
		Rect boundingbox = boundingBox(points);	
		List<Vector2> newPoints = new List<Vector2>();

		float ScaleSize = Mathf.Min(PreviewRect.width,PreviewRect.height);

		float ScaleFactor = (ScaleSize / Mathf.Max(boundingbox.width,boundingbox.height ));
		
		for (int i = 0; i < points.Count; i++)
		{
			Vector2 p = (Vector2)points[i];
			float scaledX = p.x * ScaleFactor;
			float scaledY = p.y * ScaleFactor;

			newPoints.Add( new Vector2(scaledX, scaledY));
		}
		return newPoints;
	}

  	List<Vector2> translatePath(List<Vector2> points, Rect PreviewBounds)
	{
		float x = PreviewBounds.x + PreviewBounds.width/2.0f;
		float y = PreviewBounds.y + PreviewBounds.height/2.0f;

		Rect TemplateBounds = boundingBox(points);
		Vector2 c = new Vector2(TemplateBounds.x + TemplateBounds.width/2.0f,TemplateBounds.y + TemplateBounds.height/2.0f );

		List<Vector2> newPoints = new List<Vector2>();
		for (int i = 0; i < points.Count; i++)
		{
			float qx = (points[i].x - c.x) + x;
			float qy = (points[i].y - c.y) + y;
			newPoints.Add(new Vector2(qx, qy));
		}
		return newPoints;
	}

  	Vector2 centroid(List<Vector2> points)
	{
		float x = 0.0f, y = 0.0f;
		for (int i = 0; i < points.Count; i++)
		{
			x += points[i].x;
			y += points[i].y;
		}
		x /= points.Count;
		y /= points.Count;

		return new Vector2(x , y);	
	}

	void Drawcentroid(List<Vector2> points, Color color)
	{
		Vector2 center = centroid(points);
		HyperDraw.Line(new Vector2( center.x-2,center.y), new Vector2(center.x+2,center.y), color,3.0f, true);
		HyperDraw.Line(new Vector2( center.x,center.y-2), new Vector2(center.x,center.y+2), color,3.0f, true);
		HyperDraw.Line(new Vector2( center.x-6,center.y), new Vector2(center.x+6,center.y), color,1.0f, true);
		HyperDraw.Line(new Vector2( center.x,center.y-6), new Vector2(center.x,center.y+6), color,1.0f, true);
	}

	List<Vector2> resample(List<Vector2> points)
	{
		float interval = pathLength(points) / (Set.ResampleSize - 1); 
		float D = 0.0f;
		List<Vector2> newPoints = new List<Vector2>();

		newPoints.Add(points[0]);
	    for(int i = 1; i < points.Count; i++)
		{
			Vector2 currentPoint  = (Vector2)points[i];
			Vector2 previousPoint = (Vector2)points[i-1];
			float d = getDistance(previousPoint, currentPoint);
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

		if (newPoints.Count == (Set.ResampleSize- 1))
		{
			Vector2 back = (Vector2)points[points.Count -1];
			newPoints.Add( new Vector2(back.x, back.y));
		}
		return newPoints;
	}


	float getDistance(Vector2 p1, Vector2 p2)
	{
		float dx = p2.x - p1.x;
		float dy = p2.y - p1.y;
		float distance = Mathf.Sqrt((dx * dx) + (dy * dy));
		return distance;
	}

	float pathLength(List<Vector2> points)
	{
		float distance = 0;
		for (int i = 1; i < points.Count; i++)
			distance += getDistance(points[i - 1], points[i]);
		return distance;
	}

	Rect boundingBox(List<Vector2> points)
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
		Rect bounds = new Rect(minX, minY, Mathf.Abs(maxX - minX), Mathf.Abs(maxY - minY));
		return bounds;
	}
}


