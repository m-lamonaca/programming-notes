# Collisions (Physics)

## Rigidbody Component

Enables physics on the game objects.

Rigidbodies collide with other objects instead of going through them.

Avoid object rotation on collisions:

1. Assign `Rigidbody` component to object
2. Enable Freeze Rotation in Rigidbody > Constraints

```cs
using UnityEngine;
using System.Collections;

public class GameObject : MonoBehaviour {

    Rigidbody = rigidbody;  // game object rigidbody reference container

    void Start()
    {
        rigidbody = GetComponent<Rigidbody>();  // get rigidbody reference
    }

    void Update()
    {
    }

    // FixedUpdate is calls every x seconds (not influenced by FPS instability)
    // used for physics calculations which should be FPS independent
    void FixedUpdate()
    {
        Time.fixedDeltaTime;  // fixed amount of time
        Time.timeDelta;  // if called inside FIxedUpdate() behaves like fixedDeltaTime
    }

}
```

## Box Collider Component

Enable `Is Trigger` to register the collision but avoid blocking the movement of the objects.
The trigger can generate a event to signal the contact with the object.

One of the colliding GameObjects *must have* the `Rigidbody` component and the other `Is Trigger` enabled.
To detect the collision but avoid computing the physics `Is Kinematic` must be enabled in the `Rigidbody` component.

```cs
using UnityEngine;
using System.Collections;

public class GameObject : MonoBehaviour {

    Rigidbody = rigidbody;  // game object rigidbody reference container

    void Start()
    {
        rigidbody = GetComponent<Rigidbody>();  // get rigidbody reference
    }

    // FixedUpdate is calls every x seconds (not influenced by FPS instability)
    // used for physics calculations which should be FPS independent
    void FixedUpdate()
    {
        Time.fixedDeltaTime;  // fixed amount of time
        Time.timeDelta;  // if called inside FixedUpdate() behaves like fixedDeltaTime
    }

    // called on box collision.
    void OnTriggerEnter(Collider triggerCollider) {

        // detect a collision with a particular GameObject(must have a TAG)
        if (triggerCollider.tag = "tag") {
            Destroy(triggerCollider.gameObject);  // destroy tagged item on collision
            //or
            Destroy(gameObject);  // destroy itself
        }
    }
```
