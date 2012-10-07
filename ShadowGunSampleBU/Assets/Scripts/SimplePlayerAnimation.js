#pragma strict
public var runAnimation : AnimationClip;

function Start () {

}

function Update () {
	if(transform.parent.rigidbody.velocity != Vector3(0, 0, 0))
	{
		animation.CrossFade(runAnimation.name, 0.1);
		animation[runAnimation.name].speed = 0.6;
	}
}