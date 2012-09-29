using UnityEngine;
using UnityEditor;
using System.IO;

/**
A utility class that helps turn ScriptableObjects into custom assets.
To use this class to make custom assets from your own ScriptableObjects,\n
Make a new C# script named NameOfYourClassAssest.cs where NameOfYouClass \n
is the name of you class that inherits from ScriptableObject. Then inside \n
that new script use the follow code as reference:
\code
using UnityEngine;
using UnityEditor;
using System;

public class NameOfYourClassAssest{
    [MenuItem("Assets/Create/NameOf Your Class")]
    public static void CreateAsset (){
        CustomAssetUtility.CreateAsset<NameOfYourClass> ();
    }
}
\endcode
*/

public static class CustomAssetUtility
{
    public static void CreateAsset<T> () where T : ScriptableObject
    {
        T asset = ScriptableObject.CreateInstance<T> ();

        string path = AssetDatabase.GetAssetPath (Selection.activeObject);
        if (path == "")
        {
            path = "Assets";
        }
        else if (Path.GetExtension (path) != "")
        {
            path = path.Replace (Path.GetFileName (AssetDatabase.GetAssetPath (Selection.activeObject)), "");
        }
        string assetPathAndName = AssetDatabase.GenerateUniqueAssetPath(Path.Combine(path, "New "+typeof(T).ToString()+".asset"));

        AssetDatabase.CreateAsset (asset, assetPathAndName);

        AssetDatabase.SaveAssets ();
        EditorUtility.FocusProjectWindow ();
        Selection.activeObject = asset;
    }
}
