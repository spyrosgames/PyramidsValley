#pragma strict
public var WaveNumberGUIText : GUIText;

public var startTime : float;
private var restSeconds : int;
private var roundedRestSeconds : int;
private var displaySeconds : int;
private var displayMinutes : int;

public var countDownSeconds : int;
private var guiTime : float;

public var mainCamera : Camera;

private var WaveNumber : int;

private var newWaveEnemy : GameObject;

private var enemyType : int;
private var enemyCheckPointNumber : int;
private var enemyCheckPoint : Transform;
private var bigEnemyCheckPointNumber : int;
private var bigEnemyCheckPoint : Transform;
//private var Positions : Vector3[];
private var enemyName = "OneXPEnemy";

private var maxNumberOfEnemiesInScene = 10;
private var resetTimes = 0;

public var smallFontGUISkin : GUISkin;
private var cameraZoomOut : boolean = false;
private var cameraZoomIn : boolean = true;

public var enemyCheckPoint1 : Transform;
public var enemyCheckPoint2 : Transform;
public var enemyCheckPoint3 : Transform;
public var enemyCheckPoint4 : Transform;

private var text : String;

function Awake()
{
	useGUILayout = false;
	
	if(PlayerPrefs.GetInt("WaveNumber") == 0)
	{
		WaveNumber = PlayerPrefs.GetInt("WaveNumber");
	}
	else if(PlayerPrefs.GetInt("WaveNumber") != 0)
	{
		WaveNumber = PlayerPrefs.GetInt("WaveNumber") - 1;
	}
	startTime = Time.time;
	//startTime = 60.0;
	/*
	var firstPosition : Vector3 = Vector3(52, 197.5, 110);
	var secondPosition : Vector3 = Vector3(155, 199.7922, 110);
	var thirdPosition : Vector3 = Vector3(52, 207.6546, 224.4751);
	var fourthPosition : Vector3 = Vector3(144, 226.6557, 224);
	var fifthPosition : Vector3 = Vector3(79, 199.9537, 166);

	Positions = [fifthPosition, secondPosition, thirdPosition, fourthPosition, fifthPosition];
	*/
}

function Start () {
	/*
	WaveNumber = PlayerPrefs.GetInt("WaveNumber");
	Debug.Log("WaveNumber " + WaveNumber);
	if(WaveNumber == 0)
	{
		PlayerPrefs.SetInt("WaveNumber", 1);
		WaveNumber = 1;
		WaveNumberGUIText.text = "Wave " + WaveNumber + " Started!";
	}
	else
	{
		WaveNumberGUIText.text = "Wave " + WaveNumber + " Resumed!";
	}
	iTween.ValueTo(gameObject, iTween.Hash("from", Vector2(-600, 0), "to", new Vector2(-150,0),"time",7.0,"onUpdate", "AnimateGUITextPixelOffset", "easeType", iTween.EaseType.easeOutElastic));
	iTween.ValueTo(gameObject, iTween.Hash("from", Vector2(-150, 0), "to", new Vector2(400,0),"time",7.0,"delay",4.0,"onUpdate", "AnimateGUITextPixelOffset", "easeType", iTween.EaseType.easeOutElastic));
	*/
}


function Update()
{
	if(cameraZoomOut == true)
	{
		if(mainCamera.fieldOfView < 60)
		{
			mainCamera.fieldOfView += 0.2;
		}
		if(mainCamera.fieldOfView >= 60)
		{
			cameraZoomOut = false;
		}
	}


		guiTime = Time.time - startTime;
	restSeconds = countDownSeconds - guiTime;
	roundedRestSeconds = Mathf.CeilToInt(restSeconds);

	displaySeconds = roundedRestSeconds % 60;
	displayMinutes = roundedRestSeconds / 60;

	if(cameraZoomIn == true)
	{
		if(mainCamera.fieldOfView > 50)
		{
			mainCamera.fieldOfView -= Time.time / 50;
		}
		if(mainCamera.fieldOfView < 50)
		{
			cameraZoomIn = false;
			cameraZoomOut = true;
		}
	}
	if(restSeconds < 0.0)
	{
		resetTimes++;
		WaveNumber++;
		PlayerPrefs.SetInt("WaveNumber", WaveNumber);
		cameraZoomIn = true;
		WaveNumberGUIText.text = "Wave " + WaveNumber + " Started!";
		iTween.ValueTo(gameObject, iTween.Hash("from", Vector2(-600, 30), "to", new Vector2(-155,30),"time",7.0,"onUpdate", "AnimateGUITextPixelOffset", "easeType", iTween.EaseType.easeOutElastic));
		iTween.ValueTo(gameObject, iTween.Hash("from", Vector2(-155, 30), "to", new Vector2(400,30),"time",7.0,"delay",4.0,"onUpdate", "AnimateGUITextPixelOffset", "easeType", iTween.EaseType.easeOutElastic));
	
		startTime = startTime + 62.0;

		var allEnemies : GameObject[] = GameObject.FindGameObjectsWithTag("Enemy");
		var numberOfEnemiesToInstantiate = maxNumberOfEnemiesInScene - allEnemies.length;

		for(var i = 0; i < numberOfEnemiesToInstantiate; i++)
		{
			enemyType = Random.Range(0, 4);
			enemyCheckPointNumber = Random.Range(0, 3);
			if(enemyType == 0)
			{
				enemyName = "OneXPEnemy";
			}
			else if(enemyType == 1)
			{
				enemyName = "TwoXPEnemy";
			}
			else if(enemyType == 2)
			{
				enemyName = "ThreeXPEnemy";
			}
			else if(enemyType == 3)
			{
				enemyName = "FourXPEnemy";
			}
			else if(enemyType == 4)
			{
				enemyName = "FiveXPEnemy";
			}

			if(enemyCheckPointNumber == 0)
			{
				enemyCheckPoint = enemyCheckPoint1;
			}
			else if(enemyCheckPointNumber == 1)
			{
				enemyCheckPoint = enemyCheckPoint2;
			}
			else if(enemyCheckPointNumber == 2)
			{
				enemyCheckPoint = enemyCheckPoint3;
			}
			else if(enemyCheckPointNumber == 3)
			{
				enemyCheckPoint = enemyCheckPoint4;
			}

			newWaveEnemy = Instantiate(Resources.Load(enemyName), enemyCheckPoint.position, enemyCheckPoint.rotation);
			newWaveEnemy.tag = "Enemy";
			newWaveEnemy.name = enemyName;

			enemyCheckPoint.position.x += 0.5;
		}

		if(resetTimes % 5 == 0)
		{
			var bigEnemyType = Random.Range(0, 4);
			var bigEnemyName = "50XPEnemy";
			bigEnemyCheckPointNumber = Random.Range(0, 3);
			if(bigEnemyCheckPointNumber == 0)
			{
				bigEnemyCheckPoint = enemyCheckPoint1;
			}
			else if(bigEnemyCheckPointNumber == 1)
			{
				bigEnemyCheckPoint = enemyCheckPoint2;
			}
			else if(bigEnemyCheckPointNumber == 2)
			{
				bigEnemyCheckPoint = enemyCheckPoint3;
			}
			else if(bigEnemyCheckPointNumber == 3)
			{
				bigEnemyCheckPoint = enemyCheckPoint4;
			}

			if(bigEnemyType == 0)
			{
				bigEnemyName = "50XPEnemy";
			}
			else if(enemyType == 1)
			{
				bigEnemyName = "100XPEnemy";
			}
			else if(enemyType == 2)
			{
				bigEnemyName = "150XPEnemy";
			}
			else if(enemyType == 3)
			{
				bigEnemyName = "200XPEnemy";
			}
			else if(enemyType == 4)
			{
				bigEnemyName = "250XPEnemy";
			}
			StartCoroutine(WaitForSomeTime());
			var bigEnemy : GameObject = Instantiate(Resources.Load(bigEnemyName), bigEnemyCheckPoint.position, bigEnemyCheckPoint.rotation);
			bigEnemy.tag = "Enemy";
			bigEnemy.name = bigEnemyName;
		}
	}

	text = String.Format("{0:00}:{1:00}", displayMinutes, displaySeconds);
}

function OnGUI()
{
	GUI.skin = smallFontGUISkin;

	GUI.Label(Rect(Screen.width * 0.47, Screen.height * 0.83, 100, 50), text);
}

function AnimateGUITextPixelOffset(pixelOffset : Vector2){

    WaveNumberGUIText.pixelOffset = pixelOffset;
}

function WaitForSomeTime()
{
	yield WaitForSeconds(1);
}