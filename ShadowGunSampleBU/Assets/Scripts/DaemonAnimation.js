#pragma strict
private var player : GameObject;
public var runningAnimation : AnimationClip;
public var attackAnimation : AnimationClip;
public var dieAnimation : AnimationClip;

private var daemonHealth : Health;
function Awake()
{
	player = GameObject.FindWithTag ("Player");
	daemonHealth = transform.parent.GetComponent.<Health>();
}

function Start () {

}

function Update () {
	var distance : float = Vector3.Distance(player.transform.position, transform.parent.position);
	if(distance > 3)
	{
		animation.CrossFade(runningAnimation.name, 0.2);
	}
	else
	{
		animation.CrossFade(attackAnimation.name, 0.2);
	}
	if(daemonHealth.health == 0)
	{
		animation.CrossFade(dieAnimation.name, 0.2);
	}
}