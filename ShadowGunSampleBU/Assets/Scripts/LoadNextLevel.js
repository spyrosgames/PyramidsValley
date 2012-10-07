#pragma strict

public var levelName : String;
static var activateButton : boolean = false;

function OnGUI()
{
	GUI.enabled = activateButton;
	if(GUI.Button(Rect(Screen.width * 0.7, Screen.height * 0.75, Screen.width * 0.1, Screen.height * 0.1), "Play"))
	{
		Application.LoadLevel(levelName);
	}
}