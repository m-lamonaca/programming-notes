# [Async Programming](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/)

## Task Asynchronous Programming Model ([TAP][tap_docs])

[tap_docs]: https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/task-asynchronous-programming-model

It's possible to avoid performance bottlenecks and enhance the overall responsiveness of an application by using asynchronous programming. However, traditional techniques for writing asynchronous applications can be complicated, making them difficult to write, debug, and maintain.

C# 5 introduced a simplified approach, **async programming**, that leverages asynchronous support in the .NET Framework 4.5 and higher, .NET Core, and the Windows Runtime. The compiler does the difficult work that the developer used to do, and the application retains a logical structure that resembles synchronous code.

Asynchrony is essential for activities that are *potentially blocking*, such as web access. Access to a web resource sometimes is slow or delayed. If such an activity is blocked in a synchronous process, the entire application must wait. In an asynchronous process, the application can continue with other work that doesn't depend on the web resource until the potentially blocking task finishes.

The `async` and `await` keywords in C# are the heart of async programming.

By using those two keywords, it's possible to use resources in .NET Framework, .NET Core, or the Windows Runtime to create an asynchronous method almost as easily as a synchronous method. Asynchronous methods defined by using the `async` keyword are referred to as **async methods**.

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

The method usually includes at least one `await` expression, which marks a point where the method can't continue until the awaited asynchronous operation is complete. In the meantime, the method is suspended, and control returns to the method's caller.

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

The `Task<TResult>.Result` property is a **blocking property**. If it's accessed it before its task is finished, the thread that's currently active is blocked until the task completes and the value is available. In most cases, access the value by using `await` instead of accessing the property directly.

### `void` return type

The `void` return type is used in asynchronous event handlers, which require a `void` return type. For methods other than event handlers that don't return a value, it's best to return a `Task` instead, because an async method that returns `void` can't be awaited. Any caller of such a method must continue to completion without waiting for the called async method to finish. The caller must be independent of any values or exceptions that the async method generates.

The caller of a void-returning async method *can't catch exceptions thrown from the method*, and such unhandled exceptions are likely to cause the application to fail. If a method that returns a `Task` or `Task<TResult>` throws an exception, the exception is stored in the returned task. The exception is re-thrown when the task is awaited. Therefore, make sure that any async method that can produce an exception has a return type of `Task` or `Task<TResult>` and that calls to the method are awaited.

### Generalized async return types and `ValueTask<TResult>`

Starting with C# 7.0, an async method can return any type that has an accessible `GetAwaiter` method.

Because `Task` and `Task<TResult>` are **reference types**, memory allocation in performance-critical paths, particularly when allocations occur in tight loops, can adversely affect performance. Support for generalized return types means that it's possible to return a lightweight **value type** instead of a reference type to avoid additional memory allocations.

.NET provides the `System.Threading.Tasks.ValueTask<TResult>` structure as a lightweight implementation of a generalized task-returning value. To use the `System.Threading.Tasks.ValueTask<TResult>` type, add the **System.Threading.Tasks.Extensions** NuGet package to the project.

### Async streams with `IAsyncEnumerable<T>`

Starting with C# 8.0, an async method may return an async stream, represented by `IAsyncEnumerable<T>`. An async stream provides a way to enumerate items read from a stream when elements are generated in chunks with repeated asynchronous calls.

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

### Context & Avoiding Context

What exactly is the "context"?

- on a UI thread it's a UI context.
- when responding to an ASP.NET request, then it's an ASP.NET request context.
- Otherwise, it's usually a thread pool context.

```cs
private async Task DownloadFileAsync(string fileName)
{
  // Use HttpClient or whatever to download the file contents.
  var fileContents = await DownloadFileContentsAsync(fileName).ConfigureAwait(false);

  // Note that because of the ConfigureAwait(false), we are not on the original context here.
  // Instead, we're running on the thread pool.

  // Write the file contents out to a disk file.
  await WriteToDiskAsync(fileName, fileContents).ConfigureAwait(false);

  // The second call to ConfigureAwait(false) is not *required*, but it is Good Practice.
}

// UI Example
private async void DownloadFileButton_Click(object sender, EventArgs e)
{
  // Since we asynchronously wait, the UI thread is not blocked by the file download.
  await DownloadFileAsync(fileNameTextBox.Text);

  // Since we resume on the UI context, we can directly access UI elements.
  resultTextBox.Text = "File downloaded!";
}

// ASP.NET example
protected async void MyButton_Click(object sender, EventArgs e)
{
  // Since we asynchronously wait, the ASP.NET thread is not blocked by the file download.
  // This allows the thread to handle other requests while we're waiting.
  await DownloadFileAsync(...);

  // Since we resume on the ASP.NET context, we can access the current request.
  // We may actually be on another *thread*, but we have the same ASP.NET request context.
  Response.Write("File downloaded!");
}
```
