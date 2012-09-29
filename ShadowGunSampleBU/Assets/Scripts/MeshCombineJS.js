#pragma strict
@script RequireComponent(MeshFilter)
@script RequireComponent(MeshRenderer)
function Start () {
    var meshFilters = GetComponentsInChildren.<MeshFilter>();
    var combine : CombineInstance[] = new CombineInstance[meshFilters.length];
    for (var i : int = 0; i < meshFilters.length; i++){
        combine[i].mesh = meshFilters[i].sharedMesh;
        combine[i].transform = meshFilters[i].transform.localToWorldMatrix;
        meshFilters[i].gameObject.active = false;
    }
    transform.GetComponent(MeshFilter).mesh = new Mesh();
    transform.GetComponent(MeshFilter).mesh.CombineMeshes(combine);
    transform.gameObject.active = true;
}