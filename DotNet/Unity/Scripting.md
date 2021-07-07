# Unity C# Scripting

## Logging

```c#
Debug.Log(string);    //output message to console (more powerful and flexible than print())
Print(string);    //output message to console
```

## Scripts

```c#
public class ClassName : MonoBehaviour {

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        Time.deltaTime;  // time since last frame
    }

    // FixedUpdate is calles every x seconds (not influenced by FPS instability)
    // used for physics calculations which sould be FPS independant
    void FixedUpdate()
    {
        Time.fixedDeltaTime;  // fixed amount of time
        Time.timeDelta;  // if called inside FIxedUpadate() behaves like fixedDeltaTime
    }
}
```

### Script comunication

Referencing data in a sctipt from another.

```cs
//example of a script to be referenced in another
Using System;

public class Player : MonoBheaviour {

    public float health = 10;
    public event Action OnPlayerDeath;  //event of type Action, needs using System

    void Start() {

    }

    void Update() {

        if (health <= 0) {
            if (OnPlayerDeath != null) {
                OnPleyerDeath();  // invoke Action (if no subscribers event will be NULL, can cause errors)
            }

            Destroy(GameObject);  // needs to be notified
        }
    }
}
```

```cs
// example of script needing a reference to another
public class GameUI : MonoBehaviour {

    Player player;  //instance of referenced GameObject to be founf by its type

    void Start(){
        GameObject playerObj = GameObject.Find("Player");  //reference to game object
        GameObject playerObj = GameObject.FindGameObjectWithTag("Tag");  //reference to game object
        player = playerObj.GetComponent<Player>();  // get script attached to the GameObject

        player = FindObjectOfType<Player>();  // get reference to an object

        // on event invocation all subscribet methods will be called
        player.OnPlayerDeath += GameOver;  // subscribe method to event
    }

    void Update() {
        DrawHealthBar(plyer.health);  // call method passing data of player GameObject
    }

    void DrawHealthbar(float playerHealth) {
        // implementation
    }

    public void GameOver() {
        //game over screen
    }
}
```

## Screen

### 2D Screen Measures

Aspect Ratio = `(screen_width [px]) / (screen_height [px])`
Orhograpic Size `[world units]` = `(screen_height [world units] / 2)`
Aspect Ratio * Orhograpic Size = `(screen_width [world units] / 2)`
Screen Width `[world units]` = `(AspectRatio * OrhograpicSize * 2)`

```cs
screenWidth = Camera.main.aspect * Camera.main.orthographicSize * 2;
```

## Scriptable Objects

Class to store data in stand alone assets, used to keep data out of scripts.  
Can be used as a template.

```c#
[CreateAssetMenu(menuName = "ScriptableObjectName")]    //enable creation of scriptable object
public class ScriptableObjectName : ScriptableObject {
    //data structure here
}
```

### Game Object Serialization

```c#
[SeralizeField] type variable;    //access game object from code
```

### Game Object Data Access

```c#
public type GetVariable(){
    return variable;
}
```
