class EnemyHitFlashing extends Health
{
	public var enemyMesh : GameObject;
	public var redEnemyMaterial : Material;
	public var normalEnemyMaterial : Material;

	function OnHit()
	{
		yield WaitForSeconds(0.4);
		//iTween.ColorTo(enemyMesh, {"r": 2, "time": 0.3});
		enemyMesh.transform.renderer.sharedMaterial = redEnemyMaterial;
		yield WaitForSeconds(0.4);
		enemyMesh.transform.renderer.sharedMaterial = normalEnemyMaterial;
	}
}