using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    private readonly float speed = 7f;

    void Update()
    {
        // Get the horizontal and vertical input (WASD keys)
        float horizontal = Input.GetAxis("Horizontal"); // A and D keys
        float vertical = Input.GetAxis("Vertical"); // W and S keys

        Vector3 movement = new Vector3(horizontal, 0, vertical);
        movement = speed * Time.deltaTime * movement.normalized;

        // Check for vertical movement (Space and Left Ctrl keys)
        if (Input.GetKey(KeyCode.Space))
        {
            movement.y += speed * Time.deltaTime; // Move up
        }

        if (Input.GetKey(KeyCode.LeftControl))
        {
            movement.y -= speed * Time.deltaTime; // Move down
        }

        // Apply the movement to the camera's position
        transform.Translate(movement, Space.World);
    }
}
