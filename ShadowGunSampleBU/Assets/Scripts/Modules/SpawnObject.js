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
// Keep disabled from the beginning
enabled = false;

function Awake()
{
	globals = Globals.GetInstance();
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
	spawned = Spawner.Spawn (objectToSpawn, transform.position, transform.rotation);

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

	yield WaitForSeconds(2);
	Destroy(spawned);
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
