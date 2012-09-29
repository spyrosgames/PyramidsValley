#pragma strict

var textureToAdd : Texture2D;

static var toolSelected : boolean = false;

private var mouseDown : boolean = false;

function OnMouseDown() 

{

    DragDropMagics.texture = this.textureToAdd;

    toolSelected = true;

}

 

function Update()

{

    if(Input.GetMouseButtonDown(0))

        mouseDown = true;

    

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