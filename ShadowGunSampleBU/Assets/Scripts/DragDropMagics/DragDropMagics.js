#pragma strict
import System.Collections.Generic;

private var windowRect : Rect = Rect(Screen.width * 0.05, Screen.height * 0.05, Screen.width * 0.39, 290);
static var texture : Texture2D;
private var emptyTexture : Texture2D;
private var textureToAdd : Texture2D[] = new Texture2D[5];
public var slotImageToAdd : Texture2D[] = new Texture2D[5];
private var textureListSize = 5;
private var equippedMagicsList : List.<String> = new List.<String>();
private var slotCanBeTapped : String[] = new String[5];

function Awake()
{
    
    PlayerPrefs.DeleteAll();
    /*
    for(var i : int = 0; i < textureListSize; i++)
    {
        slotCanBeTapped[i] = "false";
    }
    */
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

            GUI.Label( Rect(70, 50 * x + 20, 50, 50), slotImageToAdd[x]);

            if(texture != null)
            {
                if(rect.Contains(Event.current.mousePosition) && equippedMagicsList.Contains(texture.name) == false)
                {

                    if(textureToAdd[x] == null && Input.GetMouseButtonUp(0))
                    {
                        textureToAdd[x] = texture;
                        equippedMagicsList.Add(texture.name);
                        PlayerPrefs.SetString("Magic" + x, texture.name);
                        Debug.Log(texture.name);
                        slotCanBeTapped[x] = "true";
                        Debug.Log("x that is truned to be tapped is" + x);
                        texture = null;

                        AddToInventory.toolSelected = false;

                        if(x == textureListSize - 1)
                        {
                            LoadNextLevel.activateButton = true;
                        }
                    }

                    if(Input.GetMouseButtonUp(1))
                    {

                        textureToAdd[x] = null;
                    }
                }

            }

            if(slot && slotCanBeTapped[x] == "true")
            {
                Debug.Log("After slot tapped x is" + x);
                equippedMagicsList.Remove(textureToAdd[x].name);
                textureToAdd[x] = null;
                slotCanBeTapped[x] = "false";
                // this is when each button gets pressed
            }

        //}

    }
}