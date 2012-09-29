#pragma strict

// Public member data
public var behaviourOnSpotted : MonoBehaviour[];
//public var soundOnSpotted : AudioClip;
//public var behaviourOnLostTrack : MonoBehaviour;

// Private memeber data
private var character : Transform;
private var player : Transform;
private var raaFighter : Transform;
private var playerHealth : Health;
//private var pyramid : Transform;
private var insideInterestArea : boolean = true;
private var mode : String;

function Awake () {
	character = transform;
	player = GameObject.FindWithTag ("Player").transform;
	playerHealth = player.GetComponent.<Health>();
	//pyramid = GameObject.FindWithTag("Pyramid").transform;
	mode = PlayerPrefs.GetString("Mode");
	PlayerPrefs.SetString("Mode", "Attack");
}

function OnEnable () {
	//behaviourOnLostTrack.enabled = true;
	behaviourOnSpotted[0].enabled = false;
	behaviourOnSpotted[1].enabled = false;
}
/*
function OnTriggerEnter (other : Collider) {
	if (other.transform == player && CanSeePlayer()) {
		OnSpotted ();
	}

	if(other.transform == raaFighter && CanSeeRaaFighter())
	{
		OnSpotted();
	}
	if(other.transform == pyramid && CanSeePyramid())
	{
		PyramidOnSpotted();
	}
}
*/

function OnEnterInterestArea () {
	insideInterestArea = true;
}

function OnExitInterestArea () {
	insideInterestArea = false;
	OnLostTrack ();
}

function Update()
{
	//We now have one mode : Attack only.
	//uncomment if you want the enemy to do melee attack upon player weapon's type, either ranged or melee weapon.
	/*
	if(mode != PlayerPrefs.GetString("Mode"))
	{
		mode = PlayerPrefs.GetString("Mode");
		OnSpotted();
	}
	*/

	if (CanSeePlayer()) {
		OnSpotted ();
	}

	/*
	if(CanSeeRaaFighter())
	{
		OnSpotted();
	}

	if(CanSeePyramid())
	{
		PyramidOnSpotted();
	}	
	*/
}

function OnSpotted () {
	if (!insideInterestArea)
		return;
	if(mode == "Attack")
	{
		if (!behaviourOnSpotted[0].enabled) {
			behaviourOnSpotted[0].enabled = true;
			//behaviourOnLostTrack.enabled = false;
		}
		behaviourOnSpotted[1].enabled = false;
	}
	else if(mode == "Melee")
	{
		if (!behaviourOnSpotted[1].enabled) {
			behaviourOnSpotted[1].enabled = true;
			//behaviourOnLostTrack.enabled = false;
		}	
		behaviourOnSpotted[0].enabled = false;
	}

	/*
	if (audio && soundOnSpotted) {
		audio.clip = soundOnSpotted;
		if(playerHealth.health != 0)
		{
			audio.Play ();
		}
	}
	*/
}
/*
function PyramidOnSpotted()
{
	if(!insideInterestArea)
		return;

	if(mode == "Attack")
	{
		if(!behaviourOnSpotted[0].enabled)
		{
			behaviourOnSpotted[0].enabled = true;
		}
		behaviourOnSpotted[1].enabled = false;
	}
	if(mode == "Melee")
	{
		if(!behaviourOnSpotted[1].enabled)
		{
			behaviourOnSpotted[1].enabled = true;
		}
		behaviourOnSpotted[0].enabled = false;
	}
	//
	//if(audio && soundOnSpotted)
	//{
		//audio.clip = soundOnSpotted;
		//audio.Play();
	//}
}
*/
function OnLostTrack () {
	/*
	if (!behaviourOnLostTrack.enabled) {
		behaviourOnLostTrack.enabled = true;
		behaviourOnSpotted.enabled = false;
	}
	*/
		behaviourOnSpotted[0].enabled = false;
		behaviourOnSpotted[1].enabled = false;
}

function CanSeePlayer () : boolean {
	var playerDirection : Vector3 = (player.position - character.position);
	var hit : RaycastHit;
	Physics.Raycast (character.position, playerDirection, hit, playerDirection.magnitude);
	if (hit.collider && hit.collider.transform == player && hit.distance < 10) {
		return true;
	}
	return false;
}

/*
function CanSeePyramid() : boolean
{
	var pyramidDirection : Vector3 = (pyramid.position - character.position);
	var hit : RaycastHit;
	Physics.Raycast(character.position, pyramidDirection, hit, pyramidDirection.magnitude);
	if(hit.collider && hit.collider.transform == pyramid && hit.distance < 5)
	{
		return true;
	}
	return false;
}

function CanSeeRaaFighter() : boolean
{
	if(PlayerPrefs.GetString("RaaIsAlive") == "true")
	{
		raaFighter = GameObject.FindWithTag("RaaFighter").transform;

		if(raaFighter != null)
		{
			var raaFighterDirection : Vector3 = (raaFighter.position - character.position);
			var hit : RaycastHit;
			Physics.Raycast(character.position, raaFighterDirection, hit, raaFighterDirection.magnitude);
			if(hit.collider && hit.collider.transform == raaFighter && hit.distance < 5)
			{
				return true;
			}
		}
	}
	return false;
}
*/
