using UnityEngine;
using System.Collections;

public class RocksMeshCombine : MonoBehaviour {
	public GameObject rocksParent;
	private MeshCombine meshCombine;

	void Awake()
	{
		meshCombine = new MeshCombine();
		meshCombine.combineMeshes(rocksParent);
	}
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
