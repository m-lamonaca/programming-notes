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

### Reader-Writer Lock

A **reader-writer lock** understands the difference between _exclusive_ and _shared_ access, and can provide either. It has three states: unlocked, locked by a single writer (for exclusive access), and locked by any number of readers (for shared access).

The Rust standard library provides this lock through the `std::sync::RwLock<T>` type.  It has a `read()` and `write()` method for locking as either a reader or a writer and it has two guard types: `RwLockReadGuard` and `RwLockWriteGuard`.

The first only implements `Deref` to behave like a shared reference to the protected data, while the second also implements `DerefMut` to behave like an exclusive reference.

Most implementations will block new readers when there is a writer waiting, even when the lock is already read-locked. This is done to prevent _writer starvation_, a situation where many readers collectively keep the lock from ever unlocking, never allowing any writer to update the data.

## Waiting: Putting Thread to Sleep

### Thread Parking

One way to wait for a notification from another thread is called thread **parking**. A thread can _park_ itself, which puts it to sleep, stopping it from consuming any CPU cycles. Another thread can then _unpark_ the parked thread, waking it up from its sleep.

Thread parking is available through the `std::thread::park()` function. For unparking, it's possible to call the `unpark()` method on a `Thread` handle.

An important property of thread parking is that a call to `unpark()` before the thread parks itself does not get lost. The request to unpark is still recorded, and the next time the thread tries to park itself, it clears that request and directly continues without actually going to sleep.

> **Note**: calls to `unpark()` do not stack up.

### Condition Variables

**Condition variables** are a more commonly used option for waiting for something to happen to data protected by a mutex. They have two basic operations: **wait** and **notify**.

Threads can wait on a condition variable, after which they can be woken up when another thread notifies that same condition variable. Multiple threads can wait on the same condition variable, and notifications can either be sent to one waiting thread, or to all of them.

To avoid the issue of missing notifications in the brief moment between unlocking a mutex and waiting for a condition variable, condition variables provide a way to atomically unlock the mutex and start waiting. This means there is simply no possible moment for notifications to get lost.

The Rust standard library provides a condition variable as `std::sync::Condvar`. Its `wait` method takes a `MutexGuard` that proves we’ve locked the mutex. It first unlocks the mutex (allowing other threads to work on it) and goes to sleep. When woken up, it relocks the mutex and returns a new `MutexGuard` (which proves that the mutex is locked again).

It has two notify functions: `notify_one` to wake up just one waiting thread (if any), and `notify_all` to wake them all up.

## Atomics

The word atomic comes from the Greek word ἄτομος, meaning indivisible, something that cannot be cut into smaller pieces. In computer science, it is used to describe an operation that is indivisible: it is either fully completed, or it didn’t happen yet.

**Atomic operations** are the main building block for anything involving multiple threads. All the other concurrency primitives, such as mutexes and condition variables, are implemented using atomic operations.

Each of the available atomic types has the same interface with methods for _storing_ and _loading_, methods for atomic "fetch-and-modify" operations, and some more advanced "compare-and-exchange" methods.

Every atomic operation takes an argument of type `std::sync::atomic::Ordering`, which determines the guarantees about the relative ordering of operations. Based on the ordering the various threads can witness the same operations happening in different orders.

### Load & Store

The first two atomic operations are the most basic ones: **load** and **store**. Their function signatures are as follows, using AtomicI32 as an example:

```rs
impl AtomicI32 {
    pub fn load(&self, ordering: Ordering) -> i32;
    pub fn store(&self, value: i32, ordering: Ordering);
}
```

The `load` method atomically loads the value stored in the atomic variable, and the `store` method atomically stores a new value in it.

> **Note**: the store method takes a shared reference (`&T`) even though it modifies itself.

### Fetch-and-Modify Operations

The **fetch-and-modify** operations modify the atomic variable, but also load (fetch) the original value, as a single atomic operation.

```rs
impl AtomicI32 {
    pub fn fetch_add(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_sub(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_or(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_and(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_nand(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_xor(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_max(&self, v: i32, ordering: Ordering) -> i32;
    pub fn fetch_min(&self, v: i32, ordering: Ordering) -> i32;
    pub fn swap(&self, v: i32, ordering: Ordering) -> i32;  // aka fetch_store
}
```

### Compare-and-Exchange Operations

The **compare-and-exchange** operation checks if the atomic value is equal to a given value, and only if that is the case does it replace it with a new value, all atomically as a single operation. It will return the previous value and tell whether it replaced it or not.

```rs
impl AtomicI32 {
    pub fn compare_exchange(
        &self,
        expected: i32,
        new: i32,
        success_order: Ordering,
        failure_order: Ordering
    ) -> Result<i32, i32>;
}
```

## Memory Ordering

### Reordering and Optimizations

Processors and compilers perform tricks to make programs run as fast as possible. A processor might determine that two particular consecutive instructions in the program will not affect each other, and execute them out of order, if that is faster.
Similarly, a compiler might decide to reorder or rewrite parts of the program if it has reason to believe it might result in faster execution. But only if that wouldn’t change the behavior of the program.

The logic for verifying that a specific reordering or other optimization won’t affect the behavior of the program does not take other threads into account. This is why explicitly telling the compiler and processor what they can and can’t do with the atomic operations it's necessary, since their usual logic ignores interactions between threads and might allow for optimizations that do change the result of the program.

The available orderings in Rust are:

- Relaxed ordering: `Ordering::Relaxed`
- Release and acquire ordering: `Ordering::{Release, Acquire, AcqRel}`
- Sequentially consistent ordering: `Ordering::SeqCst`

### The Memory Model

The different memory ordering options have a strict formal definition to make sure their assumption are known, and compiler writers know exactly what guarantees they need to provide. To decouple this from the details of specific processor architectures, memory ordering is defined in terms of an _abstract_ memory model.

Rust’s memory model allows for concurrent atomic stores, but considers concurrent non-atomic stores to the same variable to be a data race, resulting in undefined behavior.

### Happens-Before Relationship

The memory model defines the order in which operations happen in terms of _happens-before_ relationships. This means that as an abstract model only defines situations where one thing is guaranteed to happen before another thing, and leaves the order of everything else undefined.

Between threads, however, happens-before relationships only occur in a few specific cases, such as when spawning and joining a thread, unlocking and locking a mutex, and through atomic operations that use non-relaxed memory ordering. Relaxed memory ordering is the most basic (and most performant) memory ordering that, by itself, never results in any cross-thread happens-before relationships.

_Spawning_ a thread creates a happens-before relationship between what happened before the `spawn()` call, and the new thread. Similarly, _joining_ a thread creates a happens-before relationship between the joined thread and what happens after the `join()` call.

```rs
static X: AtomicI32 = AtomicI32::new(0);

fn main() {
    X.store(1, Relaxed);

    let t = thread::spawn(f);  // happens after "store 1"
    X.store(2, Relaxed);
    t.join().unwrap();  // happens before "store 3"

    X.store(3, Relaxed);
}

fn f() {
    let x = X.load(Relaxed);  // could happen after either before or after "store 2"
    assert!(x == 1 || x == 2);
}
```

### Relaxed Ordering

While atomic operations using `Relaxed` memory ordering do not provide any happens-before relationship, they do guarantee a _total modification order_ of each individual atomic variable. This means that all modifications _of the same atomic variable_ happen in an order that is the same from the perspective of every single thread.

### Release and Acquire Ordering

`Release` and `Acquire` memory ordering are used in a pair to form a happens-before relationship between threads. `Release` memory ordering applies to _store_ operations, while `Acquire` memory ordering applies to _load_ operations.

A happens-before relationship is formed when an **acquire-load** operation observes the result of a **release-store** operation. In this case, the store and everything before it, happened before the load and everything after it.

When using `Acquire` for a **fetch-and-modify** or **compare-and-exchange** operation, it applies only to the part of the operation that _loads_ the value. Similarly, `Release` applies only to the _store_ part of an operation. `AcqRel` is used to represent the combination of `Acquire` and `Release`, which causes both the _load_ to use `Acquire` ordering, and the _store_ to use `Release` ordering.

```rs
use std::sync::atomic::Ordering::{Acquire, Release};

static DATA: AtomicU64 = AtomicU64::new(0);
static READY: AtomicBool = AtomicBool::new(false);

fn main() {
    thread::spawn(|| {
        DATA.store(123, Relaxed);
        READY.store(true, Release); // Everything from before this store ..
    });
    
    while !READY.load(Acquire) { // .. is visible after this loads `true`.
        thread::sleep(Duration::from_millis(100));
        println!("waiting...");
    }
    println!("{}", DATA.load(Relaxed));
}
```

### Consume Ordering

`Consume` ordering is a lightweight, more efficient, ​variant of `Acquire` ordering, whose synchronizing effects are limited to things that _depend on_ the loaded value.

Now there’s good news and bad news.

In all modern processor architectures, `Consume` ordering is achieved with the exact same instructions as `Relaxed` ordering. In other words, `Consume` ordering can be "free," which, at least on some platforms, is not the case for acquire ordering. Unfortunately no compiler actually implements `Consume` ordering.

The concept of a "dependent" evaluation hard to define, it’s even harder to keep such dependencies intact while transforming and optimizing a program.

Because of this, compilers upgrade `Consume` ordering to `Acquire` ordering, just to be safe. The C++20 standard even explicitly discourages the use of `Consume` ordering, noting that an implementation other than just `Acquire` ordering turned out to be infeasible.

### Sequentially Consistent Ordering

The strongest memory ordering is s**sequentially consistent** ordering (`SeqCst`). It includes all the guarantees of `Acquire` ordering (for loads) and `Release` ordering (for stores), and also guarantees a _globally consistent order_ of operations.

This means that every single operation using `SeqCst` ordering within a program is part of a single total order that all threads agree on. This total order is consistent with the total modification order of each individual variable.

Since it is strictly stronger than `Acquire` and `Release` memory ordering, a sequentially consistent load or store can take the place of an **acquire-load** or **release-store** in a _release-acquire_ pair to form a happens-before relationship. In other words, an **acquire-load** can not only form a happens-before relationship with a **release-store**, but also with a sequentially consistent store, and similarly the other way around.

Virtually all real-world uses of `SeqCst` involve a pattern of a store that must be globally visible before a subsequent load on the same thread. For these situations, a potentially more efficient alternative is to instead use `Relaxed` operations in combination with a `SeqCst` **fence**.

### Fences

The `std::sync::atomic::fence` function represents an **atomic fence** and is either a release fence (`Release`), an acquire fence (`Acquire`), or both (`AcqRel` or `SeqCst`). A `SeqCst` fence additionally also takes part in the sequentially consistent total order.

An atomic fence allows to _separate_ the memory ordering from the atomic operation. This can be useful to apply a memory ordering to _multiple_ operations, or to apply it conditionally.

In essence, a **release-store** can be split into a release fence followed by a (`Relaxed`) store, and an **acquire-load** can be split into a (`Relaxed`) load followed by an acquire fence.

```rs
// The store of a release-acquire relationship
atom.store(1, Release);

// can be substituted by a release fence followed by a relaxed store
fence(Release);
atom.store(1, Relaxed);
```

```rs

// The load of a release-acquire relationship,
atom.load(Acquire);

// can be substituted by a relaxed load followed by an acquire fence
atom.load(Relaxed);
fence(Acquire);
```

> **Note**: Using a separate fence can result in an extra processor instruction which can be slightly less efficient.
> **Note**: A fence is not tied to any single atomic variable. This means that a single fence can be used for multiple variables at once.

A release fence can take the place of a release operation in a happens-before relationship if that release fence is followed (on the same thread) by any atomic operation that stores a value observed by the acquire operation it's synchronizing with.  
Similarly, an acquire fence can take the place of any acquire operation if that acquire fence is preceded (on the same thread) by any atomic operation that loads a value stored by the release operation.

An happens-before relationship is created between a release fence and an acquire fence if _any_ store after the release fence is observed by _any_ load before the acquire fence.

A `SeqCst` fence is both a `Release` fence and an `Acquire` fence (just like `AcqRel`), but also part of the single total order of sequentially consistent operations. However, _only_ the fence is part of the total order, but not necessarily the atomic operations before or after it. This means that unlike a release or acquire operation, a sequentially consistent operation _cannot_ be split into a relaxed operation and a memory fence.
