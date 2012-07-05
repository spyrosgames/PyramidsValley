#pragma strict
#pragma downcast

//var checkpoint : Transform;
private var globals : Globals;
private var playerHealth : Health;
private var shaderDatabase : ShaderDatabase;
public var MainCamera : GameObject;
public var enemiesKilledGUIGameObject : GameObject;
public var enemiesKilledGUIText : GUIText;

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
	if(globals.lives == 0)
	{
		enemiesKilledGUIGameObject.SetActiveRecursively(false);
		enemiesKilledGUIText.enabled = false;
		this.gameObject.GetComponent.<PlayerMoveController>().active = false;
		shaderDatabase.BlackOut();
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
