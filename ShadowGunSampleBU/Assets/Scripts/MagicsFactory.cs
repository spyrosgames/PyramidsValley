using UnityEngine;
using System.Collections;
using System.Reflection;

class MagicsFactory : MonoBehaviour {
	private Hashtable magicsTable = new Hashtable();
	private Hashtable magicsCoolDownTable = new Hashtable();
	private Hashtable inGameMagicsTable = new Hashtable();
	//to be removed
	//public GUIText debugGUIText;
	private GameObject[] enemies;
	private GameObject player;
	private Health playerHealth;
	private AutoFire autoFire;
	private FreeMovementMotor freeMovementMotor;
	private float originalDamagePerSecond;
	private float originalWalkingSpeed;
	public AnimationClip meleeIdleAnimation;
	public AnimationClip rangedIdleAnimation;
	public AnimationClip meleeMoveForwardAnimation;
	public AnimationClip rangedMoveForwardAnimation;

	public GameObject StunMagicVisualEffect;
	public GameObject LightningStrikeMagicVisualEffect;
	public GameObject TornadoMagicVisualEffect;
	public GameObject CrowstormMagicVisualEffect;
	public GameObject DustStormMagicVisualEffect;
	public GameObject FireMagicVisualEffect;
	public GameObject HolyFireMagicVisualEffect;
	public GameObject ElectricityMagicVisualEffect;
	public GameObject StarfallMagicVisualEffect;

	public GameObject TornadoCheckpoint1;

	public GameObject MainCamera;


	public MagicsFactory()
	{

	}

	public void addMagicToTable(string name, int iconID, float coolDownTime)
	{
		magicsTable.Add(name, iconID);
		magicsCoolDownTable.Add(name, coolDownTime);
	}

	public int getIcon(string name)
	{
		int iconID = (int)magicsTable[name];
		return iconID;
	}

	public float getCoolDownTime(string name)
	{
		float coolDownTime = (float)magicsCoolDownTable[name];
		return coolDownTime;
	}

	public bool checkForMagicInTable(string name)
	{
		return magicsTable.Contains(name);
	}

	public void getMagicEffect(string name)
	{		
		string magicFullName = name + "MagicEffect";
		SendMessage(magicFullName);
		/*
		//Using reflection
		MethodInfo addMethod = this.GetType().GetMethod(magicFullName);
		addMethod.Invoke(this, new object[] {});
		*/
	}
	public void disableMagicEffect(string name, float coolDownTime)
	{
		string disableMagicFunctionFullName = "Disable" + name + "MagicEffect";
		Invoke(disableMagicFunctionFullName, coolDownTime);
	}

	public void addFirstMagic(string name)
	{
		inGameMagicsTable.Add(1, name);
	}

	public void addSecondMagic(string name)
	{
		inGameMagicsTable.Add(2, name);
	}

	public void addThirdMagic(string name)
	{
		inGameMagicsTable.Add(3, name);
	}

	public void addFourthMagic(string name)
	{
		inGameMagicsTable.Add(4, name);
	}

	public string getInGameMagic(int magicNumber)
	{
		return (string)inGameMagicsTable[magicNumber];
	}

	private void LightningStrikeMagicEffect()
	{
		//player = GameObject.FindWithTag("Player");
		enemies = GameObject.FindGameObjectsWithTag("Enemy");
		//for(int i = 0; i < (int)Random.Range(enemies.Length * 0.5f, enemies.Length); i++)
		for(int i = 0; i < enemies.Length; i++)
		{
			//if(MainCamera != null)
			//{
				//Vector3 enemyPositionInsideScreen = MainCamera.camera.WorldToScreenPoint(enemies[i].transform.position);
				//if(enemyPositionInsideScreen.x > 0 && enemyPositionInsideScreen.x < Screen.width && enemyPositionInsideScreen.y > 0 && enemyPositionInsideScreen.y < Screen.height)
				//{
						Health enemyHealth = enemies[i].transform.GetComponent<Health>();
						GameObject destructionEffect = Instantiate(LightningStrikeMagicVisualEffect, new Vector3(enemies[i].gameObject.transform.position.x, enemies[i].gameObject.transform.position.y + 3, enemies[i].gameObject.transform.position.z), Quaternion.identity) as GameObject;
						destructionEffect.transform.parent = enemies[i].gameObject.transform;
						if(enemies[i].GetComponent<NewAIFollowJavaScript>().isDead == false && enemyHealth.dead == false)
						{
							enemyHealth.OnDamage(100, -enemies[i].transform.forward);	
						}
					//enemyHealth.dieSignals.SendSignals(enemyHealth);
				//}
			//}
		}

	}

	private void HolyFireMagicEffect()
	{
		enemies = GameObject.FindGameObjectsWithTag("Enemy");
		//for(int i = 0; i < (int)Random.Range(enemies.Length * 0.5f, enemies.Length); i++)
		for(int i = 0; i < enemies.Length; i++)
		{
			//f(MainCamera != null)
			//{
				//Vector3 enemyPositionInsideScreen = MainCamera.camera.WorldToScreenPoint(enemies[i].transform.position);
				//if(enemyPositionInsideScreen.x > 0 && enemyPositionInsideScreen.x < Screen.width && enemyPositionInsideScreen.y > 0 && enemyPositionInsideScreen.y < Screen.height)
				//{
					Health enemyHealth = enemies[i].transform.GetComponent<Health>();
					GameObject holyFireObj = Instantiate(HolyFireMagicVisualEffect, new Vector3(enemies[i].gameObject.transform.position.x, enemies[i].gameObject.transform.position.y, enemies[i].gameObject.transform.position.z), Quaternion.identity) as GameObject;
					holyFireObj.transform.parent = enemies[i].gameObject.transform;
					if(enemyHealth.health > 0)
					{
						enemyHealth.OnDamage(100, -enemies[i].transform.forward);
					}
					
					//enemyHealth.dieSignals.SendSignals(enemyHealth);
				//}
			//}
		}	
	}

	private void StunMagicEffect()
	{
		//debugGUIText.text = "Stun!";
		enemies = GameObject.FindGameObjectsWithTag("Enemy");
		for(int i = 0; i < enemies.Length; i++)
		{
			enemies[i].GetComponent<NavMeshAgent>().Stop(true);

			GameObject stuffEffect = Instantiate(StunMagicVisualEffect, new Vector3(enemies[i].gameObject.transform.position.x, enemies[i].gameObject.transform.position.y + 2, enemies[i].gameObject.transform.position.z), Quaternion.identity) as GameObject;
			stuffEffect.transform.parent = enemies[i].gameObject.transform;
		}
		//Invoke("DisableStunMagicEffect", 2);

		
	}
	private void DisableStunMagicEffect()
	{
		for(int i = 0; i < enemies.Length; i++)
		{
			enemies[i].GetComponent<NavMeshAgent>().Resume();
		}
	}
	private void FrenzyMagicEffect()
	{
		//debugGUIText.text = "Frenzy";
		player = GameObject.FindWithTag("Player");
		autoFire = player.GetComponentInChildren<AutoFire>();
		originalDamagePerSecond = autoFire.damagePerSecond;
		autoFire.damagePerSecond *= 2;
		//Invoke("DisableFrenzyMagicEffect", 4f);
	}

	private void DisableFrenzyMagicEffect()
	{
		player = GameObject.FindWithTag("Player");
		autoFire = player.GetComponentInChildren<AutoFire>();
		autoFire.damagePerSecond = originalDamagePerSecond;
	}

	private void HealMagicEffect()
	{
		//debugGUIText.text = "Heal";
		player = GameObject.FindWithTag("Player");
		playerHealth = player.GetComponent<Health>();
		playerHealth.health = playerHealth.maxHealth;
	}
	private void TeleportMagicEffect()
	{
		//debugGUIText.text = "Teleport";
	}

	private void HasteMagicEffect()
	{
		//debugGUIText.text = "Haste";
		player = GameObject.FindWithTag("Player");
		freeMovementMotor = player.GetComponent<FreeMovementMotor>();
		originalWalkingSpeed = freeMovementMotor.walkingSpeed;
		freeMovementMotor.walkingSpeed *= 2;

		//Invoke("DisableHasteMagicEffect", 4f); //cool down times should be got from the user choice
	}

	private void DisableHasteMagicEffect()
	{
		player = GameObject.FindWithTag("Player");
		freeMovementMotor = player.GetComponent<FreeMovementMotor>();
		freeMovementMotor.walkingSpeed = originalWalkingSpeed;
	}

	private void TornadoMagicEffect()
	{
		player = GameObject.FindWithTag("Player");
		GameObject tornadoObj = Instantiate(TornadoMagicVisualEffect, player.transform.position, Quaternion.identity) as GameObject;
		
		Vector3 firstPoint = TornadoCheckpoint1.transform.position;
		Vector3 secondPoint = firstPoint + new Vector3(-5, 0, 6);
		Vector3 thirdPoint = secondPoint + new Vector3(20, 0, 0);
		Vector3 fourthPoint = thirdPoint + new Vector3(-30, 0, -6);

		Vector3[] path = new Vector3[4];
		path[0] = firstPoint;
		path[1] = secondPoint;
		path[2] = thirdPoint;
		path[3] = fourthPoint;
		/*
		Hashtable ht = new Hashtable();
		ht.Add("x", player.transform.localPosition.x);
		ht.Add("time", 30);
		ht.Add("path", path);
		*/
		iTween.MoveTo(tornadoObj, iTween.Hash("x", 0, "time", 30, "path", path));
	}

	private IEnumerator CrowstormMagicEffect()
	{
		player = GameObject.FindWithTag("Player");
		GameObject crowstormObj = Instantiate(CrowstormMagicVisualEffect, new Vector3(player.transform.position.x, player.transform.position.y + 1, player.transform.position.z), Quaternion.identity) as GameObject;
		crowstormObj.name = "CrowstormGO";
		crowstormObj.transform.parent = player.transform;
		
		Transform[] crowstormobjects;
		crowstormobjects = crowstormObj.GetComponentsInChildren<Transform>();
		
		foreach(Transform crowstormobj in crowstormobjects)
		{
			if(crowstormobj != null)
			{
				if(crowstormobj.name == "CrowStorm_Main")
				{
					crowstormobj.transform.parent = player.transform.parent;
					yield return new WaitForSeconds(5.6f);
					crowstormobj.transform.parent = crowstormObj.transform;
				}
			}
		}
		
	}

	private void DustStormMagicEffect()
	{
		enemies = GameObject.FindGameObjectsWithTag("Enemy");
		//for(int i = 0; i < (int)Random.Range(enemies.Length * 0.5f, enemies.Length); i++)
		for(int i = 0; i < enemies.Length; i++)
		{
			//if(MainCamera != null)
			//{
				//Vector3 enemyPositionInsideScreen = MainCamera.camera.WorldToScreenPoint(enemies[i].transform.position);
				//if(enemyPositionInsideScreen.x > 0 && enemyPositionInsideScreen.x < Screen.width && enemyPositionInsideScreen.y > 0 && enemyPositionInsideScreen.y < Screen.height)
				//{
					Health enemyHealth = enemies[i].transform.GetComponent<Health>();
					GameObject dustStormObj = Instantiate(DustStormMagicVisualEffect, new Vector3(enemies[i].gameObject.transform.position.x, enemies[i].gameObject.transform.position.y + 3, enemies[i].gameObject.transform.position.z), Quaternion.identity) as GameObject;
					dustStormObj.transform.parent = enemies[i].gameObject.transform;
					if(enemyHealth.health > 0)
					{
						enemyHealth.OnDamage(100, -enemies[i].transform.forward);	
					}
					//enemyHealth.dieSignals.SendSignals(enemyHealth);
				//}
			//}
		}
	}

	private IEnumerator FireMagicEffect()
	{
		player = GameObject.FindWithTag("Player");
		Vector3 firstPoint = TornadoCheckpoint1.transform.position;
		Vector3 secondPoint = firstPoint + new Vector3(-7, 0, 6);
		Vector3 thirdPoint = secondPoint + new Vector3(14, 0, 0);
		Vector3 fourthPoint = thirdPoint + new Vector3(-11, 0, -3);
		Vector3 fifthPoint = fourthPoint + new Vector3(5, 0, 6);
		Vector3 sixthPoint = fifthPoint + new Vector3(2, 0, -6);

		Vector3[] firePoints = new Vector3[6];
		firePoints[0] = firstPoint;
		firePoints[1] = secondPoint;
		firePoints[2] = thirdPoint;
		firePoints[3] = fourthPoint;
		firePoints[4] = fifthPoint;
		firePoints[5] = sixthPoint;

		for(int i = 0; i < firePoints.Length; i++)
		{
			GameObject fireObj = Instantiate(FireMagicVisualEffect, firePoints[i], Quaternion.identity) as GameObject;
			fireObj.transform.parent = player.transform;
			yield return new WaitForSeconds(0.4f);
		}
	}

	private IEnumerator ElectricityMagicEffect()
	{
		player = GameObject.FindWithTag("Player");
		Vector3 firstPoint = TornadoCheckpoint1.transform.position;
		Vector3 secondPoint = firstPoint + new Vector3(-7, 0, 6);
		Vector3 thirdPoint = secondPoint + new Vector3(14, 0, 0);
		Vector3 fourthPoint = thirdPoint + new Vector3(-11, 0, -3);
		Vector3 fifthPoint = fourthPoint + new Vector3(5, 0, 6);
		Vector3 sixthPoint = fifthPoint + new Vector3(2, 0, -6);

		Vector3[] electricityPoints = new Vector3[6];
		electricityPoints[0] = firstPoint;
		electricityPoints[1] = secondPoint;
		electricityPoints[2] = thirdPoint;
		electricityPoints[3] = fourthPoint;
		electricityPoints[4] = fifthPoint;
		electricityPoints[5] = sixthPoint;

		for(int i = 0; i < electricityPoints.Length; i++)
		{
			GameObject electricityObj = Instantiate(ElectricityMagicVisualEffect, electricityPoints[i], Quaternion.identity) as GameObject;
			electricityObj.transform.parent = player.transform;
			yield return new WaitForSeconds(0.4f);
		}
	}

	private IEnumerator StarfallMagicEffect()
	{
		player = GameObject.FindWithTag("Player");

		enemies = GameObject.FindGameObjectsWithTag("Enemy");

		//for(int i = 0; i < (int)Random.Range(enemies.Length * 0.5f, enemies.Length); i++)
		for(int i = 0; i < enemies.Length; i++)
		{
			//if(MainCamera != null)
			//{
				//Vector3 enemyPositionInsideScreen = MainCamera.camera.WorldToScreenPoint(enemies[i].transform.position);
				//if(enemyPositionInsideScreen.x > 0 && enemyPositionInsideScreen.x < Screen.width && enemyPositionInsideScreen.y > 0 && enemyPositionInsideScreen.y < Screen.height)
				//{
					Health enemyHealth = enemies[i].transform.GetComponent<Health>();
					GameObject starfallObj = Instantiate(StarfallMagicVisualEffect, new Vector3(enemies[i].gameObject.transform.position.x, enemies[i].gameObject.transform.position.y + 3, enemies[i].gameObject.transform.position.z), Quaternion.identity) as GameObject;
					starfallObj.transform.parent = enemies[i].gameObject.transform;
					if(enemyHealth.health > 0)
					{
						enemyHealth.OnDamage(100, -enemies[i].transform.forward);	
					}
					//enemyHealth.dieSignals.SendSignals(enemyHealth);
				//}
			//}
			yield return new WaitForSeconds(0.4f);
		}

	}

	private void ScrubsMagicEffect()
	{

	}

	void Awake()
	{

	}

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
