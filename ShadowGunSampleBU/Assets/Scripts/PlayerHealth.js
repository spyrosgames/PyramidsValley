class PlayerHealth extends Health
{
	public var playerMesh : GameObject;
	public var redPlayerMaterial : Material;
	public var normalPlayerMaterial : Material;

	function OnSignal()
	{
		
		playerMesh.transform.renderer.sharedMaterial = redPlayerMaterial;
		yield WaitForSeconds(0.4);
		playerMesh.transform.renderer.sharedMaterial = normalPlayerMaterial;
		
	}
}