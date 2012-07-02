using UnityEngine;
using System.Collections;

public class NewAIFollow : MonoBehaviour {
	private Transform target;
	private Transform player;
	private Transform pyramid;
	private Vector3 playerDirection;
	private Vector3 pyramidDirection;
	// Use this for initialization
	void Awake()
	{
		player = GameObject.FindWithTag("Player").transform;
		pyramid = GameObject.FindWithTag("Pyramid").transform;
	}

	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
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

		if(playerDist < pyramidDist)
		{
			GetComponent<NavMeshAgent>().destination = player.position;
		}
		else if(pyramidDist < playerDist)
		{
			GetComponent<NavMeshAgent>().destination = pyramid.position;	
		}
	}
}
