using UnityEngine;
using System.Collections;
using System.Xml;

public class ClickableCube : MonoBehaviour {
    public GameObject listener;
    public string cubeName;
    
    void Awake() {
        
    }

    void Update() {
        
    }

    void OnMouseDown() {
        Debug.Log("clicked " + name);
    }
}