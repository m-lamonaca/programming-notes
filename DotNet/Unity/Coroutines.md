# Coroutines

[Coroutines - Unity manual](https://docs.unity3d.com/Manual/Coroutines.html)

When you call a function, it runs to completion before returning. This effectively means that any action taking place in a function must happen *within a single frame update*; a function call can't be used to contain a procedural animation or a sequence of events over time.

A coroutine is like a function that has the ability to pause execution and return control to Unity but then to continue where it left off on the following frame.

It is essentially a function declared with a return type of IEnumerator and with the yield return statement included somewhere in the body. The `yield return null` line is the point at which execution will pause and be resumed the following frame.

```cs
//coroutine
IEnumerator coroutine()
{
    // action performed
    yield return null;  // pause until next iteration

    // or

    // By default, a coroutine is resumed on the frame after it yields but it is also possible to introduce a time delay
    yield return new WaitForSeconds(seconds);  // wait seconds before resuming

    // or

    yeld return StartCoroutine(coroutine());  // wait for another coroutine to finish before starting
}

StartCoroutine(coroutine());  // start the coroutine
StopCoroutine(coroutine());  // stop the coroutine
```
