# Unit Testing

## MSTest

[Microsoft Unit Testing Tutorial](https://docs.microsoft.com/en-us/visualstudio/test/walkthrough-creating-and-running-unit-tests-for-managed-code?view=vs-2019)

To test a project add a **MSTest Test Projet** to the solution.

The test runner will execute any methods marked with `[TestInitialize]` once for every test the class contains, and will do so before running the actual test method itself.  
The `[TestMethod]` attribute tells the test runner which methods represent tests.

In `TestClass.cs`:

```cs
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Project.Tests
{
    [TestClass]
    public class TestClass
    {
        [TestMethod]
        public void TestMethod()
        {
            Assert.AreEqual(expected, actual);
            Assert.IsTrue(bool);
            Assert.IsFalse(bool);
            Assert.IsNotNull(nullable);

            // assertions on collections
            CollectionAssert.AreEqual(expexcted, actual),
        }
    }
}
```

---

[UnitTest Overloaded Methods](https://stackoverflow.com/a/5666591/8319610)
[Naming standards for unit tests](https://osherove.com/blog/2005/4/3/naming-standards-for-unit-tests.html)
