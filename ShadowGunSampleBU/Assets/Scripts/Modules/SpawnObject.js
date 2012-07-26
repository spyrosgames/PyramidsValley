#pragma strict

var objectToSpawn : GameObject;
var OneXPLabelToSpawn : GameObject;
var TwoXPLabelToSpawn : GameObject;
var ThreeXPLabelToSpawn : GameObject;
var FourXPLabelToSpawn : GameObject;
var FiveXPLabelToSpawn : GameObject;
var EightXPLabelToSpawn : GameObject;
var _50XPLabelToSpawn : GameObject;
var _100XPLabelToSpawn : GameObject;
var _150XPLabelToSpawn : GameObject;
var _200XPLabelToSpawn : GameObject;
var _250XPLabelToSpawn : GameObject;

var onDestroyedSignals : SignalSender;
var explosionSound : AudioClip;
private var spawned : GameObject;
private var XPLabel : GameObject;
private var globals : Globals;
private var enemyHealthScript : EnemyHealth;
private var screenPosition : Vector3;

private var enemyCheckPoint1 : Transform;
private var enemyCheckPoint2 : Transform;
private var enemyCheckPoint3 : Transform;
private var enemyCheckPointArray : Transform[];

// Keep disabled from the beginning
enabled = false;

function Awake()
{
	globals = Globals.GetInstance();

	enemyCheckPoint1 = GameObject.FindWithTag("EnemyCheckpoint1").transform;
	enemyCheckPoint2 = GameObject.FindWithTag("EnemyCheckpoint2").transform;
	enemyCheckPoint3 = GameObject.FindWithTag("EnemyCheckpoint3").transform;
	enemyCheckPointArray = [enemyCheckPoint1, enemyCheckPoint2, enemyCheckPoint3];
}
// When we get a signal, spawn the objectToSpawn and store the spawned object.
// Also enable this behaviour so the Update function will be run.
function OnSignal () {
	/*
	if (audio && explosionSound) {
		audio.clip = explosionSound;
		audio.Play ();
	}
	*/
	screenPosition = Camera.main.WorldToScreenPoint(transform.parent.position);
    screenPosition.y = Screen.height - screenPosition.y;

	AudioSource.PlayClipAtPoint(explosionSound, transform.position);
	spawned = Spawner.Spawn(objectToSpawn, transform.position, Quaternion.Euler(0, -180, 0));

    if(this.transform.parent.gameObject.name == "RangedEnemy" || this.transform.parent.gameObject.name == "MeleeEnemy")
    {
		//XPLabel = Spawner.Spawn(OneXPLabelToSpawn, Vector3(Random.Range(0.1, 0.7), Random.Range(0.2, 0.7), 0), transform.rotation);
		XPLabel = Spawner.Spawn(OneXPLabelToSpawn, Vector3(screenPosition.x / 480, screenPosition.y / 320, 0), transform.rotation);
		globals.XPPoints += 1;
	}
	else if(this.transform.parent.gameObject.name == "MediumRangedEnemy" || this.transform.parent.gameObject.name == "MediumMeleeEnemy")
	{
		XPLabel = Spawner.Spawn(FourXPLabelToSpawn, Vector3(screenPosition.x / 480, screenPosition.y / 320, 0), transform.rotation);
		globals.XPPoints += 4;
	}
	else if(this.transform.parent.gameObject.name == "BigRangedEnemy" || this.transform.parent.gameObject.name == "BigMeleeEnemy")
	{
		XPLabel = Spawner.Spawn(EightXPLabelToSpawn, Vector3(screenPosition.x / 480, screenPosition.y / 320, 0), transform.rotation);
		globals.XPPoints += 8;
	}

	if (onDestroyedSignals.receivers.Length > 0)
	{
		enabled = true;
	}
	if(this.transform.parent.gameObject.name == "RangedEnemy" || this.transform.parent.gameObject.name == "MeleeEnemy")
	{
		this.transform.parent.gameObject.transform.position = enemyCheckPointArray[Random.Range(0, 3)].position;
		//Don't Destroy small enemies, just move them to the origin.
		yield WaitForSeconds(2);//Wait to seconds before destroying the death particles
		Destroy(spawned);//Destroy the enemy death particles
	}
	else if(this.transform.parent.gameObject.name == "MediumRangedEnemy" || this.transform.parent.gameObject.name == "MediumMeleeEnemy" || this.transform.parent.gameObject.name == "BigRangedEnemy" || this.transform.parent.gameObject.name == "BigMeleeEnemy")
	{
		Destroy(this.transform.parent.gameObject); //Destroy Medium and Big enemies.
		yield WaitForSeconds(2);//Wait to seconds before destroying the death particles
		Destroy(spawned);//Destroy the enemy death particles
	}
}
function OnGUI()
{
}
// After the object is spawned, check each frame if it's still there.
// Once it's not, activate the onDestroyedSignals and disable again.
function Update () {
	if (spawned == null || spawned.active == false) {
		onDestroyedSignals.SendSignals (this);
		enabled = false;
	}
}
