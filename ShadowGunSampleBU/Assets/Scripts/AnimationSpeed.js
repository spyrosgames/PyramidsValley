#pragma strict
public var birdsAnimationClip : AnimationClip;

function Start () {
	animation[birdsAnimationClip.name].wrapMode = WrapMode.Loop;
	animation[birdsAnimationClip.name].speed = 0.5; 
}

function Update () {

}