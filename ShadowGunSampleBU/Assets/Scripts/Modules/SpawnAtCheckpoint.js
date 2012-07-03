#pragma strict
#pragma downcast

//var checkpoint : Transform;
private var globals : Globals;
private var playerHealth : Health;

function Awake()
{
	globals = Globals.GetInstance();
	playerHealth = this.gameObject.transform.GetComponent.<Health>();
}

function OnSignal () {
	//transform.position = checkpoint.position;
	//transform.rotation = checkpoint.rotation;
	
	//ResetHealthOnAll ();
	ResetPlayerHealth();
	globals.lives--;
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
