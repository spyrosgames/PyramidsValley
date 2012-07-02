#pragma strict
#pragma downcast

//var checkpoint : Transform;
private var globals : Globals;

function Awake()
{
	globals = Globals.GetInstance();
}

function OnSignal () {
	//transform.position = checkpoint.position;
	//transform.rotation = checkpoint.rotation;
	
	ResetHealthOnAll ();
	globals.lives--;
}

static function ResetHealthOnAll () {
	var healthObjects : Health[] = FindObjectsOfType (Health);
	for (var health : Health in healthObjects) {
		health.dead = false;
		health.health = health.maxHealth;
	}
}
