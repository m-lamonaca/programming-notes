# Unittest Module

Permette di testare il propio codice e controllare se l'output corrisponde a quello desiderato.

```py
import unittest
import modulo_da_testare

class Test(unittest.TestCase):  # eredita da unittest.TestCase

    # testa se l'output è corretto con un asserzione
    def test_1(self):
        # code here
        self.assert*(output, expected_output)

if __name__ == '__main__':
    unittest.main()
```

## TestCase Class

Instances of the `TestCase` class represent the logical test units in the unittest universe. This class is intended to be used as a base class, with specific tests being implemented by concrete subclasses. This class implements the interface needed by the test runner to allow it to drive the tests, and methods that the test code can use to check for and report various kinds of failure.

### Assert Methods

| Method                      | Checks that            |
|-----------------------------|------------------------|
| `assertEqual(a, b)`         | `a == b`               |
| `assertNotEqual(a, b)`      | `a != b`               |
| `assertTrue(x)`             | `bool(x) is True`      |
| `assertFalse(x)`            | `bool(x) is False`     |
| `assertIs(a, b)`            | `a is b`               |
| `assertIsNot(a, b)`         | `a is not b`           |
| `assertIsNone(x)`           | `x is None`            |
| `assertIsNotNone(x)`        | `x is not None`        |
| `assertIn(a, b)`            | `a in b`               |
| `assertNotIn(a, b)`         | `a not in b`           |
| `assertIsInstance(a, b)`    | `isinstance(a, b)`     |
| `assertNotIsInstance(a, b)` | `not isinstance(a, b)` |

| Method                                          | Checks that                                                         |
|-------------------------------------------------|---------------------------------------------------------------------|
| `assertRaises(exc, fun, *args, **kwds)`         | `fun(*args, **kwds)` raises *exc*                                   |
| `assertRaisesRegex(exc, r, fun, *args, **kwds)` | `fun(*args, **kwds)` raises *exc* and the message matches regex `r` |
| `assertWarns(warn, fun, *args, **kwds)`         | `fun(*args, **kwds)` raises warn                                    |
| `assertWarnsRegex(warn, r, fun, *args, **kwds)` | `fun(*args, **kwds)` raises warn and the message matches regex *r*  |
| `assertLogs(logger, level)`                     | The with block logs on logger with minimum level                    |

| Method                       | Checks that                                                                   |
|------------------------------|-------------------------------------------------------------------------------|
| `assertAlmostEqual(a, b)`    | `round(a-b, 7) == 0`                                                          |
| `assertNotAlmostEqual(a, b)` | `round(a-b, 7) != 0`                                                          |
| `assertGreater(a, b)`        | `a > b`                                                                       |
| `assertGreaterEqual(a, b)`   | `a >= b`                                                                      |
| `assertLess(a, b)`           | `a < b`                                                                       |
| `assertLessEqual(a, b)`      | `a <= b`                                                                      |
| `assertRegex(s, r)`          | `r.search(s)`                                                                 |
| `assertNotRegex(s, r)`       | `not r.search(s)`                                                             |
| `assertCountEqual(a, b)`     | a and b have the same elements in the same number, regardless of their order. |

| Method                       | Used to compare    |
|------------------------------|--------------------|
| `assertMultiLineEqual(a, b)` | strings            |
| `assertSequenceEqual(a, b)`  | sequences          |
| `assertListEqual(a, b)`      | lists              |
| `assertTupleEqual(a, b)`     | tuples             |
| `assertSetEqual(a, b)`       | sets or frozensets |
| `assertDictEqual(a, b)`      | dicts              |
