#pragma strict
private var globals : Globals;
public var EnemiesKilledCounter : GUIText;

function Awake()
{
	globals = Globals.GetInstance();
}

function Start () {

}

function Update () {
	if(globals.enemiesKilled < 10)
	{
		EnemiesKilledCounter.text = "0000" + globals.enemiesKilled.ToString();
	}
	else if(globals.enemiesKilled >= 10 && globals.enemiesKilled < 100)
	{
		EnemiesKilledCounter.text = "000" + globals.enemiesKilled.ToString();
	}
	else if(globals.enemiesKilled >= 100 && globals.enemiesKilled < 1000)
	{
		EnemiesKilledCounter.text = "00" + globals.enemiesKilled.ToString();
	}
	else if(globals.enemiesKilled >= 1000 && globals.enemiesKilled < 10000)
	{
		EnemiesKilledCounter.text = "0" + globals.enemiesKilled.ToString();
	}
	else if(globals.enemiesKilled >= 10000)
	{
		EnemiesKilledCounter.text = globals.enemiesKilled.ToString();
	}
}