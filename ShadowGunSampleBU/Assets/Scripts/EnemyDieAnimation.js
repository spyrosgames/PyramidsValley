class EnemyDieAnimation extends Health
{
	public var enemyBody : GameObject;
	public var dieAnimation : AnimationClip;

	function OnSignal()
	{
		Debug.Log("Die Animation");
		enemyBody.animation.CrossFade(dieAnimation.name, 0.1);
	}
}