# Input Manager

The Input Manager uses the following types of controls:

- **Key** refers to any key on a physical keyboard, such as `W`, `Shift`, or the `space bar`.
- **Button** refers to any button on a physical controller (for example, gamepads), such as the `X` button on an Xbox One controller.
- A **virtual axis** (plural: axes) is mapped to a **control**, such as a button or a key. When the user activates the control, the axis receives a value in the range of `[-1..1]`.

## Virtual axes

### Axis Properties

**Name**: Axis name. You can use this to access the axis from scripts.
**Negative Button**, **Positive Button**: The controls to push the axis in the negative and positive direction respectively. These can be keys on a keyboard, or buttons on a joystick or mouse.
**Alt Negative Button**, **Alt Positive Button**: Alternative controls to push the axis in the negative and positive direction respectively.
**Gravity**: Speed in units per second that the axis falls toward neutral when no input is present.
**Dead**: How far the user needs to move an analog stick before your application registers the movement. At runtime, input from all analog devices that falls within this range will be considered null.
**Sensitivity**: Speed in units per second that the axis will move toward the target value. This is for digital devices only.
**Snap**: If enabled, the axis value will reset to zero when pressing a button that corresponds to the opposite direction.
**Type**: The type of input that controls the axis. Select from these values:

- Key or Mouse button
- Mouse Movement
- Joystick Axis

**Axis**: The axis of a connected device that controls this axis.
**JoyNum**: The connected Joystick that controls this axis. You can select a specific joystick, or query input from all joysticks.

### Axis Values

Axis values can be:

- Between `-1` and `1` for joystick and keyboard input. The neutral position for these axes is `0`. Some types of controls, such as buttons on a keyboard, aren't sensitive to input intensity, so they can't produce values other than `-1`, `0`, or `1`.
- Mouse delta (how much the mouse has moved during the last frame) for mouse input. The values for mouse input axes can be larger than `1` or smaller than `-1` when the user moves the mouse quickly.

```cs
//Define the speed at which the object moves.
float moveSpeed = 10;

//Get the value of the Horizontal input axis.
float horizontalInput = Input.GetAxis("Horizontal");

//Get the value of the Vertical input axis.
float verticalInput = Input.GetAxis("Vertical");

Vector3 direction = new Vector3(horizontalInput, 0, verticalInput).normalized;
Vector3 velocity = direction * moveSpeed;

//Move the object to XYZ coordinates defined as horizontalInput, 0, and verticalInput respectively.
transform.Translate(velocity * Time.deltaTime);
```

[Time.deltaTime][dt] represents the time that passed since the last frame. Multiplying the moveSpeed variable by Time.deltaTime ensures that the GameObject moves at a constant speed every frame.

[dt]: https://docs.unity3d.com/ScriptReference/Time-deltaTime.html

`GetAxis`: returns the value of the virtual axis identified.
`GetAxisRaw`: returns the value of the virtual axis identified with no smoothing filtering applied.

## Keys

**Letter keys**: `a`, `b`, `c`, ...
**Number keys**: `1`, `2`, `3`, ...
**Arrow keys**: `up`, `down`, `left`, `right`
**Numpad keys**: `[1]`, `[2]`, `[3]`, `[+]`, `[equals]`, ...
**Modifier keys**: `right shift`, `left shift`, `right ctrl`, `left ctrl`, `right alt`, `left alt`, `right cmd`, `left cmd`
**Special keys**: `backspace`, `tab`, `return`, `escape`, `space`, `delete`, `enter`, `insert`, `home`, `end`, `page up`, `page down`
**Function keys**: `f1`, `f2`, `f3`, ...

**Mouse buttons**: `mouse 0`, `mouse 1`, `mouse 2`, ...

**Specific button on *any* joystick**: `joystick button 0`, `joystick button 1`, `joystick button 2`, ...
**specific button on a *specific* joystick**: `joystick 1 button 0`, `joystick 1 button 1`, `joystick 2 button 0`, ...

```cs
Input.GetKey("a");
Input.GetKey(KeyCode.A);
```

[Input.GetKey](https://docs.unity3d.com/ScriptReference/Input.GetKey.html)
[KeyCode](https://docs.unity3d.com/ScriptReference/KeyCode.html)
