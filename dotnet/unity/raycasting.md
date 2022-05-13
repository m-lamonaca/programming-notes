# Raycasting Notes

A raycast is conceptually like a laser beam that is fired from a point in space along a particular direction. Any object making contact with the beam can be detected and reported.

## 3D Raycasting

```cs
void Update()
{
    // constructor takes in a position end direction
    Ray ray = new Ray(transform,position, transform.forward);
    RaycastHit hitInfo;  // struct, stores data on ray collision

    hitInfo.distance  // distance from origin to collision point
    hitInfo.collider  // collider of the hit object
    hitInfo.transform  // transform og the hit object
    hitInfo.collider.gameObject  // reference to the object hit by the ray
    hitInfo.collider.gameObject  // reference to the object hit by the ray
    hitInfo.normal  // normal vector og the hit surface
    hitInfo.point  // actual point of collision

    // static method, object must have a collider dot the collision to happen, returns a BOOL
    Physics.Raycast(ray, out hitInfo);  // update hitInfo based on ray collisions
    Physics.Raycast(ray, out hitInfo, float maxRayDistance);  // limit the ray length
    Physics.Raycast(ray, out hitInfo, Mask mask);  // specify with which layers the ray can interact, layer must be applied to object's mask
    Physics.Raycast(ray, out hitInfo, Mask mask, QueryTriggerInteraction.Ignore);  // ignore collision if "is trigger" is enabled on other objects

    // detect a collision
    if (Physics.Raycast(ray, out hitInfo))
    {
        //collision happened

        // draw the ray in game for debugging
        Debug.DrawLine(ray.origin, hitInfo.point, Color.red);  // draw red line if collision happens
    }
    else
    {
        Debug.DrawLine(ray.origin, ray.origin + ray.direction * 100, Color.blue);  // draw blue line if collision happens, arrival point is 100 units from the origin since the ray goes to infinity
    }
}
```

### Detect mouse pointed point in-game

```cs
public Camera gameCamera;

void Update()
{
    // ray going from camera through a screen point
    Ray ray = gameCamera.ScreenPointToRay(Input.mousePosition);  // Input.mousePosition is the position of the mouse in pixels (screen points)
    RaycastHit hitInfo;  // place pointed by the mouse

    Physics.Raycast(ray, out hitInfo)  // update pointed position
}
```

## 2D Raycasting

```cs

void Start()
{
    Physics2D.queriesStartColliders = false;  // avoid collision with collider of the ray generator gameObject
}

void Update()
{
    // returns a RaycastHit2D, needs an origin and direction separately
    Raycast2D hitInfo = Physics2D.Raycast(Vector2 origin, Vector2 direction);
    Raycast2D hitInfo = Physics2D.Raycast(Vector2 origin, Vector2 direction, float maxRayDistance);
    Raycast2D hitInfo = Physics2D.Raycast(Vector2 origin, Vector2 direction, float maxRayDistance);
    Raycast2D hitInfo = Physics2D.Raycast(Vector2 origin, Vector2 direction, float minDepth, float maxDepth);  // set range of z-coord values in which detect hits (sprites depth)

    //! the ray starts from INSIDE the gameObject and can collider with it's collider

    // detect collision
    if (hitInfo.collider != null) {
        // collision happened
        Debug.DrawLine(transform.position, hitInfo.point)
    }
}
```
