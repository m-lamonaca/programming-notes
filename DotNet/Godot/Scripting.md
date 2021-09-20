# Godot Scripting

## Basics

```cs
using Godot;


public class NodeName : NodeType
{   
    [Export]  // make variable visible in inspector
    Type variable = value;



    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        GetNode("NodeName");  // fetch a child node in the scene
        GetNode("ParentNode/ChildNode");  // fetch a child node in the scene

        AddToGroup("Group");  // add a node to a group (similar to tags)

        GetTree().CallGroup("Group", "Function");  // call Function on all group members
        var groupMembers = GetTree().GetNodesInGroup("Group");
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {
        
    }

    public void _OnEmitterSignal() { }
}
```

### Overridable Functions

```cs
public override void _EnterTree()
{
    // When the node enters the Scene Tree, it becomes active and  this function is called.
    // Children nodes have not entered the active scene yet. 
    // In general, it's better to use _ready() for most cases.
    base._EnterTree();
}

public override void _Ready()
{
    // This function is called after _enter_tree, but it ensures
    // that all children nodes have also entered the Scene Tree,
    // and became active.
    base._Ready();
}

public override void _ExitTree()
{
    // When the node exits the Scene Tree, this function is called.
    // Children nodes have all exited the Scene Tree at this point and all became inactive.
    base._ExitTree();
}

public override void _Process(float delta)
{
    // This function is called every frame.
    base._Process(delta);
}

public override void _PhysicsProcess(float delta)
{
    // This is called every physics frame.
    base._PhysicsProcess(delta);
}
```

### Creating Nodes

```cs
private Sprite _sprite;

public override void _Ready()
{
    base._Ready();

    _sprite = new Sprite();  // Create a new sprite

    AddChild(_sprite);  // Add it as a child of this node
    _sprite.Free(); // Immediately removes the node from the scene and frees it.
}
```

**Note**: When a node is freed, it also frees all its child nodes.

The safest way to delete a node is by using `Node.QueueFree()`. This erases the node safely during idle.

### Instantiating Scenes

```cs
// STEP 1: load the scene
var scene = GD.Load<PackedScene>("res://scene.tscn");  // Will load when the script is instanced.

// STEP 2: instantiate the scene-node
var node = scene.Instance();
AddChild(node);
```

The advantage of this two-step process is that a packed scene may be kept loaded and ready to use so that it's possible to create as many instances as desired.  
This is especially useful to quickly instance several enemies, bullets, and other entities in the active scene.

## Signals

Signals are Godot's version of the *observer* pattern. They allow a node to send out a message that other nodes can listen for and respond to.

Signals are a way to decouple game objects, which leads to better organized and more manageable code. Instead of forcing game objects to expect other objects to always be present, they can instead emit signals that all interested objects can subscribe to and respond to.

```cs
public override _Ready()
{
    GetNode("Node").Connect("signal", targetNode, nameof(TargetFunction));  // connect node and signal
}

// Signal Handler
public void OnEmitterSignal() { }
```

### Custom Signals

```cs
public class Node : Node2D
{
    [Signal]
    public delegate void CustomSignal(Type arg, ...);

    public override void _Ready()
    {
        EmitSignal(nameof(CustomSignal), args);
    }
}
```
