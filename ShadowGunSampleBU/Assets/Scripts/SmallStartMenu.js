#pragma strict
public var AnimationCamera : GameObject;
public var MainCamera : GameObject;
public var Player : GameObject;
public var EnemiesWaves : GameObject;
public var enemiesKilledGUIGameObject : GameObject;
public var LivesHearts : GameObject;
public var PyramidHealthGUIGameObject : GameObject;

function Start () {
	/*
	MainCamera.SetActiveRecursively(false);
	Player.SetActiveRecursively(false);
	enemiesKilledGUIGameObject.SetActiveRecursively(false);
	EnemiesWaves.active = false;
	*/
}

function Update () {
	if (Input.touchCount > 0)
	{
		for(var i : int = 0; i < Input.touchCount;i++)
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
				LivesHearts.SetActiveRecursively(true);
				EnemiesWaves.active = true;
				PyramidHealthGUIGameObject.SetActiveRecursively(true);
				this.gameObject.active = false;
			}			
		}
	}
}