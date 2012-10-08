#pragma strict
public var AnimationCamera : GameObject;
public var MainCamera : GameObject;
public var Player : GameObject;
public var EnemiesWaves : GameObject;
public var enemiesKilledGUIGameObject : GameObject;
public var LivesHearts : GameObject;
public var MenuSoundTrackAudioSource : GameObject;
public var MainSoundTrackAudioSource : GameObject;
public var scaredGround : GameObject;
public var GesturesRecognizer : GameObject;
public var GesturesCamera : GameObject;
//public var tempEnemy : GameObject;
//public var magicMeter : GameObject;

function Awake()
{
	//guiTexture.pixelInset = Rect(Screen.width * 0.5 - 128, Screen.height * 0.5 - 64, 256, 128);
}

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
				//MainSoundTrackAudioSource.clip = mainSceneSoundTrack;
				//MainSoundTrackAudioSource.Play();
				MenuSoundTrackAudioSource.active = false;
				MainSoundTrackAudioSource.active = true;
				Player.SetActiveRecursively(true);
				if(Player.rigidbody.isKinematic == true)
				{
					Player.rigidbody.isKinematic = false;
				}
				var scaredGround = Instantiate(scaredGround, Player.transform.position, Quaternion.identity);
				scaredGround.transform.parent = Player.transform;
				/*
				Player.rigidbody.constraints = RigidbodyConstraints.None; //clear any freeze
				Player.rigidbody.constraints = RigidbodyConstraints.FreezePositionY; //freeze y for player
				*/
				enemiesKilledGUIGameObject.SetActiveRecursively(true);
				LivesHearts.SetActiveRecursively(true);
				EnemiesWaves.active = true;
				//tempEnemy.SetActiveRecursively(true);
				GesturesRecognizer.active = true;
				GesturesCamera.active = true; //A independent camera for rendering gestures
				//magicMeter.SetActiveRecursively(true);
				this.gameObject.active = false;
			}			
		}
	}
}