#pragma strict
public var healthBarLength : float;
private var health : float;
private var maxHealth : float;
private var healthObj : Health;
private var originalHealthBarLenght : float;
public var blackHealthBar : GUITexture;
public var healthGUISkin : GUISkin;

function Awake()
{
	useGUILayout = false;
}

function Start()
{
	healthObj = gameObject.GetComponent(Health);
	//health = healthObj.health;
	//maxHealth = healthObj.maxHealth;
	healthBarLength = (Screen.width / 5.5)  * (health / maxHealth);

	originalHealthBarLenght = Screen.width / 2.6;
	//blackHealthBar.enabled = true;
}

function Update()
{
	health = healthObj.health;
	maxHealth = healthObj.maxHealth;
	adjustCurrentHealth(0);
}

function OnGUI()
{
	GUI.skin = healthGUISkin;
	if(maxHealth != 0 && health != 0)
	{
		//GUI.Label(Rect(Screen.width * 0.365, Screen.height * 0.925, 30, 30), "Pyramid:");
		//GUI.Label(new Rect(Screen.width * 0.365, Screen.height * 0.86, healthBarLength, 20), blackHealthBar);
		GUI.Box(new Rect(Screen.width * 0.732, Screen.height * 0.018, healthBarLength + 36, 24), "");
		//GUI.Label(Rect(Screen.width * 0.72, Screen.height * 0.855, healthBarLength, 30), health + "/" + maxHealth);
	}
}

function adjustCurrentHealth(adj : int)
{
	health += adj;

	if(health < 0)
	{
		health = 0;
	}

	if(health > maxHealth)
	{
		health = maxHealth;
	}
	healthBarLength = (Screen.width / 5.5) * (health / maxHealth);
}

