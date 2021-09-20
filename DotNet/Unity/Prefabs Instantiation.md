# Prefabs

Prefabs are a blueprint for GameObjects and any change made to the prefab is inherited by all it's instances.

## Script Instantiation

```cs

public GameObject prefab;  // reference to the prefab

// instantiate a game GameObject from the prefab with specified position and rotation (rotation must be a quaternion)
GameObject newInstance = (GameObject) Instantiate(prefab, positionVector3, Quaternion.Euler(rotationVector3));  // instantiate prefab and get reference to instance
// Instance returns a object and since a GameObject was passed to Instantiate() the returned object can be casted to a GameObject
```
