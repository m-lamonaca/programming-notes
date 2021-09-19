# Reactive Extensions (Rx)

The **Reactive Extensions** for .NET, or **Rx**, are designed for working with asynchronous and event-based sources of information.
Rx provides services that help orchestrate and synchronize the way code reacts to data from these kinds of sources.

Rx’s fundamental abstraction, `IObservable<T>`, represents a sequence of items, and its operators are defined as extension methods for this interface.

This might sound a lot like LINQ to Objects, and there are similarities, not only does `IObservable<T>` have a lot in common with `IEnumerable<T>`, but Rx also supports almost all of the standard LINQ operators.

The difference is that in Rx, sequences are less passive. Unlike `IEnumerable<T>`, Rx sources do not wait to be asked for their items, nor can the consumer
of an Rx source demand to be given the next item. Instead, Rx uses a *push* model in which *the source notifies* its recipients when items are available.

Because Rx implements standard LINQ operators, it's possible to write queries against a live source. Rx goes beyond standard LINQ, adding its own operators that take into account the temporal nature of a live event source.

## Fundamental Interfaces

The two most important types in Rx are the `IObservable<T>` and `IObserver<T>` interfaces.  
They are important enough to be in the System namespace. The other parts of Rx are in the `System.Reactive` NuGet package.

```cs
public interface IObservable<out T>
{
    IDisposable Subscribe(IObserver<T> observer);
}

public interface IObserver<in T>
{
    void OnCompleted();
    void OnError(Exception error);
    void OnNext(T value);
}
```

The fundamental abstraction in Rx, `IObservable<T>`, is implemented by *event sources*. Instead of using the `event` keyword, it models events as a *sequence of items*.  
An `IObservable<T>` provides items to subscribers as and when it’s ready to do so.

It's possible to subscribe to a source by passing an implementation of `IObserver<T>` to the `Subscribe` method.
The source will invoke `OnNext` when it wants to report events, and it can call `OnCompleted` to indicate that there will be no further activity.
If the source wants to report an error, it can call `OnError`.
Both `OnCompleted` and `OnError` indicate the end of the stream, an observable should not call any further methods on the observer after that.
