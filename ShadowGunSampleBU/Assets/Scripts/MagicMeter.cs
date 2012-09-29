using UnityEngine;
using System.Collections;

public class MagicMeter : MonoBehaviour {
	private MagicsFactory magicsFactory;

	private string firstMagic;
	private string secondMagic;
	private string thirdMagic;
	private string fourthMagic;

	public GUITexture firstMagicGUITexture;
	public GUITexture firstMagicCoolDownGUITexture;
	public GUITexture secondMagicGUITexture;
	public GUITexture secondMagicCoolDownGUITexture;
	public GUITexture thirdMagicGUITexture;
	public GUITexture thirdMagicCoolDownGUITexture;
	public GUITexture fourthMagicGUITexture;
	public GUITexture fourthMagicCoolDownGUITexture;


	public GUITexture rightBarGUITexture;
	public GUITexture leftBarGUITexture;

	public Texture2D[] MagicTexturesArray;
	public Texture2D[] InactiveMagicTexturesArray;
	public Texture2D[] CoolDownTexturesArray;

	private GameObject magicsStore;

	private float firstMagicAttackTimer;
	private float firstMagicCoolDown; //This value should be got from store

	private float secondMagicAttackTimer;
	private float secondMagicCoolDown; //This value should be got from store

	private float thirdMagicAttackTimer;
	private float thirdMagicCoolDown; //This value should be got from store

	private float fourthMagicAttackTimer;
	private float fourthMagicCoolDown; //This value should be got from store
	// Use this for initialization
	void Awake()
	{
		magicsStore = GameObject.FindWithTag("MagicsStore");
		magicsStore.GetComponent<MagicsStore>().enabled = false;
		magicsFactory = magicsStore.GetComponent<MagicsFactory>();
	}

	void Start () {
		firstMagic = magicsFactory.getInGameMagic(1);
		secondMagic = magicsFactory.getInGameMagic(2);
		thirdMagic = magicsFactory.getInGameMagic(3);
		fourthMagic = magicsFactory.getInGameMagic(4);

		firstMagicAttackTimer = 0;
		firstMagicCoolDown = magicsFactory.getCoolDownTime(firstMagic);

		secondMagicAttackTimer = 0;
		secondMagicCoolDown = magicsFactory.getCoolDownTime(secondMagic);

		thirdMagicAttackTimer = 0;
		thirdMagicCoolDown = magicsFactory.getCoolDownTime(thirdMagic);

		fourthMagicAttackTimer = 0;
		fourthMagicCoolDown = magicsFactory.getCoolDownTime(fourthMagic);

		firstMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(firstMagic)];
		secondMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(secondMagic)];
		thirdMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(thirdMagic)];
		fourthMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(fourthMagic)];
	}
	
	// Update is called once per frame
	void Update () {
		firstMagicCoolDownCheck();
		secondMagicCoolDownCheck();
		thirdMagicCoolDownCheck();
		fourthMagicCoolDownCheck();

		if (Input.touchCount > 0)
		{
			for(int i = 0; i < Input.touchCount;i++)
			{
				Touch touch = Input.GetTouch(i);
				// Check whether we are getting a touch and that it is within the bounds of
				// the title graphic
				if(firstMagicAttackTimer == 0)
				{
					if(touch.phase == TouchPhase.Moved && firstMagicGUITexture.HitTest(touch.position))
					{
						if(touch.phase == TouchPhase.Moved && rightBarGUITexture.HitTest(touch.position))
						{
							magicsFactory.getMagicEffect(firstMagic);
							magicsFactory.disableMagicEffect(firstMagic, firstMagicCoolDown); //disabling the magic effect should be after the cooldown that's assigned to it from the store according to upgrades
							firstMagicAttackTimer = firstMagicCoolDown;
							firstMagicGUITexture.texture = InactiveMagicTexturesArray[magicsFactory.getIcon(firstMagic)];
						}
					}
				}
					
				if(secondMagicAttackTimer == 0)
				{
					if(touch.phase == TouchPhase.Moved && secondMagicGUITexture.HitTest(touch.position))
					{
						if(touch.phase == TouchPhase.Moved && rightBarGUITexture.HitTest(touch.position))
						{
							magicsFactory.getMagicEffect(secondMagic);
							magicsFactory.disableMagicEffect(secondMagic, secondMagicCoolDown);
							secondMagicAttackTimer = secondMagicCoolDown;
							secondMagicGUITexture.texture = InactiveMagicTexturesArray[magicsFactory.getIcon(secondMagic)];
						}
					}
				}

				if(thirdMagicAttackTimer == 0)
				{
					if(touch.phase == TouchPhase.Moved && thirdMagicGUITexture.HitTest(touch.position))
					{
						if(touch.phase == TouchPhase.Moved && leftBarGUITexture.HitTest(touch.position))
						{
							magicsFactory.getMagicEffect(thirdMagic);
							magicsFactory.disableMagicEffect(thirdMagic, thirdMagicCoolDown); 

							thirdMagicAttackTimer = thirdMagicCoolDown;
							thirdMagicGUITexture.texture = InactiveMagicTexturesArray[magicsFactory.getIcon(thirdMagic)];
						}
					}
				}

				if(fourthMagicAttackTimer == 0)
				{
					if(touch.phase == TouchPhase.Moved && fourthMagicGUITexture.HitTest(touch.position))
					{
						if(touch.phase == TouchPhase.Moved && leftBarGUITexture.HitTest(touch.position))
						{
							magicsFactory.getMagicEffect(fourthMagic);
							magicsFactory.disableMagicEffect(fourthMagic, fourthMagicCoolDown);

							fourthMagicAttackTimer = fourthMagicCoolDown;
							fourthMagicGUITexture.texture = InactiveMagicTexturesArray[magicsFactory.getIcon(fourthMagic)];
						}
					}
				}
			}
		}
	}

	void firstMagicCoolDownCheck()
	{
		if(firstMagicAttackTimer > 0)
		{
			firstMagicAttackTimer -= Time.deltaTime;

			if(firstMagicAttackTimer > 0 * firstMagicCoolDown && firstMagicAttackTimer < 0.125 * firstMagicCoolDown)
			{
				firstMagicCoolDownGUITexture.texture = CoolDownTexturesArray[4];
			}
			if(firstMagicAttackTimer > 0.125 * firstMagicCoolDown && firstMagicAttackTimer < 0.25 * firstMagicCoolDown)
			{
				firstMagicCoolDownGUITexture.texture = CoolDownTexturesArray[3];
			}
			if(firstMagicAttackTimer > 0.375 * firstMagicCoolDown && firstMagicAttackTimer < 0.5 * firstMagicCoolDown)
			{
				firstMagicCoolDownGUITexture.texture = CoolDownTexturesArray[2];
			}
			if(firstMagicAttackTimer > 0.625 * firstMagicCoolDown && firstMagicAttackTimer < 0.75 * firstMagicCoolDown)
			{
				firstMagicCoolDownGUITexture.texture = CoolDownTexturesArray[1];
			}
			if(firstMagicAttackTimer > 0.875 * firstMagicCoolDown && firstMagicAttackTimer < firstMagicCoolDown)
			{
				firstMagicCoolDownGUITexture.texture = CoolDownTexturesArray[0];
			}
		}
		if(firstMagicAttackTimer < 0)
		{
			firstMagicAttackTimer = 0;
		}
		if(firstMagicAttackTimer == 0)
		{
			firstMagicCoolDownGUITexture.texture = null;
			firstMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(firstMagic)];
		}
	}

	void secondMagicCoolDownCheck()
	{
		if(secondMagicAttackTimer > 0)
		{
			secondMagicAttackTimer -= Time.deltaTime;

			if(secondMagicAttackTimer > 0 * secondMagicCoolDown && secondMagicAttackTimer < 0.125 * secondMagicCoolDown)
			{
				secondMagicCoolDownGUITexture.texture = CoolDownTexturesArray[4];
			}
			if(secondMagicAttackTimer > 0.125 * secondMagicCoolDown && secondMagicAttackTimer < 0.25 * secondMagicCoolDown)
			{
				secondMagicCoolDownGUITexture.texture = CoolDownTexturesArray[3];
			}
			if(secondMagicAttackTimer > 0.375 * secondMagicCoolDown && secondMagicAttackTimer < 0.5 * secondMagicCoolDown)
			{
				secondMagicCoolDownGUITexture.texture = CoolDownTexturesArray[2];
			}
			if(secondMagicAttackTimer > 0.625 * secondMagicCoolDown && secondMagicAttackTimer < 0.75 * secondMagicCoolDown)
			{
				secondMagicCoolDownGUITexture.texture = CoolDownTexturesArray[1];
			}
			if(secondMagicAttackTimer > 0.875 * secondMagicCoolDown && secondMagicAttackTimer < secondMagicCoolDown)
			{
				secondMagicCoolDownGUITexture.texture = CoolDownTexturesArray[0];
			}
		}
		if(secondMagicAttackTimer < 0)
		{
			secondMagicAttackTimer = 0;
		}
		if(secondMagicAttackTimer == 0)
		{
			secondMagicCoolDownGUITexture.texture = null;
			secondMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(secondMagic)];
		}
	}

	void thirdMagicCoolDownCheck()
	{
		if(thirdMagicAttackTimer > 0)
		{
			thirdMagicAttackTimer -= Time.deltaTime;

			if(thirdMagicAttackTimer > 0 * thirdMagicCoolDown && thirdMagicAttackTimer < 0.125 * thirdMagicCoolDown)
			{
				thirdMagicCoolDownGUITexture.texture = CoolDownTexturesArray[4];
			}
			if(thirdMagicAttackTimer > 0.125 * thirdMagicCoolDown && thirdMagicAttackTimer < 0.25 * thirdMagicCoolDown)
			{
				thirdMagicCoolDownGUITexture.texture = CoolDownTexturesArray[3];
			}
			if(thirdMagicAttackTimer > 0.375 * thirdMagicCoolDown && thirdMagicAttackTimer < 0.5 * thirdMagicCoolDown)
			{
				thirdMagicCoolDownGUITexture.texture = CoolDownTexturesArray[2];
			}
			if(thirdMagicAttackTimer > 0.625 * thirdMagicCoolDown && thirdMagicAttackTimer < 0.75 * thirdMagicCoolDown)
			{
				thirdMagicCoolDownGUITexture.texture = CoolDownTexturesArray[1];
			}
			if(thirdMagicAttackTimer > 0.875 * thirdMagicCoolDown && thirdMagicAttackTimer < thirdMagicCoolDown)
			{
				thirdMagicCoolDownGUITexture.texture = CoolDownTexturesArray[0];
			}
		}
		if(thirdMagicAttackTimer < 0)
		{
			thirdMagicAttackTimer = 0;
		}
		if(thirdMagicAttackTimer == 0)
		{
			thirdMagicCoolDownGUITexture.texture = null;
			thirdMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(thirdMagic)];
		}
	}

	void fourthMagicCoolDownCheck()
	{
		if(fourthMagicAttackTimer > 0)
		{
			fourthMagicAttackTimer -= Time.deltaTime;

			if(fourthMagicAttackTimer > 0 * fourthMagicCoolDown && fourthMagicAttackTimer < 0.125 * fourthMagicCoolDown)
			{
				fourthMagicCoolDownGUITexture.texture = CoolDownTexturesArray[4];
			}
			if(fourthMagicAttackTimer > 0.125 * fourthMagicCoolDown && fourthMagicAttackTimer < 0.25 * fourthMagicCoolDown)
			{
				fourthMagicCoolDownGUITexture.texture = CoolDownTexturesArray[3];
			}
			if(fourthMagicAttackTimer > 0.375 * fourthMagicCoolDown && fourthMagicAttackTimer < 0.5 * fourthMagicCoolDown)
			{
				fourthMagicCoolDownGUITexture.texture = CoolDownTexturesArray[2];
			}
			if(fourthMagicAttackTimer > 0.625 * fourthMagicCoolDown && fourthMagicAttackTimer < 0.75 * fourthMagicCoolDown)
			{
				fourthMagicCoolDownGUITexture.texture = CoolDownTexturesArray[1];
			}
			if(fourthMagicAttackTimer > 0.875 * fourthMagicCoolDown && fourthMagicAttackTimer < fourthMagicCoolDown)
			{
				fourthMagicCoolDownGUITexture.texture = CoolDownTexturesArray[0];
			}
		}
		if(fourthMagicAttackTimer < 0)
		{
			fourthMagicAttackTimer = 0;
		}
		if(fourthMagicAttackTimer == 0)
		{
			fourthMagicCoolDownGUITexture.texture = null;
			fourthMagicGUITexture.texture = MagicTexturesArray[magicsFactory.getIcon(fourthMagic)];
		}
	}
}
