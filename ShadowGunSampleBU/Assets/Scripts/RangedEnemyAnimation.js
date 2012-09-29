#pragma strict
private var player : GameObject;
//private var pyramid : GameObject;
public var walkingAnimation : AnimationClip;
public var idleAnimation : AnimationClip;
private var maxDistance : float = 3;
private var playerDirection : Vector3;
//private var pyramidDirection : Vector3;
function Awake()
{
	player = GameObject.FindWithTag ("Player");
	//pyramid = GameObject.FindWithTag("Pyramid");
}

function Start () {

}

function Update () {
	playerDirection = (player.transform.position - transform.position);
	/*
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
	*/
	playerDirection.y = 0;
	//pyramidDirection.y = 0;

	var playerDist : float = playerDirection.magnitude;

	//var pyramidDist : float = pyramidDirection.magnitude;
	//if(playerDist < pyramidDist)
	//{
		if(Vector3.Distance(player.transform.position, transform.position) > maxDistance)
		{
			animation.CrossFade(walkingAnimation.name, 0.2);
		}
		else
		{
			animation.CrossFade(idleAnimation.name, 0.2);
		}
	//}
	/*
	if(pyramidDist > playerDist)
	{
		if(Vector3.Distance(pyramid.transform.position, transform.position) > maxDistance)
		{
			animation.CrossFade(walkingAnimation.name, 0.2);
		}
		else
		{
			animation.CrossFade(idleAnimation.name, 0.2);
		}
	}
	*/
}