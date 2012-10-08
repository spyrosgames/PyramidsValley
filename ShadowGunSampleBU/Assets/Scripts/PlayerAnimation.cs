using UnityEngine;
using System.Collections;

public class PlayerAnimation : MonoBehaviour {
	public AnimationClip runAnimation;
	public AnimationClip idleAnimation;
	public AnimationClip magicAnimation;

	public GameObject gesturesRecognizer;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		if(transform.parent.rigidbody.velocity != new Vector3(0, 0, 0) && gesturesRecognizer.GetComponent<ModifiedGestureExample>().touchStarted == false)
		{
			animation.CrossFade(runAnimation.name, 0.1f);
			animation[runAnimation.name].speed = 0.6f;
		}
		else if(transform.parent.rigidbody.velocity == new Vector3(0, 0, 0) && gesturesRecognizer.GetComponent<ModifiedGestureExample>().touchStarted == false)
		{
			animation.CrossFade(idleAnimation.name, 0.1f);
		}
		else
		{
			if(gesturesRecognizer.GetComponent<ModifiedGestureExample>().touchStarted == true)
			{
				animation.CrossFade(magicAnimation.name, 0.3f);
			}
		}
	}
}
