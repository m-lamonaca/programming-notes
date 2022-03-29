# [Async Programming](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/)

## Task Asynchronous Programming Model ([TAP][tap_docs])

[tap_docs]: https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/task-asynchronous-programming-model

It's possible to avoid performance bottlenecks and enhance the overall responsiveness of an application by using asynchronous programming.  
However, traditional techniques for writing asynchronous applications can be complicated, making them difficult to write, debug, and maintain.

C# 5 introduced a simplified approach, **async programming**, that leverages asynchronous support in the .NET Runtime.  
The compiler does the difficult work that the developer used to do, and the application retains a logical structure that resembles synchronous code.

In performance-sensitive code, asynchronous APIs are useful, because instead of wasting resources by forcing a thread to sit and wait for I/O to complete, a thread can kick off the work and then do something else productive in the meantime.

The `async` and `await` keywords in C# are the heart of async programming.

```cs
public async Task<TResult> MethodAsync
{
    Task<TResult> resultTask = obj.OtherMethodAsync();

    DoIndependentWork();

    TResult result = await resultTask;

    // if the is no work to be done before awaiting
    TResult result = await obj.OtherMethodAsync();

    return result;
}
```

Characteristics of Async Methods:

- The method signature includes an `async` modifier.
- The name of an async method, by convention, ends with an "Async" suffix.
- The return type is one of the following types:
  - `Task<TResult>` if the method has a return statement in which the operand has type `TResult`.
  - `Task` if the method has no return statement or has a return statement with no operand.
  - `void` if it's an async event handler.
  - Any other type that has a `GetAwaiter` method (starting with C# 7.0).
  - Starting with C# 8.0, `IAsyncEnumerable<T>`, for an async method that returns an async stream.

The method usually includes at least one `await` expression, which marks a point where the method can't continue until the awaited asynchronous operation is complete.  
In the meantime, the method is suspended, and control returns to the method's caller.

### Threads

Async methods are intended to be non-blocking operations. An `await` expression in an async method doesn't block the current thread while the awaited task is running. Instead, the expression signs up the rest of the method as a continuation and returns control to the caller of the async method.

The `async` and `await` keywords don't cause additional threads to be created. Async methods don't require multithreading because an async method doesn't run on its own thread. The method runs on the current synchronization context and uses time on the thread only when the method is active. It's possible to use `Task.Run` to move CPU-bound work to a background thread, but a background thread doesn't help with a process that's just waiting for results to become available.

The async-based approach to asynchronous programming is preferable to existing approaches in almost every case. In particular, this approach is better than the `BackgroundWorker` class for I/O-bound operations because the code is simpler and there is no need to guard against race conditions.  
In combination with the `Task.Run` method, async programming is better than `BackgroundWorker` for CPU-bound operations because async programming separates the coordination details of running the code from the work that `Task.Run` transfers to the thread pool.

### Naming Convention

By convention, methods that return commonly awaitable types (for example, `Task`, `Task<T>`, `ValueTask`, `ValueTask<T>`) should have names that end with *Async*. Methods that start an asynchronous operation but do not return an awaitable type should not have names that end with *Async*, but may start with "Begin", "Start", or some other verb to suggest this method does not return or throw the result of the operation.

## [Async Return Types](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/async-return-types)

### `Task` return type

Async methods that don't contain a return statement or that contain a return statement that doesn't return an operand usually have a return type of `Task`. Such methods return `void` if they run synchronously.  
If a `Task` return type is used for an async method, a calling method can use an `await` operator to suspend the caller's completion until the called async method has finished.

### `Task<TResult>` return type

The `Task<TResult>` return type is used for an async method that contains a return statement in which the operand is `TResult`.

The `Task<TResult>.Result` property is a **blocking property**. If it's accessed it before its task is finished, the thread that's currently active is blocked until the task completes and the value is available.  
In most cases, access the value by using `await` instead of accessing the property directly.

### `void` return type

The `void` return type is used in asynchronous event handlers, which require a `void` return type. For methods other than event handlers that don't return a value, it's best to return a `Task` instead, because an async method that returns `void` can't be awaited.  
Any caller of such a method must continue to completion without waiting for the called async method to finish. The caller must be independent of any values or exceptions that the async method generates.

The caller of a void-returning async method *can't catch exceptions thrown from the method*, and such unhandled exceptions are likely to cause the application to fail.  
If a method that returns a `Task` or `Task<TResult>` throws an exception, the exception is stored in the returned task. The exception is re-thrown when the task is awaited.  
Therefore, make sure that any async method that can produce an exception has a return type of `Task` or `Task<TResult>` and that calls to the method are awaited.

### Generalized async return types and `ValueTask<TResult>`

Starting with C# 7.0, an async method can return any type that has an accessible `GetAwaiter` method.

Because `Task` and `Task<TResult>` are **reference types**, memory allocation in performance-critical paths, particularly when allocations occur in tight loops, can adversely affect performance. Support for generalized return types means that it's possible to return a lightweight **value type** instead of a reference type to avoid additional memory allocations.

.NET provides the `System.Threading.Tasks.ValueTask<TResult>` structure as a lightweight implementation of a generalized task-returning value. To use the `System.Threading.Tasks.ValueTask<TResult>` type, add the **System.Threading.Tasks.Extensions** NuGet package to the project.

### Async Composition

```cs
public async Task DoOperationsConcurrentlyAsync()
{
  Task[] tasks = new Task[3];
  tasks[0] = DoOperation0Async();
  tasks[1] = DoOperation1Async();
  tasks[2] = DoOperation2Async();

  // At this point, all three tasks are running at the same time.

  // Now, we await them all.
  await Task.WhenAll(tasks);
}

public async Task<int> GetFirstToRespondAsync()
{
  // Call two web services; take the first response.
  Task<int>[] tasks = new[] { WebService1Async(), WebService2Async() };

  // Await for the first one to respond.
  Task<int> firstTask = await Task.WhenAny(tasks);

  // Return the result.
  return await firstTask;
}
```

### Execution & Synchronization Context

When the program’s execution reaches an `await` expression for an operation that doesn’t complete immediately, the code generated for that `await` will ensure that the
current execution context has been captured.  
When the asynchronous operation completes, the remainder of the method will be executed through the execution context.
The execution context handles certain contextual information that needs to flow when one method invokes another (even when it does so indirectly)

While all `await` expressions capture the *execution context*, the decision of whether to flow *synchronization context* as well is controlled by the type being awaited.

Sometimes, it's better to avoid getting the synchronization context involved.  
If work starting from a UI thread is performed, but there is no particular need to remain on that thread, scheduling every continuation through the synchronization context is unnecessary overhead.

If the asynchronous operation is a `Task`, `Task<T>`, `ValueTask` or `ValueTask<T>`, it's possible to discard the *synchronization context* by calling the `ConfigureAwait(false)`.  
This returns a different representation of the asynchronous operation, and if this iss awaited that instead of the original task, it will ignore the current `SynchronizationContext` if there is one.

```cs
private async Task DownloadFileAsync(string fileName)
{
  await OperationAsync(fileName).ConfigureAwait(false);  // discarding original context
}
```

When writing libraries in most cases you it'ss best to call `ConfigureAwait(false)` anywhere `await` is used.  
This is because continuing via the synchronization context can be expensive, and in some cases it can introduce the possibility of deadlock occurring.

The only exceptions are when are doing something that positively requires the synchronization context to be preserved, or it's know for certain that the library will only ever be used in
application frameworks that do not set up a synchronization context.  
(ASP.NET Core applications do not use synchronization contexts, so it generally doesn’t matter whether or not `ConfigureAwait(false)` is called in those)
