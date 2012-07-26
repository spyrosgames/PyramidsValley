#pragma strict

public var maxHealth : float = 100.0;
public var health : float = 100.0;
public var regenerateSpeed : float = 0.0;
public var invincible : boolean = false;
public var dead : boolean = false;

public var damagePrefab : GameObject;
public var damageEffectTransform : Transform;
public var damageEffectMultiplier : float = 1.0;
public var damageEffectCentered : boolean = true;

//public var scorchMarkPrefab : GameObject = null;
private var scorchMark : GameObject = null;

public var damageSignals : SignalSender;
public var dieSignals : SignalSender;

private var lastDamageTime : float = 0;
private var damageEffect : ParticleEmitter;
private var damageEffectCenterYOffset : float;

private var colliderRadiusHeuristic : float = 1.0;

public var playerMesh : GameObject;
public var redPlayerMaterial : Material;
public var normalPlayerMaterial : Material;

public var pyramidUnderAttackGUIText : GUIText;

function Awake () {
	enabled = false;
	if (damagePrefab) {
		if (damageEffectTransform == null)
			damageEffectTransform = transform;
		var effect : GameObject = Spawner.Spawn (damagePrefab, Vector3.zero, Quaternion.identity);
		effect.transform.parent = damageEffectTransform;
		effect.transform.localPosition = Vector3.zero;
		damageEffect = effect.particleEmitter;
		var tempSize : Vector2 = Vector2(collider.bounds.extents.x,collider.bounds.extents.z);
		colliderRadiusHeuristic = tempSize.magnitude * 0.5;
		damageEffectCenterYOffset = collider.bounds.extents.y;
		
	}
	

	//if (scorchMarkPrefab && this.gameObject.tag == "Pyramid") {
	if (this.gameObject.tag == "Pyramid") {
		//scorchMark = GameObject.Instantiate(scorchMarkPrefab, Vector3.zero, Quaternion.identity);
		scorchMark = GameObject.Instantiate(Resources.Load("LargeFlames"), Vector3(this.gameObject.transform.position.x, this.gameObject.transform.position.y, this.gameObject.transform.position.z - 10), Quaternion.identity);
		scorchMark.active = false;
		//if(this.gameObject.tag == "Pyramid")
		//{
			scorchMark.tag = "Pyramid";
		//}
	}
	
	if(this.gameObject.tag == "Player")
	{
		Debug.Log("Player Health from Upgrades Room: " + PlayerPrefs.GetInt("PlayerHealth - Base Value"));
		maxHealth += ( (PlayerPrefs.GetInt("PlayerHealth - Base Value") * 0.1) - 1);
	}
	if(this.gameObject.tag == "Pyramid")
	{
		maxHealth += ( (PlayerPrefs.GetInt("PyramidHealth - Base Value") * 0.1) - 1);
	}
}

function OnDamage (amount : float, fromDirection : Vector3) {
	// Take no damage if invincible, dead, or if the damage is zero
	if(this.gameObject.tag == "Player")
	{
		playerMesh.transform.renderer.sharedMaterial = redPlayerMaterial;
		yield WaitForSeconds(0.4);
		playerMesh.transform.renderer.sharedMaterial = normalPlayerMaterial;
	}

	if(invincible)
		return;
	if (dead)
		return;
	if (amount <= 0)
		return;
	
	// Decrease health by damage and send damage signals
	
	// @HACK: this hack will be removed for the final game
	//  but makes playing and showing certain areas in the
	//  game a lot easier
	/*	
	#if !UNITY_IPHONE && !UNITY_ANDROID
	if(gameObject.tag != "Player")
		amount *= 10.0;
	#endif
	*/
	if(this.gameObject.tag == "Player")
	{
		Debug.Log("Strength : " + PlayerPrefs.GetInt("Strength - Base Value"));
		amount -= ( (PlayerPrefs.GetInt("Strength - Base Value") * 0.1) - 1); 
	}
	if(this.gameObject.tag == "Pyramid")
	{
		Debug.Log("Strength : " + PlayerPrefs.GetInt("PyramidStrength - Base Value"));
		amount -= ( (PlayerPrefs.GetInt("PyramidStrength - Base Value") * 0.1) - 1); 
	}
	
	health -= amount;
	damageSignals.SendSignals (this);
	lastDamageTime = Time.time;
	
	// Enable so the Update function will be called
	// if regeneration is enabled
	if (regenerateSpeed > 0)
		enabled = true;
	
	// Show damage effect if there is one
	if (damageEffect) {
		damageEffect.transform.rotation = Quaternion.LookRotation (fromDirection, Vector3.up);
		if(!damageEffectCentered) {
			var dir : Vector3 = fromDirection;
			dir.y = 0.0;
			damageEffect.transform.position = (transform.position + Vector3.up * damageEffectCenterYOffset) + colliderRadiusHeuristic * dir;
		}
		// @NOTE: due to popular demand (ethan, storm) we decided
		// to make the amount damage independent ...
		//var particleAmount = Random.Range (damageEffect.minEmission, damageEffect.maxEmission + 1);
		//particleAmount = particleAmount * amount * damageEffectMultiplier;
		damageEffect.Emit();// (particleAmount);
		if(this.gameObject.tag == "Pyramid")
		{
			pyramidUnderAttackGUIText.text = "Pyramid Under Attack";
			yield WaitForSeconds(1);
			pyramidUnderAttackGUIText.text = " ";
		}
	}
	
	// Die if no health left
	if (health <= 0) {
		health = 0;
		dead = true;
		dieSignals.SendSignals (this);
		enabled = false;
		
		// scorch marks
		if (scorchMark && this.gameObject.tag == "Pyramid") {
			scorchMark.active = true;
			// @NOTE: maybe we can justify a raycast here so we can place the mark
			// on slopes with proper normal alignments
			// @TODO: spawn a yield Sub() to handle placement, as we can
			// spread calculations over several frames => cheap in total
			var scorchPosition : Vector3 = collider.ClosestPointOnBounds (transform.position - Vector3.up * 100);
			scorchMark.transform.position = scorchPosition + Vector3.up * 0.1;
			scorchMark.transform.eulerAngles.y = Random.Range (0.0, 90.0);
		}
	}
}

function OnEnable () {
	Regenerate ();	
}

// Regenerate health

function Regenerate () {
	if (regenerateSpeed > 0.0 && this.gameObject.tag == "Player") {
		while (enabled) {
			if (Time.time > lastDamageTime + 3) {
				health += regenerateSpeed;
				
				yield;
				
				if (health >= maxHealth) {
					health = maxHealth;
					enabled = false;
				}
			}
			yield WaitForSeconds (1.0);
		}
	}
}
