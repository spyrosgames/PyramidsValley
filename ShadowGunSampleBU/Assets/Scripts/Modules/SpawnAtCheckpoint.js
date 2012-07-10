#pragma strict
#pragma downcast

//var checkpoint : Transform;
private var globals : Globals;
private var playerHealth : Health;
private var shaderDatabase : ShaderDatabase;
public var MainCamera : GameObject;
public var enemiesKilledGUIGameObject : GameObject;
public var enemiesKilledGUIText : GUIText;
private var JoystickLeft : GameObject;
private var JoystickRight : GameObject;
public var PyramidUnderAttackGUIText : GUIText;
public var FirstHealthHeart : GUITexture;
public var SecondHealthHeart : GUITexture;
public var ThirdHealthHeart : GUITexture;
public var HeartGrey : Texture2D;
public var HeartColored : Texture2D;
public var ScoreGUITextGameObject : GameObject;
public var ScoreNumberGUIText : GUIText;
private var displayTapToContinueButton : boolean = false;
public var noBordersGUISkin : GUISkin;

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
	ResetPlayerHealth();
	globals.lives--;
	if(globals.lives == 2)
	{
		FirstHealthHeart.texture = HeartGrey;
	}
	if(globals.lives == 1)
	{
		SecondHealthHeart.texture = HeartGrey;
	}
	if(globals.lives == 0)
	{
		ThirdHealthHeart.texture = HeartGrey;
		enemiesKilledGUIGameObject.SetActiveRecursively(false);
		enemiesKilledGUIText.enabled = false;
		PyramidUnderAttackGUIText.enabled = false;
		//this.gameObject.GetComponent.<PlayerMoveController>().active = false;
		JoystickLeft = GameObject.Find("Joystick Left");
		JoystickRight = GameObject.Find("Joystick Right");
		JoystickLeft.active = false;
		JoystickRight.active = false;
		shaderDatabase.BlackOut();
		ScoreGUITextGameObject.SetActiveRecursively(true);
		ScoreNumberGUIText.text = globals.enemiesKilled + "";
		displayTapToContinueButton = true;
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
	//GUI.skin = noBordersGUISkin;
	if(displayTapToContinueButton)
	{
		if(GUI.Button(Rect(Screen.width * 0.5, Screen.height * 0.5, 200, 50), "Tap to continue..."))
		{
			//
			displayTapToContinueButton = false;
			NewGame();
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
