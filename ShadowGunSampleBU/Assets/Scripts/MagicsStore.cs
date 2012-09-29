using UnityEngine;
using System.Collections;

class MagicsStore : MonoBehaviour {
	public Texture2D stunIcon;
	public Texture2D frenzyIcon;
	public Texture2D healIcon;
	public Texture2D teleportIcon;
	public Texture2D hasteIcon;

	private MagicsFactory magicsFactory;
	private float StunCoolDown;
	private float FrenzyCoolDown;
	private float HealCoolDown;
	private float TeleportCoolDown;
	private float HasteCoolDown;

	private bool stunIconEnabled;
	private bool frenzyIconEnabled;
	private bool healIconEnabled;
	private bool teleportIconEnabled;
	private bool hasteIconEnabled;
	private bool nextButtonEnabled;
	// Use this for initialization
	void Start () {
		magicsFactory = GetComponent<MagicsFactory>();
		StunCoolDown = 2;
		FrenzyCoolDown = 2;
		HealCoolDown = 2;
		TeleportCoolDown = 2;
		HasteCoolDown = 4;

		stunIconEnabled = true;
		frenzyIconEnabled = true;
		healIconEnabled = true;
		teleportIconEnabled = true;
		hasteIconEnabled = true;
		nextButtonEnabled = false;
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI()
	{
		GUI.enabled = stunIconEnabled;
		if(GUI.Button(new Rect(20, 20, 40, 40), stunIcon))
		{
			if(!magicsFactory.checkForMagicInTable("Stun"))
			{
				magicsFactory.addMagicToTable("Stun", 0, StunCoolDown);
				//To be changed
				magicsFactory.addFirstMagic("Stun");
				stunIconEnabled = false;
			}
		}
		GUI.enabled = frenzyIconEnabled;
		//Damage boost : increases attack damage amount
		if(GUI.Button(new Rect(20, 80, 40, 40), frenzyIcon))
		{
			if(!magicsFactory.checkForMagicInTable("Frenzy"))
			{
				magicsFactory.addMagicToTable("Frenzy", 1, FrenzyCoolDown);
				magicsFactory.addThirdMagic("Frenzy");
				frenzyIconEnabled = false;
			}
		}
		GUI.enabled = healIconEnabled;
		if(GUI.Button(new Rect(20, 140, 40, 40), healIcon))
		{
			if(!magicsFactory.checkForMagicInTable("Heal"))
			{
				magicsFactory.addMagicToTable("Heal", 2, HealCoolDown);
				magicsFactory.addSecondMagic("Heal");
				healIconEnabled = false;
			}
		}
		/*
		GUI.enabled = teleportIconEnabled;
		if(GUI.Button(new Rect(20, 200, 40, 40), teleportIcon))
		{
			if(!magicsFactory.checkForMagicInTable("Teleport"))
			{
				magicsFactory.addMagicToTable("Teleport", 3, TeleportCoolDown);
				magicsFactory.addFourthMagic("Teleport");
				teleportIconEnabled = false;
				nextButtonEnabled = true;
			}
		}*/
		GUI.enabled = hasteIconEnabled;
		if(GUI.Button(new Rect(20, 200, 40, 40), hasteIcon))
		{
			if(!magicsFactory.checkForMagicInTable("Haste"))
			{
				magicsFactory.addMagicToTable("Haste", 3, HasteCoolDown);
				magicsFactory.addFourthMagic("Haste");
				hasteIconEnabled = false;
				nextButtonEnabled = true;
			}
		}

		GUI.enabled = nextButtonEnabled;
		if(GUI.Button(new Rect(20, 260, 40, 40), "Next"))
		{
			GetComponent<MagicsStore>().enabled = false;
			Application.LoadLevel("test2copy");
		}
	}
}
