using UnityEngine;
using UnityEditor;
using System;

/// A small class that turns GestureSets into unity asset files.
public class GestureSetAsset
{
    [MenuItem("Assets/Create/Gesture Set")]
    public static void CreateAsset ()
    {
        CustomAssetUtility.CreateAsset<GestureSet> ();
    }
}
