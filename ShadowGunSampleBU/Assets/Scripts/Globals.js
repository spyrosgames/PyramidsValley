class Globals
{
	public var enemiesKilled : int;
	public var callInstantiate : boolean;
	public var XPPoints : int = 10;
	public var level : int = 1;
	public var coins : int = 10;
	public var jewels : int = 10;
	public var levelUpCoinsReward : int = 0;
	public var levelUpJewelsReward : int = 0;
	public var numberOfIsisMagics : int = 2;
	public var numberOfSethMagics : int = 16;
	public var numberOfSekhmetMagics : int = 2;
	public var numberOfMontoMagics : int = 2;
	public var numberOfAmounMagics : int = 2;
	public var numberOfRaaMagics : int = 2;
	public var numberOfAnubisMagics : int = 2;

	public var anubisMagicActiveNumber : int = 0;

	public var lives : int;

	public var numberOfCurrentEnemiesInstantiated : int;
	
	private static var Instance : Globals;

	protected function Globals()
	{
		enemiesKilled = 0;
		callInstantiate = true;
		lives = 3;
	}
	
	public static function GetInstance() : Globals
	{
		if(Instance == null)
		{
			Instance = new Globals();
		}
		return Instance;
	}
}