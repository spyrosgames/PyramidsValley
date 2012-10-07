#pragma strict

private var wavesMonitor : WavesMonitor;

function Awake()
{
	wavesMonitor = GetComponent.<WavesMonitor>();
	
}

function Start()
{
	wavesMonitor.AnimateArmyTitle();
	wavesMonitor.AnimateWaveTitle();

	wavesMonitor.InstantiateEnemies();
}