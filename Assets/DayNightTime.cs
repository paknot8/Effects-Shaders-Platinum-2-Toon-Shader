using UnityEngine;

public class DayNightTime : MonoBehaviour
{
    private readonly float rotationSpeed = 30f; // Speed of rotation
    private bool rotatingForward = true; // Direction of rotation

    // Update is called once per frame
    void Update()
    {
        float rotationAmount = rotationSpeed * Time.deltaTime;
        float currentXRotation = transform.localEulerAngles.x;

        // Adjust the current rotation angle to be between -180 and 180 degrees
        if (currentXRotation > 180f)
        {
            currentXRotation -= 360f;
        }

        // Check if the rotation has reached the limits and reverse direction
        if (currentXRotation >= 100f)
        {
            rotatingForward = false; // Reverse direction to backward
        }
        else if (currentXRotation <= -100f)
        {
            rotatingForward = true; // Reverse direction to forward
        }

        // Apply the rotation based on the current direction
        if (rotatingForward)
        {
            transform.Rotate(Vector3.right * rotationAmount);
        }
        else
        {
            transform.Rotate(Vector3.left * rotationAmount);
        }
    }
}
