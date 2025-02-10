using UnityEngine;

public class MyRotate : MonoBehaviour
{
    void Start()
    {
        Application.targetFrameRate = 30;
    }

    void Update()
    {
        this.transform.Rotate(0, 1, 0);
    }
}
