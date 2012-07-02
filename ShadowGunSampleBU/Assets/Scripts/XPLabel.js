#pragma strict
function Start () {
	//iTween.MoveTo(gameObject, Vector3(0, gameObject.transform.position.y + 1, 0), 20.0);
	iTween.MoveTo(gameObject, {"position":Vector3(gameObject.transform.position.x + 0.1, gameObject.transform.position.y + 1, 0), "time":20.0});
	//iTween.MoveTo(gameObject, {"position":Vector3(screenPosition.x - 35, screenPosition.x - 40, 0), "time":20.0});
	iTween.FadeTo(gameObject,{"alpha":0, "time":.3, "delay":1.2, "onComplete":"destroy"});
	//iTween.FadeTo(gameObject,{"alpha":0, "time":.3, "delay":1, "onComplete":"destroy"});
}
function destroy()
{
	Destroy(gameObject);
}