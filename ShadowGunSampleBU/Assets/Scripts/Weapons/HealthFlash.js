
#pragma strict

public var playerHealth : Health;
public var healthMaterial : Material;

private var healthBlink : float = 1.0;
private var oneOverMaxHealth : float = 0.5;

function Start () {
	oneOverMaxHealth = 1.0 / playerHealth.maxHealth;	
}

function Update () {
	var relativeHealth : float = playerHealth.health * oneOverMaxHealth;
	healthMaterial.SetFloat ("_SelfIllumination", relativeHealth * 2.0 * healthBlink);
	
	if (relativeHealth < 0.45) 
		healthBlink = Mathf.PingPong (Time.time * 6.0, 2.0);
	else 
		healthBlink = 1.0;
}