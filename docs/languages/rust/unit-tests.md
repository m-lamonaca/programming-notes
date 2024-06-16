# Unit Tests

## Test Functions

```rs
// module code here

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_func() {
        //ARRANGE

        // ACT

        // ASSERT
        assert!(bool, "optional custom error message");
        assert_eq!(expected, actual, "optional custom error message");
        assert_ne!(expected, actual, "optional custom error message");
    }

    #[test]
    #[should_panic("optional custom error message")]
    fn test_func() {/* ... */}

    #[test]
    #[ignore]
    fn test_func() {/* ... */}
}
```

## Controlling How Tests Are Run

```sh
cargo test -- --test-threads=<number>  # run tests in parallel (1 no parallelism)
cargo test -- --show-output  # show content printed in stdout in each test
cargo test <test_name>  # run only a specific test
cargo test <partial_test_name>  # run only specific tests
cargo test -- --ignored  # run tests annotated with #[ignore]
cargo test --test  # run all integration tests
```

## Test Organization

Unit Tests:

- Inside the same module as the tested code
- annotated with `#[cfg(test)]`
- can test private code by default
- import tested code with `super::*`
- compiled only with `cargo test`

Integration tests:

- inside top level `tests` folder
- need to import tested code by crate name
- place util functions in a `mod.rs` to avoid testing them, e.g: `tests/common/mod.rs`
- compiled only with `cargo test`
