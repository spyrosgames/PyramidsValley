#pragma strict
//private var enemy : GameObject;
private var enemiesArray : String[];
private var enemyCheckPointArray : GameObject[];
public var enemyCheckPoint1 : GameObject;
public var enemyCheckPoint2 : GameObject;
public var enemyCheckPoint3 : GameObject;
private var enemyType : String;
private var instantiationFinished : boolean = false;
private var globals : Globals;

function Awake()
{
	enemiesArray = ["RangedEnemy", "MeleeEnemy"];
	enemyCheckPointArray = [enemyCheckPoint1, enemyCheckPoint2, enemyCheckPoint3];
	globals = Globals.GetInstance();
}

function Start () {
	for(var i : int = 0; i < 20; i++)
	{
		enemyType = enemiesArray[Random.Range(0, 2)];
		var enemy : GameObject = Instantiate(Resources.Load(enemyType), enemyCheckPointArray[Random.Range(0, 3)].transform.position, Quaternion.identity);
		enemy.tag = "Enemy";
		enemy.name = enemyType;
		globals.numberOfCurrentEnemiesInstantiated++;
		yield WaitForSeconds(10);
	}
}

function Update () {
	
}