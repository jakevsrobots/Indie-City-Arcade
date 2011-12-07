using UnityEngine;
using System.Collections;
using System.Xml;

public class LaunchableGame : MonoBehaviour {
    GameObject cube;
    
    void Awake() {
        Debug.Log("Awoke launchable game");
        cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
        ClickableCube clickableCubeComponent = cube.AddComponent<ClickableCube>();
        clickableCubeComponent.listener = gameObject;
        clickableCubeComponent.cubeName = "yoyoyo";

        cube.transform.parent = transform;

        Debug.Log(cube);
    }

    void Update() {
        
    }
}