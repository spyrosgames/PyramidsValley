using UnityEngine;
using System.Collections;

public class NewAIFollow : MonoBehaviour {
	private Transform target;
	private Transform player;
	private float playerHealth;
	private Vector3 playerDirection;
	private Vector3 pyramidDirection;
	private float walkingSpeed = 4.0f;
	private float maxDistance = 5.0f;

	public AnimationClip walkAnimation;
	public AnimationClip idleAnimation;
	public AnimationClip deathAnimation;

	public GameObject enemyBody;
	private float enemyInitialSpeed;
	public bool isDead = false;


	// Use this for initialization
	void Awake()
	{
		player = GameObject.FindWithTag("Player").transform;
		playerHealth = player.GetComponent<Health>().health;
		enemyInitialSpeed = GetComponent<NavMeshAgent>().speed;
	}

	void Start () {
		
	}

	// Update is called once per frame
	void Update () {
		if(playerHealth > 0 && isDead == false)
		{
		//GetComponent<NavMeshAgent>().destination = player.position;
		transform.LookAt(new Vector3(player.transform.position.x, transform.position.y, player.transform.position.z));
		
		if(Vector3.Distance(player.position, transform.position) > maxDistance)
		{
			GetComponent<NavMeshAgent>().destination = player.position;
			GetComponent<NavMeshAgent>().speed = enemyInitialSpeed;
			enemyBody.animation.CrossFade(walkAnimation.name, 0.2f);
			enemyBody.animation[walkAnimation.name].speed = 1.6f;

		}
		else
		{
			//GetComponent<NavMeshAgent>().destination = player.position;
			GetComponent<NavMeshAgent>().speed = 0;                                   //DON'T REMOVE THIS
			if(this.gameObject.name == "RangedEnemy" && isDead == false)
			{
				enemyBody.animation.CrossFade(idleAnimation.name, 0.2f);
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

	void OnSignal()
	{
		Debug.Log("OnSignal of death Animation");
		isDead = true;
		GetComponent<NavMeshAgent>().Stop(true);
		enemyBody.animation.CrossFade(deathAnimation.name, 0.3f, PlayMode.StopAll);
	}
	
}
