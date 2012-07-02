using UnityEngine;
using System.Collections;
//Note this line, if it is left out, the script won't know that the class 'Path' exists and it will throw compiler errors
//This line should always be present at the top of scripts which use pathfinding
using Pathfinding;

public class AstarAI : MonoBehaviour {
    //The point to move to
    private GameObject player;
    private Vector3 targetPosition;
    
    private Seeker seeker;
    private CharacterController controller;
 
    //The calculated path
    public Path path;
    
    //The AI's speed per second
    public float speed = 100;
    
    //The max distance from the AI to a waypoint for it to continue to the next waypoint
    public float nextWaypointDistance = 3;
 
    //The waypoint we are currently moving towards
    private int currentWaypoint = 0;
 	
 	public float walkingSpeed = 3.0f;
	public float turningSpeed = 100.0f;
	private float maxDistance = 7;

    public void Start () {
        player = GameObject.FindWithTag("Player");
        seeker = GetComponent<Seeker>();
        //controller = GetComponent<CharacterController>();
        
        //Start a new path to the targetPosition, return the result to the MyCompleteFunction
        seeker.StartPath (transform.position,player.transform.position, MyCompleteFunction);
    }
    
    public void MyCompleteFunction (Path p) {
        Debug.Log ("Yey, we got a path back. Did it have an error? "+p.error);
        if (!p.error) {
            path = p;
            //Reset the waypoint counter
            currentWaypoint = 0;
        }
    }
 
    public void Update () {
        if (path == null) {
            //We have no path to move after yet
            return;
        }
        
        if (currentWaypoint >= path.vectorPath.Length) {
            Debug.Log ("End Of Path Reached");
            return;
        }
        
        //Direction to the next waypoint
        Vector3 dir = (path.vectorPath[currentWaypoint]-transform.position).normalized;
        dir *= speed * Time.deltaTime;
        //controller.SimpleMove (dir);
        
		if(gameObject.name != "OneXPEnemy")
		{
			maxDistance = 3;
		}

		//if(Vector3.Distance(player.transform.position, transform.position) > maxDistance)
		//{
			//move towards the player
			transform.position += dir;
		//}

        if (Vector3.Distance (transform.position,path.vectorPath[currentWaypoint]) < nextWaypointDistance) {
            currentWaypoint++;
            return;
        }
    }
} 