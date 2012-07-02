#pragma strict

// Public member data
public var motor : MovementMotor;

public var targetDistanceMin : float = 2.0;
public var targetDistanceMax : float = 3.0;

public var weaponBehaviours : MonoBehaviour[];
public var fireFrequency : float = 2;

// Private memeber data
private var ai : AI;

private var character : Transform;

private var player : Transform;
private var raaFighter : Transform;
private var playerHealth : Health;
private var pyramid : Transform;

public var inRange : boolean = false;
public var pyramidInRange : boolean = false;
public var raaFighterInRange : boolean = false;

private var nextRaycastTime : float = 0;
private var lastRaycastSuccessfulTime : float = 0;
private var noticeTime : float = 0;

private var firing : boolean = false;
private var lastFireTime : float = -1;
private var nextWeaponToFire : int = 0;

private var playerDirection : Vector3;
private var pyramidDirection : Vector3;
private var raaFighterDirection : Vector3;
private var raaFighterDist : float;

function Awake () {
	character = motor.transform;
	player = GameObject.FindWithTag ("Player").transform;
	playerHealth = player.GetComponent.<Health>();
	pyramid = GameObject.FindWithTag("Pyramid").transform;
	ai = transform.parent.GetComponentInChildren.<AI> ();
}

function OnEnable () {
	inRange = false;
	pyramidInRange = false;
	nextRaycastTime = Time.time + 1;
	lastRaycastSuccessfulTime = Time.time;
	noticeTime = Time.time;
}

function OnDisable () {
	Shoot(false);
}

function Shoot(state : boolean) {
	firing = state;
}

function Fire () {
	if (weaponBehaviours[nextWeaponToFire]) {
		weaponBehaviours[nextWeaponToFire].SendMessage ("Fire");
		nextWeaponToFire = (nextWeaponToFire + 1) % weaponBehaviours.Length;
		lastFireTime = Time.time;
	}
}

function Update () {
	// Calculate the direction from the player to this character
	playerDirection = (player.position - character.position);

	if(pyramid != null)
	{
		//Calculate the direction from pyramid to this character
		pyramidDirection = (pyramid.position - character.position);
		//var pyramidDirection : Vector3 = (pyramid.position - character.position);	
	}
	else
	{
		pyramidDirection = Vector3(playerDirection.x * 2, playerDirection.y * 2, playerDirection.z * 2);
	}

	if(PlayerPrefs.GetString("RaaIsAlive") == "true")
	{
		raaFighter = GameObject.FindWithTag("RaaFighter").transform;
		raaFighterDirection = (raaFighter.position - character.position);
		raaFighterDirection.y = 0;
		raaFighterDist = raaFighterDirection.magnitude;
		raaFighterDirection /= raaFighterDist;
	}
	else
	{
		raaFighterDist = (playerDirection.magnitude + pyramidDirection.magnitude) * 2; //Just a big value when there's no raa fighter, so that
																					//comparison will be betweeb playerDist and pyramidDist
	}

	playerDirection.y = 0;
	pyramidDirection.y = 0;

	var playerDist : float = playerDirection.magnitude;
	playerDirection /= playerDist;
	

	var pyramidDist : float = pyramidDirection.magnitude;
	pyramidDirection /= pyramidDist;

	// Set this character to face the player,
	// that is, to face the direction from this character to the player
	motor.facingDirection = playerDirection;
	/*motor.facingDirection = pyramidDirection;*/
	// For a short moment after noticing player,
	// only look at him but don't walk towards or attack yet.
	if (Time.time < noticeTime + 1.5) {
		motor.movementDirection = Vector3.zero;
		return;
	}
	
	if(playerDist < pyramidDist && playerDist < raaFighterDist)
	{
		if (inRange && playerDist > targetDistanceMax)
		{
			inRange = false;
		}
		if (!inRange && playerDist < targetDistanceMin)
		{
			inRange = true;
		}
	}
	else if(pyramidDist < playerDist && pyramidDist < raaFighterDist)
	{
		if (pyramidInRange && pyramidDist > targetDistanceMax)
		{
			pyramidInRange = false;
		}
		if (!pyramidInRange && pyramidDist < targetDistanceMin)
		{
			pyramidInRange = true;
		}
	}
	else if(raaFighterDist < playerDist && raaFighterDist < pyramidDist)
	{	
		if (raaFighterInRange && raaFighterDist > targetDistanceMax)
		{
			raaFighterInRange = false;
		}
		if (!raaFighterInRange && raaFighterDist < targetDistanceMin)
		{
			raaFighterInRange = true;
		}
	}

	/*
	if(inRange && pyramidDist > targetDistanceMax)
		inRange = false;
	if(!inRange && pyramidDist < targetDistanceMin)
		inRange = true;
	*/

	if (inRange)
	{
		motor.movementDirection = Vector3.zero;
	}
	else
	{
		motor.movementDirection = playerDirection;
	}

	if(pyramidInRange)
	{
		motor.movementDirection = Vector3.zero;
	}
	else
	{
		motor.movementDirection = pyramidDirection;
	}

	if(raaFighterInRange)
	{
		motor.movementDirection = Vector3.zero;
	}
	else
	{
		motor.movementDirection = raaFighterDirection;
	}
	/*
	if(inRange)
		motor.movementDirection = Vector3.zero;
	else
		motor.movementDirection = pyramidDirection;
	*/

	if (Time.time > nextRaycastTime) {
		nextRaycastTime = Time.time + 1;
		if(playerDist < pyramidDist && playerDist < raaFighterDist)
		{
			if (ai.CanSeePlayer ()) {
				lastRaycastSuccessfulTime = Time.time;
				if (IsAimingAtPlayer ())
				{
					Shoot(true);
				}
				else
				{
					Shoot(false);
				}
			}
			else {
				Shoot (false);
				if (Time.time > lastRaycastSuccessfulTime + 5) {
					ai.OnLostTrack ();
				}
			}
		}
		else if(pyramidDist < playerDist && pyramidDist < raaFighterDist)
		{
			if(ai.CanSeePyramid())
			{
				lastRaycastSuccessfulTime = Time.time;
				if(IsAimingAtPyramid())
				{
					Shoot(true);
				}
				else
				{
					Shoot(false);
				}
			}
			else
			{
				Shoot(false);
				if(Time.time > lastRaycastSuccessfulTime + 5)
				{
					ai.OnLostTrack();
				}
			}
		}
		else if(raaFighterDist < playerDist && raaFighterDist < pyramidDist)
		{
			if(ai.CanSeeRaaFighter())
			{
				lastRaycastSuccessfulTime = Time.time;
				if(IsAimingAtRaaFighter())
					Shoot(true);
				else
					Shoot(false);
			}
			else
			{
				Shoot(false);
				if(Time.time > lastRaycastSuccessfulTime + 5)
				{
					ai.OnLostTrack();
				}
			}
		}
	}
	
	if (firing) {
		if(playerHealth.health > 0)
		{
			if (Time.time > lastFireTime + 1 / fireFrequency) {
				Fire ();
			}
		}
	}
}

function IsAimingAtPlayer () : boolean {
	var playerDirection : Vector3 = (player.position - transform.position);
	playerDirection.y = 0;
	return Vector3.Angle (transform.forward, playerDirection) < 30;
}

function IsAimingAtRaaFighter () : boolean {
	if(PlayerPrefs.GetString("RaaIsAlive") == "true")
	{
		if(raaFighter != null)
		{
			Debug.Log("Enemy is aiming at RaaFighter");
			raaFighterDirection = (raaFighter.position - transform.position);
			raaFighterDirection.y = 0;
			return Vector3.Angle (transform.forward, raaFighterDirection) < 30;
		}
	}
	return false;
}

function IsAimingAtPyramid() : boolean
{
	var pyramidDirection : Vector3 = (pyramid.position - transform.position);
	pyramidDirection.y = 0;
	return Vector3.Angle(transform.forward, pyramidDirection) < 30;
}