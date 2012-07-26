#pragma strict
public var PyramidHealthNumberGUIText : GUIText;
private var pyramidHealth : Health;
public var Pyramid : GameObject;
public var smallFont : Font;
public var bigFont : Font;
public var fontMaterial : Material;
public var smallFontTexture : Texture2D;
public var bigFontTexture : Texture2D;

function Awake()
{
	pyramidHealth = Pyramid.GetComponent.<Health>();
}

function Start () {
	if(Screen.currentResolution.width < 1024)
	{
		PyramidHealthNumberGUIText.font = smallFont;
		fontMaterial.mainTexture = smallFontTexture;
	}
	else if(Screen.currentResolution.width >= 1024 && Screen.currentResolution.width < 1280)
	{
		PyramidHealthNumberGUIText.font = bigFont;
		fontMaterial.mainTexture = bigFontTexture;
	}
}

function Update () {
	if(PyramidHealthNumberGUIText != null && pyramidHealth.health >= 0 && pyramidHealth != null)
	{
		PyramidHealthNumberGUIText.text = pyramidHealth.health + "%";
	}
}