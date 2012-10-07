#pragma strict

var textureToAdd : Texture2D;

static var toolSelected : boolean = false;

private var mouseDown : boolean = false;

/*
function OnMouseDown() 
{

    DragDropMagics.texture = this.textureToAdd;

    toolSelected = true;

}
*/

 function CheckForTouch()
 {
 	if(Input.touchCount > 0)
 	{
 		var touch : Touch = Input.GetTouch(0);

 		if(guiTexture.HitTest(touch.position))
 		{
 			DragDropMagics.texture = this.textureToAdd;

    		toolSelected = true;
 		}
 	}
 }

function Update()

{
	CheckForTouch();

    if(Input.GetMouseButtonDown(0))
    {
        mouseDown = true;
    }
    

    if(Input.GetMouseButtonUp(0) && mouseDown)
    {
        mouseDown = false;
    }

}

function OnGUI()

{
    if(toolSelected && mouseDown)

    {

        var mousePos : Vector3 = Input.mousePosition;

        var pos : Rect = Rect(mousePos.x,Screen.height - mousePos.y, DragDropMagics.texture.width, DragDropMagics.texture.height);

        GUI.Label(pos,DragDropMagics.texture);
    }

}