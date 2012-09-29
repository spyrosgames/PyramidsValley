#pragma strict
public var width : float;
public var height : float;

function Start () {

   guiTexture.pixelInset = Rect(Screen.width * 0.8, Screen.height * 0.93, width, height);
}

function Update () {

}