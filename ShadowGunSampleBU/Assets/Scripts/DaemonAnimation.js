#pragma strict
private var player : GameObject;
private var pyramid : GameObject;
public var runningAnimation : AnimationClip;
public var attackAnimation : AnimationClip;
public var dieAnimation : AnimationClip;

private var daemonHealth : Health;

private var playerDirection : Vector3;
private var pyramidDirection : Vector3;

function Awake()
{
	player = GameObject.FindWithTag ("Player");
	pyramid = GameObject.FindWithTag ("Pyramid");
	daemonHealth = transform.parent.GetComponent.<Health>();
}

function Start () {

}

function Update () {
	playerDirection = (player.transform.position - transform.position);

	if(pyramid != null)
	{
		//Calculate the direction from pyramid to this character
		pyramidDirection = (pyramid.transform.position - transform.position);
		//var pyramidDirection : Vector3 = (pyramid.position - character.position);	
	}
	else
	{
		pyramidDirection = new Vector3(playerDirection.x * 2, playerDirection.y * 2, playerDirection.z * 2);
	}

	playerDirection.y = 0;
	pyramidDirection.y = 0;

	var playerDist : float = playerDirection.magnitude;

	var pyramidDist : float = pyramidDirection.magnitude;

	if(playerDist < pyramidDist)
	{
		var distance : float = Vector3.Distance(player.transform.position, transform.parent.position);
		if(distance > 3)
		{
			animation.CrossFade(runningAnimation.name, 0.2);
		}
		else
		{
			animation.CrossFade(attackAnimation.name, 0.2);
		}
	}
	if(pyramidDist < playerDist)
	{
		var pyramidDistance : float = Vector3.Distance(pyramid.transform.position, transform.parent.position);
		if(pyramidDistance > 10)
		{
			animation.CrossFade(runningAnimation.name, 0.2);
		}
		else
		{
			animation.CrossFade(attackAnimation.name, 0.2);
		}	
	}
	/*
	if(daemonHealth.health == 0)
	{
		animation.CrossFade(dieAnimation.name, 0.2);
	}
	*/
}