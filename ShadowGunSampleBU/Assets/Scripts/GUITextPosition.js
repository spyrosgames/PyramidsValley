#pragma strict
public var xOffset : float;
public var yOffset : float;

function Start () {

   guiText.pixelOffset.x = Screen.width * xOffset;
   guiText.pixelOffset.y = Screen.height * yOffset;
}