#pragma strict
public var healthBarLength : float;
private var health : float;
private var maxHealth : float;
private var healthObj : Health;
public var screenPosition : Vector3;
public var blackHealthBar : Texture2D;
public var healthGUISkin : GUISkin;
private var originalHealthBarLenght : float;

function Start()
{
	healthObj = gameObject.GetComponent(Health);
	//health = healthObj.health;
	//maxHealth = healthObj.maxHealth;
	if(health > 0)
	{
		healthBarLength = Screen.width / 8;
	}
	originalHealthBarLenght = (Screen.width / 8);
}

function Update()
{
	health = healthObj.health;
	maxHealth = healthObj.maxHealth;

	screenPosition = Camera.main.WorldToScreenPoint(transform.position);
    screenPosition.y = Screen.height - screenPosition.y;
	adjustCurrentHealth(0);
}

function OnGUI()
{
	GUI.skin = healthGUISkin;
	if(maxHealth != 0 && health != 0)
	{
		GUI.Label(new Rect(screenPosition.x - 35, screenPosition.y - 40, originalHealthBarLenght, 20), blackHealthBar);
		GUI.Box(new Rect(screenPosition.x - 35, screenPosition.y - 37, healthBarLength, 10), "");
	}
}

function adjustCurrentHealth(adj : int)
{
	health += adj;

	if(health < 0)
	{
		Destroy(gameObject);
		health = 0;
	}

	if(health > maxHealth)
	{
		health = maxHealth;
	}
	
	if(health > 0)
	{
		healthBarLength = (Screen.width / 8) * (health / maxHealth);
	}
}

