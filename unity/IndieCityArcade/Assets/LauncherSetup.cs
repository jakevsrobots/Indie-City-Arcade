using UnityEngine;
using System.Collections;
using System.Xml;

public class LauncherSetup : MonoBehaviour {

	// Use this for initialization
	void Start () {
        XmlDocument settingsXmlDoc = new XmlDocument();
        TextAsset xmlFile = (TextAsset)Resources.Load("DefaultLauncherSceneSettings");
        settingsXmlDoc.LoadXml(xmlFile.text);
        
        foreach(XmlNode gameObjectNode in settingsXmlDoc.DocumentElement.SelectNodes("gameObject")) {
            GameObject gameObject = new GameObject(gameObjectNode.Attributes["name"].Value);

            foreach(XmlNode componentNode in gameObjectNode.SelectNodes("component")) {
                gameObject.AddComponent(componentNode.Attributes["name"].Value);
            }

            gameObject.transform.position = new Vector3(float.Parse(gameObjectNode.Attributes["x"].Value),
                                                        float.Parse(gameObjectNode.Attributes["y"].Value),
                                                        float.Parse(gameObjectNode.Attributes["z"].Value));
        }
	}

	// Update is called once per frame
	void Update () {
        
	}
}
