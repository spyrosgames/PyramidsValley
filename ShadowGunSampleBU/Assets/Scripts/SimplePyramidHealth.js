#pragma strict
public var PyramidHealthNumberGUIText : GUIText;
private var pyramidHealth : Health;
public var Pyramid : GameObject;

function Awake()
{
	pyramidHealth = Pyramid.GetComponent.<Health>();
}

function Start () {

}

function Update () {
	if(PyramidHealthNumberGUIText != null && pyramidHealth.health >= 0 && pyramidHealth != null)
	{
		PyramidHealthNumberGUIText.text = pyramidHealth.health + "%";
	}
}