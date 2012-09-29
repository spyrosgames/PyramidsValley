#pragma strict
public var firstHeart : GUITexture;
public var secondHeart : GUITexture;
public var thirdHeart : GUITexture;

public var width : float;
public var height : float;

function Start () {

   firstHeart.pixelInset = Rect(Screen.width * 0.03, Screen.height * 0.93, width, height);
   secondHeart.pixelInset = Rect(Screen.width * 0.08, Screen.height * 0.93, width, height);
   thirdHeart.pixelInset = Rect(Screen.width * 0.13, Screen.height * 0.93, width, height);

}

function Update () {

}