# Concurrency

[Rust Book - Concurrency](https://doc.rust-lang.org/book/ch16-00-concurrency.html "Rust Book - Fearless Concurrency")  
[Rust Atomics and Locks - Mara Bos](https://marabos.nl/atomics/ "Rust Atomics and Locks - Low-Level Concurrency in Practice")

Operating systems isolate processes from each other as much as possible, allowing a program to do its thing while completely unaware of what any other processes are doing. For example, a process cannot normally access the memory of another process, or communicate with it in any way, without asking the operating system’s kernel first.

However, a program can spawn extra threads of execution, as part of the same process. Threads within the same process are not isolated from each other. Threads share memory and can interact with each other through that memory.

## Threads

Every program starts with exactly _one_ thread: the **main** thread. This thread will execute the `main` function and can be used to spawn more threads if necessary.

New threads are spawned using the `std::thread::spawn` function from the standard library. It takes a single argument: the function the new thread will execute. The thread stops once this function returns.

Returning from `main` will exit the entire program, even if other threads are still running. To make sure the spawned threads have finished their work it's possible to wait by _joining_ them.

```rs
// spawn a new thread
let handle = std::thread::spawn(move || {

    // read the current thread ID
    let thread_id = std::thread::current().id();
});

// wait for the thread to finish by joining it
handle.join();
```

Since a thread might run until the very end of the program’s execution, the spawn function has a `'static` lifetime bound on its argument type. In other words, it only accepts functions that may be kept around forever. A closure capturing a local variable by reference may not be kept around forever, since that reference would become invalid the moment the local variable ceases to exist.

Getting a value back out of the thread is done by returning it from the closure. This return value can be obtained from the `Result` returned by the `join` method.

> **Note**: if a thread panics the handle will return the panic message so that it can be handled.

```rs
let numbers = Vec::from_iter(0..=1000);

// `move` ensures the tread takes ownership by move the data
let handle = thread::spawn(move || {
    let len = numbers.len();
    let sum = numbers.iter().sum::<usize>();
    sum / len
});


let average = handle.join().unwrap();
```

### Scoped Threads

**Scoped threads** ensure that all thread spawned within a _scope_ do not outlive said scope. This makes possible to borrow data that outlives the scope. This is possible since the scope `spawn` function does not have a `'static` bound.

**Note**: it's not possible to spawn multiple threads sharing the same data is one of the is mutating it.

```rs
let numbers = Vec::from_iter(0..=10);

std::thread::scope(|scope| {
    // data is borrowed since the `move` keyword is missing
    scope.spawn(|| { 
        let len = numbers.len(); 
        // ...
    });

    scope.spawn(|| { /* ... */ });
});
```

### Shared Ownership

When sharing data between two threads where neither thread is guaranteed to outlive the other, neither of them can be the owner of that data. Any data shared between them will need to live as long as the longest living thread.

There are several ways to create data that is not owned by any single thread:

- **Statics**: A `static` item has a constant initializer, is never dropped, and already exists before the main function of the program even starts. Every thread can borrow it, since it’s guaranteed to always exist.

- **Leaking**: Using `Box::leak`, one can _release_ ownership of a `Box`, promising to never drop it. From that point on, the `Box` will live forever, without an owner, allowing it to be borrowed by any thread for as long as the program runs.

- **Reference Counting**: To make sure that shared data gets dropped and deallocated data ownership it's never gave up completely, is instead _shared_. By keeping track of the number of owners, it's possible to make sure the value is dropped only when there are no owners left. The standard library offers such functionality with the `Rc<T>` & `Arc<T>` types.

### Thread Safety: Send and Sync

The `Send` marker trait indicates that ownership of values of the type implementing `Send` can be transferred between threads. Any type composed entirely of `Send` types is automatically marked as `Send`.  Almost all primitive types are `Send`, aside from raw pointers.

The `Sync` marker trait indicates that it is safe for the type implementing `Sync` to be referenced from multiple threads. In other words, any type `T` is `Sync` if `&T` (an immutable reference to `T`) is `Send`, meaning the reference can be sent safely to another thread. Similar to `Send`, primitive types are `Sync`, and types composed entirely of types that are `Sync`are also `Sync`.

> **Note**: All primitive types such as `i32`, `bool`, and `str` are both `Send` and `Sync`.

## Locking: Protecting Shared Data

### Mutex

The most commonly used tool for sharing (mutable) data between threads is a **mutex**, which is short for "mutual exclusion." The job of a mutex is to ensure threads have _exclusive access_ to some data by temporarily blocking other threads that try to access it at the same time.

A mutex has only two _states_: **locked** and **unlocked**.

When a thread locks an unlocked mutex, the mutex is marked as locked and the thread can immediately continue. When a thread then attempts to lock an already locked mutex, that operation will block. The thread is put to sleep while it waits for the mutex to be unlocked. Unlocking is only possible on a locked mutex, and should be done by the same thread that locked it. If other threads are waiting to lock the mutex, unlocking will cause one of those threads to be woken up, so it can try to lock the mutex again and continue its course.

Protecting data with a mutex is simply the agreement between all threads that they will only access the data when they have the mutex locked. That way, no two threads can ever access that data concurrently and cause a **data race**.

The Rust standard library provides this functionality through `std::sync::Mutex<T>`. Since the mutex wraps and owns the `T` it protects, the data can only be accessed through the mutex, allowing for a safe interface that can guarantee only one thread at a time can access the wrapped `T`.

To ensure a locked mutex can only be unlocked by the thread that locked it, it does not have an `unlock()` method. Instead, its `lock()` method returns a  a `MutexGuard` to represent the lock. The `MutexGuard` allows exclusive access to the data the mutex protects. Unlocking the mutex is done by dropping the guard.

```rs
let mutex = std::sync::Mutex::new(0);

std::thread::scope(|scope| {
    scope.spawn(|| {
        let guard = mutex.lock().unwrap();  // obtain access
        *guard += 1;  // mutate protected value
    })
});
```

### Lock Poisoning

The `lock()` method returns a `Result` since the mutex can become **poisoned**. A mutex get marked as poisoned when a thread panics while holding the lock. Calling `lock()` on a poisoned mutex will return an `Err`. This poisoning mechanism protects against accessing data that may be in an inconsistent state.  

> **Note**: The lock is still acquired and the `Err` variant contains the guard, allowing to correct the data inconsistency.
