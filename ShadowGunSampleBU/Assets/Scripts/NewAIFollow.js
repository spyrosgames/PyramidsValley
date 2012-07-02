
private var target : Transform;
private var player : Transform;
private var pyramid : Transform;
private var mechAttackMoveController : MechAttackMoveController;

// Use this for initialization
function Awake()
{
	player = GameObject.FindWithTag("Player").transform;
	pyramid = GameObject.FindWithTag("Pyramid").transform;
	mechAttackMoveController = GetComponentInChildren(MechAttackMoveController);
}

function Start () {
	
}

// Update is called once per frame
function Update () {
	if(mechAttackMoveController.pyramidInRange == true)
	{
		GameObject.GetComponent.<NavMeshAgent>().destination = pyramid.position;
	}
	else if(mechAttackMoveController.inRange == true)
	{
		GameObject.GetComponent.<NavMeshAgent>().destination = player.position;	
	}
	
}
