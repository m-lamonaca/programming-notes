# Vector, Transform, Space

## Vector2, Vector3, Vector4

[Vector3 Docs](https://docs.unity3d.com/ScriptReference/Vector3.html)

Used to store positions, velocities and directions.

Magnitude = `sqrt(Math.pow(x, 2) + Math.pow(y, 2))`
Direction = `(x / Magnitude, y / Magnitude)`

The direction is calculated by normalizing the vector to make it become a unit vector (*versor*).

```cs
Vector3.x  // x coord of vector
Vector3.y  // x coord of vector
Vector3.z  // x coord of vector

Vector3.magnitude
Vector3.normalized

Vector3.up // Vector3(0, 1, 0)
Vector3.down // Vector3(0, -1, 0)
Vector3.left // Vector3(-1, 0, 0)
Vector3.right // Vector3(1, 0, 0)
Vector3.forward // Vector3(0, 0, 1)
Vector3.back // Vector3(0, 0, -1)
Vector3.one // Vector3(1, 1, 1)
Vector3.zero // Vector3(0, 0, 0)
Vector3.one // Vector3(1, 1, 1)
```

### Operations

```cs
Vector3(x, y, z) * n = Vector3(xn, yn, yz);
Vector3(x, y, z) / n = Vector3(x / n, y / n, y / z);

Vector3(x1, y1, z1) + Vector3(x2, y2, z2) = Vector3(x1 + x2, y1 + y2, z1 + z2);
Vector3(x1, y1, z1) - Vector3(x2, y2, z2) = Vector3(x1 - x2, y1 - y2, z1 - z2);

Quaternion.Euler(Vector3)  // convert a Vector3 to a Quaternion
```

### Movement

Speed = value m/s
Velocity = Direction * Speed

MovementInFrame = Speed * timeSinceLastFrame

## Transform

[Transform Docs](https://docs.unity3d.com/ScriptReference/Transform.html)

```cs
// properties
transform.position // Vector3 - global position
transform.localPosition // Vector3 - local position
transform.rotation  // Quaternion - global rotation
transform.parent  // Transform - parent of the object

transform.localScale = Vector3;  // set object dimensions

// methods
transform.Rotate(Vector3 * Time.deltaTime * speed, Space);  // set rotation using vectors in selected space (Space.Self or Space.World)
transform.Translate(Vector3 * Time.deltaTime * speed, Space);  // set movement in selected space
```

### Local, GLobal & Object Space

**Local Space**: Applies transformation relative to the *local* coordinate system (`Space.Self`).
**Global Space**: Applies transformation relative to the *world* coordinate system (`Space.World`)

### Parenting

Changing the parent will make position, scale and rotation of the child object relative to the parent but keep the world space's position, rotation and scale the same.

Setting the parentele by script:

```cs
public class ParentScript : MonoBehaviour {
    public Transform childTransform;  // reference to the child object transform

    childTransform.parent = transform;  // when evaluated at runtime sets current object as parent of another
}
```
