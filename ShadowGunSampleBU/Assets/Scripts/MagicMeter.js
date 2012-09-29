#pragma strict
public var textureOne : GUITexture;
public var barTexture : GUITexture;
public var textureTwo : GUITexture;
public var debugGUIText : GUIText;

function Start () {

}

function Update () {
	if (Input.touchCount > 0)
	{
		for(var i : int = 0; i < Input.touchCount;i++)
		{
			var touch : Touch = Input.GetTouch(i);
			// Check whether we are getting a touch and that it is within the bounds of
			// the title graphic

			if(touch.phase == TouchPhase.Moved && textureOne.HitTest(touch.position))
			{
				if(touch.phase == TouchPhase.Moved && barTexture.HitTest(touch.position))
				{
					debugGUIText.text = "One!";
				}
			}

			if(touch.phase == TouchPhase.Moved && textureTwo.HitTest(touch.position))
			{
				if(touch.phase == TouchPhase.Moved && barTexture.HitTest(touch.position))
				{
					debugGUIText.text = "Two!";
				}
			}

		}
	}
}