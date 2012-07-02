#pragma strict
private var globals : Globals;
public var enemiesNumberMonitor : GUIText;
function Awake()
{
	globals = Globals.GetInstance();
}

function Start () {

}

function Update () {
	enemiesNumberMonitor.text = globals.numberOfCurrentEnemiesInstantiated + "";
}