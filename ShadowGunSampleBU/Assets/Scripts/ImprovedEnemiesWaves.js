#pragma strict
public var enemies : GameObject[];

function Awake()
{
	
}

function Start()
{
	for(var i : int = 0; i < enemies.length; i++)
	{
		enemies[i].SetActiveRecursively(true);
		yield WaitForSeconds(8);
	}
}