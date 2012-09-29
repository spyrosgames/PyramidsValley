using UnityEngine;
using System.Collections;

public class NewAIFollow : MonoBehaviour {
	private Transform target;
	private Transform player;
	private Vector3 playerDirection;
	private Vector3 pyramidDirection;
	private float walkingSpeed = 4.0f;
	private float maxDistance = 4.0f;

	// Use this for initialization
	void Awake()
	{
		player = GameObject.FindWithTag("Player").transform;
	}

	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

		/*
		playerDirection = (player.position - transform.position);

		if(pyramid != null)
		{
			//Calculate the direction from pyramid to this character
			pyramidDirection = (pyramid.position - transform.position);
			//var pyramidDirection : Vector3 = (pyramid.position - character.position);	
		}
		else
		{
			pyramidDirection = new Vector3(playerDirection.x * 2, playerDirection.y * 2, playerDirection.z * 2);
		}

		playerDirection.y = 0;
		pyramidDirection.y = 0;

		float playerDist = playerDirection.magnitude;

		float pyramidDist = pyramidDirection.magnitude;
		
		*/
		if(Vector3.Distance(player.position, transform.position) > maxDistance)
		{
			GetComponent<NavMeshAgent>().destination = player.position;
		}

		/*
		//if( (playerDist < pyramidDist) || (playerDist == 4 * pyramidDist))
		if(playerDist < pyramidDist)
		{
			if(Vector3.Distance(player.position, transform.position) > maxDistance)
			{
				//move towards the player
				//transform.position += transform.forward * walkingSpeed * Time.deltaTime;
				GetComponent<NavMeshAgent>().destination = player.position;
			}
			
		}
		if(pyramidDist < playerDist)
		{
			if(Vector3.Distance(pyramid.position, transform.position) > maxDistance)
			{
				//move towards the player
				//transform.position += transform.forward * walkingSpeed * Time.deltaTime;
				GetComponent<NavMeshAgent>().destination = pyramid.position;
			}
		}
		*/	
	}
}
