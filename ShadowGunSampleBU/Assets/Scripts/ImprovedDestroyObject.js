#pragma strict
private var newEnemy : GameObject;
private var newMediumEnemy : GameObject;
//private var Positions : Vector3[];
private var globals : Globals;
private var myWaveIWasInstantiatedAt;
private var enemyCheckPointNumber : int;
private var enemyCheckPointPosition : Vector3;
private var enemyCheckPoint1 : Transform;
private var enemyCheckPoint2 : Transform;
private var enemyCheckPoint3 : Transform;
private var enemyCheckPointArray : Transform[];
private var bigEnemyTypeArray : String[];
private var mediumEnemyTypeArray : String[];
private var player : GameObject;
private var currentNumberOfEnemies : GameObject[];

function Awake()
{
	globals = Globals.GetInstance();
	player = GameObject.FindWithTag("Player");
	
	enemyCheckPoint1 = GameObject.FindWithTag("EnemyCheckpoint1").transform;
	enemyCheckPoint2 = GameObject.FindWithTag("EnemyCheckpoint2").transform;
	enemyCheckPoint3 = GameObject.FindWithTag("EnemyCheckpoint3").transform;
	enemyCheckPointArray = [enemyCheckPoint1, enemyCheckPoint2, enemyCheckPoint3];
}

function Start()
{

}

function OnSignal () {
	globals.enemiesKilled++;
	//Check the type of the enemy and instantiate a new one according to its type
	this.gameObject.transform.position = enemyCheckPointArray[Random.Range(0, 3)].position;
	/*
	if(this.gameObject.name == "RangedEnemy")
	{	
		this.gameObject.transform.position = enemyCheckPointArray[Random.Range(0, 3)].position;
	}
	else if(this.gameObject.name == "MeleeEnemy")
	{
		this.gameObject.transform.position = enemyCheckPointArray[Random.Range(0, 3)].position;
	}
	*/
}
