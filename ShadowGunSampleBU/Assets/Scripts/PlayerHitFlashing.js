class PlayerHealth extends Health
{
	public var playerMesh : GameObject;
	public var redPlayerMaterial : Material;
	public var normalPlayerMaterial : Material;

	function OnSignal()
	{
		yield WaitForSeconds(0.4);
		//iTween.ColorTo(playerMesh, {"r": 2, "time": 0.3});
		playerMesh.transform.renderer.sharedMaterial = redPlayerMaterial;
		yield WaitForSeconds(0.4);
		playerMesh.transform.renderer.sharedMaterial = normalPlayerMaterial;
	}
}