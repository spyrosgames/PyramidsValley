#pragma strict
//private var enemy : GameObject;
public var enemiesArray : String[];
public var enemyCheckPointArray : GameObject[];
//public var enemyCheckPoint1 : GameObject;
//public var enemyCheckPoint2 : GameObject;
//public var enemyCheckPoint3 : GameObject;
private var enemyType : GameObject;
public var enemies : GameObject[];
private var instantiationFinished : boolean = false;
private var globals : Globals;

function Awake()
{
	//enemiesArray = ["RangedEnemy", "MeleeEnemy"];
	//enemyCheckPointArray = [enemyCheckPoint1, enemyCheckPoint2, enemyCheckPoint3];
	globals = Globals.GetInstance();
}

function Start () {
	for(var i : int = 0; i < 20; i++)
	{
		enemyType = enemies[Random.Range(0, 2)];
		var enemy : GameObject = Instantiate(enemyType, enemyCheckPointArray[Random.Range(0, 3)].transform.position, Quaternion.identity);
		enemy.tag = "Enemy";
		enemy.name = enemyType.name;
		globals.numberOfCurrentEnemiesInstantiated++;
		yield WaitForSeconds(10);
	}
}

function Update () {
	
}