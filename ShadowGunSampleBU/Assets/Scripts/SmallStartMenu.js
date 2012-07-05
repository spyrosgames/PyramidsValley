#pragma strict
public var AnimationCamera : GameObject;
public var MainCamera : GameObject;
public var Player : GameObject;
public var EnemiesWaves : GameObject;
public var enemiesKilledGUIGameObject : GameObject;
public var enemiesKilledGUIText : GUIText;

function Start () {

}

function Update () {
	if (Input.touchCount > 0 )
	{
		for(var i : int = 0; i< Input.touchCount;i++)
		{
			var touch : Touch = Input.GetTouch(i);
			// Check whether we are getting a touch and that it is within the bounds of
			// the title graphic
			if(touch.phase == TouchPhase.Began && guiTexture.HitTest(touch.position))
			{
				guiTexture.enabled = false;
				AnimationCamera.active = false;
				MainCamera.SetActiveRecursively(true);
				Player.SetActiveRecursively(true);
				enemiesKilledGUIGameObject.SetActiveRecursively(true);
				enemiesKilledGUIText.active = true;
				EnemiesWaves.active = true;
				this.gameObject.active = false;
			}			
		}
	}
}