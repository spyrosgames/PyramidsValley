#pragma strict
#pragma downcast

//var checkpoint : Transform;
private var globals : Globals;
private var playerHealth : Health;
private var shaderDatabase : ShaderDatabase;
public var MainCamera : GameObject;
public var enemiesKilledGUIGameObject : GameObject;
public var enemiesKilledGUIText : GUIText;
public var livesHeartsGameObject : GameObject;
public var pyramidHealthGUIGameObject : GameObject;
private var JoystickLeft : GameObject;
private var JoystickRight : GameObject;
public var FirstHealthHeart : GUITexture;
public var SecondHealthHeart : GUITexture;
public var ThirdHealthHeart : GUITexture;
public var HeartGrey : Texture2D;
public var HeartColored : Texture2D;
public var ScoreGUITextGameObject : GameObject;
public var ScoreNumberGUIText : GUIText;
private var displayTapToContinueButton : boolean = false;
public var noBordersGUISkin : GUISkin;
public var Weapon : GameObject;
public var scaredGroundParticlesEffect : GameObject;

function Awake()
{
	globals = Globals.GetInstance();
	playerHealth = this.gameObject.transform.GetComponent.<Health>();
	shaderDatabase = MainCamera.GetComponent.<ShaderDatabase>();
}

function OnSignal () {
	//transform.position = checkpoint.position;
	//transform.rotation = checkpoint.rotation;
	
	//ResetHealthOnAll ();
	globals.lives--;
	if(globals.lives == 2)
	{
		FirstHealthHeart.texture = HeartGrey;
		var scaredGround = Instantiate(scaredGroundParticlesEffect, this.gameObject.transform.position, Quaternion.identity);
		scaredGround.transform.parent = this.gameObject.transform;
		ResetPlayerHealth();
	}
	if(globals.lives == 1)
	{
		SecondHealthHeart.texture = HeartGrey;
		var anotherScaredGround = Instantiate(scaredGroundParticlesEffect, this.gameObject.transform.position, Quaternion.identity);
		anotherScaredGround.transform.parent = this.gameObject.transform;
		ResetPlayerHealth();
	}
	if(globals.lives == 0)
	{
		DisplayDeathScreen();
	}
}

static function ResetHealthOnAll () {
	var healthObjects : Health[] = FindObjectsOfType (Health);
	for (var health : Health in healthObjects) {
		health.dead = false;
		health.health = health.maxHealth;
	}
}

function ResetPlayerHealth()
{
	playerHealth.dead = false;
	playerHealth.health = playerHealth.maxHealth;
}

function OnGUI()
{
	GUI.skin = noBordersGUISkin;
	if(displayTapToContinueButton)
	{
		if(GUI.Button(Rect(Screen.width * 0.57, Screen.height * 0.49, 260, 20), "Tap to continue..."))
		{
			//
			NewGame();
			displayTapToContinueButton = false;
		}
	}
}

function NewGame()
{
	globals.enemiesKilled = 0;
	globals.lives = 3;
	FirstHealthHeart.texture = HeartColored;
	SecondHealthHeart.texture = HeartColored;
	ThirdHealthHeart.texture = HeartColored;
	ResetHealthOnAll();
	Application.LoadLevel(0);
}

public function DisplayDeathScreen()
{
	FirstHealthHeart.texture = HeartGrey;
	SecondHealthHeart.texture = HeartGrey;
	ThirdHealthHeart.texture = HeartGrey;
	enemiesKilledGUIGameObject.SetActiveRecursively(false);
	livesHeartsGameObject.SetActiveRecursively(false);
	pyramidHealthGUIGameObject.SetActiveRecursively(false);
	enemiesKilledGUIText.enabled = false;
	//this.gameObject.GetComponent.<PlayerMoveController>().active = false;
	JoystickLeft = GameObject.Find("Joystick Left");
	JoystickRight = GameObject.Find("Joystick Right");
	JoystickLeft.active = false;
	JoystickRight.active = false;
	var JoystickRightScript : Joystick = JoystickRight.GetComponent.<Joystick> ();
	JoystickRightScript.position.x = 0;
	JoystickRightScript.position.y = 0;
	var JoystickLeftScript : Joystick = JoystickLeft.GetComponent.<Joystick> ();
	JoystickLeftScript.position.x = 0;
	JoystickLeftScript.position.y = 0;
	var autoFire : AutoFire = Weapon.GetComponent.<AutoFire>();
	autoFire.OnStopFire();
	this.gameObject.rigidbody.constraints = RigidbodyConstraints.FreezeAll;
	shaderDatabase.BlackOut();
	ScoreGUITextGameObject.SetActiveRecursively(true);
	if(globals.enemiesKilled >= 1)
	{
		ScoreNumberGUIText.text = globals.enemiesKilled + " monsters.";
	}
	else if(globals.enemiesKilled < 1)
	{
		ScoreNumberGUIText.text = globals.enemiesKilled + " monster.";
	}
	
	displayTapToContinueButton = true;
}