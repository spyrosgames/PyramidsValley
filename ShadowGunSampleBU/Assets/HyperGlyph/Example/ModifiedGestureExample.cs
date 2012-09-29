using UnityEngine;
using System.Collections;

public class ModifiedGestureExample : MonoBehaviour 
{
	public GestureSet myGestures;
	public HyperGlyphResult match;

	public GUIStyle myStyle;
	private Touch touch;
	public Camera GesturesCamera;
	private MagicsFactory magicsFactory;
	private float swipeSpeed = 0.1f;
	private int count;
	private bool touchStarted = false;
	private Touch currentGestureTouch;
	private int numberOfGestureTouch = 0;

	public GUITexture gesturesLockTextureRight;
	public GUITexture gesturesLockTextureLeft;

	void Awake()
	{
		magicsFactory = GetComponent<MagicsFactory>();
	}

	void Start () 
	{
		HyperGlyph.Init(myGestures);
	}
	
	void Update () 
	{
		count = Input.touchCount;

		if(count > 0)
		{
			//int numberOfGestureTouch = 0;
			if(count == 1)
			{
				numberOfGestureTouch = 0;
			}
			else if(count == 2)
			{
				numberOfGestureTouch = 1;
			}
			else if(count == 3)
			{
				numberOfGestureTouch = 2;
			}
			currentGestureTouch = Input.GetTouch(numberOfGestureTouch);

			//if(currentGestureTouch.phase == TouchPhase.Moved && currentGestureTouch.position.y >= Screen.height * 0.25 && currentGestureTouch.position.y <= Screen.height)
			if(currentGestureTouch.phase == TouchPhase.Moved && !gesturesLockTextureRight.HitTest(currentGestureTouch.position) && !gesturesLockTextureLeft.HitTest(currentGestureTouch.position) && currentGestureTouch.position.y >= Screen.height * 0.1)
			{
				touchStarted = true;
				//transform.position = GesturesCamera.ScreenToWorldPoint(new Vector3(Input.GetTouch(numberOfGestureTouch).position.x, Input.GetTouch(numberOfGestureTouch).position.y, 1));
				transform.position = GesturesCamera.ScreenToWorldPoint(Vector3.Lerp(transform.position, new Vector3(currentGestureTouch.position.x, currentGestureTouch.position.y, 1), 10000*Time.deltaTime));

				//if(Input.mousePosition.y >= 160 && Input.mousePosition.y <= 320)
				//{
				//This next line moves our empty gameobject so the trail renderer can draw a line for us.
					//transform.position = Camera.main.ScreenToWorldPoint(new Vector3(Input.GetTouch(numberOfGestureTouch).position.x, Input.GetTouch(numberOfGestureTouch).position.y, 10));
					//transform.position = GesturesCamera.ScreenToWorldPoint(new Vector3(Input.GetTouch(numberOfGestureTouch).position.x, Input.GetTouch(numberOfGestureTouch).position.y, 1));

				HyperGlyph.AddPoint(currentGestureTouch.position);
				//}
			}
			if(currentGestureTouch.phase == TouchPhase.Ended && touchStarted == true)
			{
				match = HyperGlyph.Recognize();
				if(match.glyphname == "Stun")
				{
					magicsFactory.getMagicEffect("Stun");
					magicsFactory.disableMagicEffect("Stun", 3.0f); //disabling the magic effect should be after the cooldown that's assigned to it from the store according to upgrades
				}
				if(match.glyphname == "LightningStrike")
				{
					magicsFactory.getMagicEffect("LightningStrike");
				}
				if(match.glyphname == "Tornado")
				{
					magicsFactory.getMagicEffect("Tornado");
				}
				if(match.glyphname == "Crowstorm")
				{
					magicsFactory.getMagicEffect("Crowstorm");
				}
				if(match.glyphname == "DustStorm")
				{
					magicsFactory.getMagicEffect("DustStorm");
				}
				if(match.glyphname == "Fire")
				{
					magicsFactory.getMagicEffect("Fire");
				}
				if(match.glyphname == "HolyFire")
				{
					magicsFactory.getMagicEffect("HolyFire");
				}
				if(match.glyphname == "Starfall")
				{
					magicsFactory.getMagicEffect("Starfall");
				}
				if(match.glyphname == "Electricity")
				{
					magicsFactory.getMagicEffect("Electricity");
				}
				touchStarted = false;
			}
		}


		
	}

	void OnGUI()
	{
		Rect GUIPosition = new Rect(15,Screen.height - 100,800,100);
		GUI.Label(GUIPosition, match.glyphname + 
				  "\nscore: " + match.score +
				  "\nbounds: " + match.bounds +
				  "\ndirec:" + match.direction , myStyle);
	}
}
