
	private var target : Transform;
	private var player : Transform;
	private var playerHealth : float;
	private var playerDirection : Vector3 ;
	private var pyramidDirection : Vector3 ;
	private var walkingSpeed : float = 4.0;
	private var maxDistance : float = 5.0;

	public var walkAnimation : AnimationClip ;
	public var idleAnimation : AnimationClip ;
	public var deathAnimation : AnimationClip ;

	public var enemyBody : GameObject;
	private var enemyInitialSpeed : float;
	public var isDead : boolean = false;


	// Use this for initialization
	function Awake()
	{
		player = GameObject.FindWithTag("Player").transform;
		playerHealth = player.GetComponent.<Health>().health;
		enemyInitialSpeed = GetComponent.<NavMeshAgent>().speed;
	}

	function Start () {
		
	}

	// Update is called once per frame
	function Update () {
		if(playerHealth > 0 && isDead == false)
		{
		//GetComponent<NavMeshAgent>().destination = player.position;
		transform.LookAt(Vector3(player.transform.position.x, transform.position.y, player.transform.position.z));
		
		if(Vector3.Distance(player.position, transform.position) > maxDistance)
		{
			GetComponent.<NavMeshAgent>().destination = player.position;
			GetComponent.<NavMeshAgent>().speed = enemyInitialSpeed;
			enemyBody.animation.CrossFade(walkAnimation.name, 0.2);
			enemyBody.animation[walkAnimation.name].speed = 1.6;

		}
		else
		{
			//GetComponent<NavMeshAgent>().destination = player.position;
			GetComponent.<NavMeshAgent>().speed = 0;                                   //DON'T REMOVE THIS
			if(this.gameObject.name == "RangedEnemy")
			{
				enemyBody.animation.CrossFade(idleAnimation.name, 0.2);
			}

		}
		/*
		if(player.rigidbody.velocity == new Vector3(0, 0, 0))
		{
			RaycastHit hit;
			Physics.Raycast(transform.position, transform.forward, out hit);
			if(hit.distance < 0.07 && hit.transform.tag == "Enemy") {
				GetComponent<NavMeshAgent>().speed = 0;
				enemyBody.animation.CrossFade(idleAnimation.name, 0.1f);
			}			
		}
		*/
		}
	}

	function OnSignal()
	{
		isDead = true;
		enemyBody.animation.CrossFade(deathAnimation.name, 0.1, PlayMode.StopAll);
		GetComponent.<NavMeshAgent>().Stop(true);
		
	}
	
