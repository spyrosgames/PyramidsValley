#pragma strict
import System.Collections.Generic;

private var windowRect : Rect = Rect(Screen.width * 0.05, Screen.height * 0.05, Screen.width * 0.25, Screen.height * 0.9);
static var texture : Texture2D;
private var emptyTexture : Texture2D;
private var textureToAdd : Texture2D[] = new Texture2D[5];
private var textureListSize = 5;
private var equippedMagicsList : List.<String> = new List.<String>();

function Awake()
{
}
function Start () {

}

function Update () {

}

function OnGUI()
{
	createEmptyInventorySlots();
}

function createEmptyInventorySlots()
{
	GUI.BeginGroup(windowRect);
	windowRect = GUI.Window(0, windowRect, DragInventory, "Gestures");
	GUI.EndGroup();
}

function DragInventory(windowID : int)
{
	for(var x = 0; x < textureListSize; x++)
    {

        //for(var y = 0; y < textureListSize; y++)
        //{       

            var rect = Rect(10, 50 * x + 20, 50, 50);
            var slot = GUI.Button(rect, textureToAdd[x]);


            if(rect.Contains(Event.current.mousePosition) && equippedMagicsList.Contains(texture.name) == false)
            {

                if(textureToAdd[x] == null && Input.GetMouseButtonUp(0))
                {
                    textureToAdd[x] = texture;
                    equippedMagicsList.Add(texture.name);
                    //texture = null;

                    AddToInventory.toolSelected = false;
                }

                if(Input.GetMouseButtonUp(1))
                {

                    textureToAdd[x] = null;
                }
            }

            if(slot)
            {
                textureToAdd[x] = null;
                // this is when each button gets pressed

            }

        //}

    }
}