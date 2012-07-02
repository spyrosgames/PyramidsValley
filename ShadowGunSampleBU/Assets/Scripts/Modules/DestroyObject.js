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
	bigEnemyTypeArray = ["BigRangedEnemy", "BigMeleeEnemy"];
	mediumEnemyTypeArray = ["MediumRangedEnemy", "MediumMeleeEnemy"];
	/*
	var firstPosition : Vector3 = Vector3(52, 197.3, 110);
	var secondPosition : Vector3 = Vector3(155, 197.3, 110);
	var thirdPosition : Vector3 = Vector3(52, 197.3, 224.4751);
	var fourthPosition : Vector3 = Vector3(144, 197.3, 224);
	var fifthPosition : Vector3 = Vector3(79, 197.3, 166);

	Positions = [fifthPosition, secondPosition, thirdPosition, fourthPosition, fifthPosition];
	*/
}
function Start()
{

}

function OnSignal () {
	globals.numberOfCurrentEnemiesInstantiated--;

	if(this.gameObject.name == "RangedEnemy" || this.gameObject.name == "MeleeEnemy")
	{
		globals.enemiesKilled++;
	}
	if(this.gameObject.name == "MediumRangedEnemy" || this.gameObject.name == "MediumMeleeEnemy")
	{
		globals.enemiesKilled += 4;
	}
	if(this.gameObject.name == "BigRangedEnemy" || this.gameObject.name == "BigMeleeEnemy")
	{
		globals.enemiesKilled += 8;
	}
	

	if(globals.enemiesKilled % 30 == 0)
	{
		var mediumEnemyType = Random.Range(0, 2);

		for(var a = 0; a < 4; a++)
		{
			newMediumEnemy = Instantiate(Resources.Load(mediumEnemyTypeArray[mediumEnemyType]), enemyCheckPointArray[Random.Range(0, 3)].position, this.transform.rotation);
			newMediumEnemy.tag = "Enemy";
			newMediumEnemy.name = mediumEnemyTypeArray[mediumEnemyType];
			yield WaitForSeconds(1);
		}
		globals.numberOfCurrentEnemiesInstantiated += 4;
	}

	if(globals.enemiesKilled % 200 == 0)
	{
		var bigEnemyType = Random.Range(0, 2);

		for(var b = 0; b < 1; b++)
		{
			newMediumEnemy = Instantiate(Resources.Load(bigEnemyTypeArray[bigEnemyType]), enemyCheckPointArray[Random.Range(0, 3)].position, this.transform.rotation);
			newMediumEnemy.tag = "Enemy";
			newMediumEnemy.name = bigEnemyTypeArray[bigEnemyType];
		}
		globals.numberOfCurrentEnemiesInstantiated++;
	}

	//Check the type of the enemy and instantiate a new one according to its type
	if(this.gameObject.name == "RangedEnemy" && globals.numberOfCurrentEnemiesInstantiated < 20)
	{
		newEnemy = Instantiate(Resources.Load("RangedEnemy"), enemyCheckPointArray[Random.Range(0, 3)].position, this.transform.rotation);
		newEnemy.tag = "Enemy";
		newEnemy.name = gameObject.name;
		globals.numberOfCurrentEnemiesInstantiated++;
	}
	else if(this.gameObject.name == "MeleeEnemy" && globals.numberOfCurrentEnemiesInstantiated < 20)
	{
		newEnemy = Instantiate(Resources.Load("MeleeEnemy"), enemyCheckPointArray[Random.Range(0, 3)].position, this.transform.rotation);
		newEnemy.tag = "Enemy";
		newEnemy.name = gameObject.name;
		globals.numberOfCurrentEnemiesInstantiated++;
	}

	if(this.gameObject.name == "MediumRangedEnemy")
	{
		for(var j : int = 0; j < 4; j++)
		{
			newEnemy = Instantiate(Resources.Load("RangedEnemy"), this.gameObject.transform.position, this.transform.rotation);
			newEnemy.tag = "Enemy";
			newEnemy.name = "RangedEnemy";
			//yield WaitForSeconds(1);
		}
		globals.numberOfCurrentEnemiesInstantiated += 4;
	}
	else if(this.gameObject.name == "MediumMeleeEnemy")
	{
		for(var k : int = 0; k < 4; k++)
		{
			newEnemy = Instantiate(Resources.Load("MeleeEnemy"), this.gameObject.transform.position, this.transform.rotation);
			newEnemy.tag = "Enemy";
			newEnemy.name = "MeleeEnemy";
			//yield WaitForSeconds(1);
		}
		globals.numberOfCurrentEnemiesInstantiated += 4;
	}

	if(this.gameObject.name == "BigRangedEnemy" && globals.numberOfCurrentEnemiesInstantiated < 20)
	{
		for(var l : int = 0; l < 1; l++)
		{
			newEnemy = Instantiate(Resources.Load("MediumRangedEnemy"), this.gameObject.transform.position, this.transform.rotation);
			newEnemy.tag = "Enemy";
			newEnemy.name = "MediumRangedEnemy";
		}
		globals.numberOfCurrentEnemiesInstantiated += 1;
	}
	else if(this.gameObject.name == "BigMeleeEnemy" && globals.numberOfCurrentEnemiesInstantiated < 20)
	{
		for(var m : int = 0; m < 1; m++)
		{
			newEnemy = Instantiate(Resources.Load("MediumMeleeEnemy"), this.gameObject.transform.position, this.transform.rotation);
			newEnemy.tag = "Enemy";
			newEnemy.name = "MediumMeleeEnemy";
		}
		globals.numberOfCurrentEnemiesInstantiated += 1;
	}

	//Increase the number of enemies killed. Can be used in scores.
	Spawner.Destroy(gameObject);
}