# Unit Testing

[UnitTest Overloaded Methods](https://stackoverflow.com/a/5666591/8319610)
[Naming standards for unit tests](https://osherove.com/blog/2005/4/3/naming-standards-for-unit-tests.html)

## xUnit

```cs
using System;
using Xunit;

namespace Project.Tests
{
    public class ClassTest
    {
        [Fact]
        public void TestMethod()
        {
            Assert.Equal(expected, actual);  // works on collections
            Assert.True(bool);
            Assert.False(bool);
            Assert.NotNull(nullable);

            // Verifies that all items in the collection pass when executed against action
            Assert.All<T>(IEnumerable<T> collection, Action<T> action);
        }
    }
}
```

## Mocking with Moq

```cs
var mockObj = new Mock<MockedType>();

mockObj.Setup(m => m.Method(It.IsAny<InputType>())).Returns(value);
mockObj.Object;  // get mock

// check that the invocation is forwarded to the mock, n times
mockObj.Verify(m => m.Method(It.IsAny<InputType>()), Times.Once());

// check that the invocation is forwarded to the mock with a specific input
mockObj.Verify(m => m.Method(input), Times.Once());
```