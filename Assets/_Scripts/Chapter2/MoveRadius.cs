using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveRadius : MonoBehaviour {

	public Material radiusMaterial;
	public float radius = 1;
	public Color color = Color.white;

	
	// Update is called once per frame
	void Update () {
		radiusMaterial.SetVector ("_Center", transform.position);
		radiusMaterial.SetFloat ("_Radius", radius);
		radiusMaterial.SetColor ("_RadiusColor", color);
	}
}
