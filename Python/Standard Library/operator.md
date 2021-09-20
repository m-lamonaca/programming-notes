# Operator Module Cheat Sheet

```py
# OPERATORI CONFRONTO
__lt__(a, b), lt(a, b)  # a < b
__le__(a, b), le(a, b)  # a <= b
__eq__(a, b), eq(a, b)  # a == b
__ne__(a, b), ne(a, b)  # a != b
__ge__(a, b), ge(a, b)  # a >= b
__gt__(a, b), gt(a, b)  # a > b


not_(obj)
truth(obj)
is_(a, b)
is_not(a, b)


__abs__(a, b), abs(obj)
__add__(a, b), add(a, b)  # a + b
__sub__(a, b), sub(a, b)  # a - b
__mul__(a,b), mul(a,b)  # a * b
__mul__(a, b), pow(a,b)  # a ** b
__truediv__(a, b), truediv(a, b)  # a / b
__floordiv__(a, b), floordiv(a, b)  # return a // b
__mod__(a, b), mod(a, b)  # a % b
__neg__(obj), neg(obj)  # -obj
__index__(a), index(a)

__and__(a, b), and_(a, b)  # a & b
__or__(a, b), or_(a, b)  # a | b
__xor__(a, b), xor(a, b)  # a ^ b

__inv__(obj), inv(obj), __inverse__(obj), inverse(obj)  # ~obj
__lshift__(obj), lshift(a, b)

__concat__(a, b), concat(a, b) 
__contains__(a, b), contains(a, b)
countOf(a, b)
indexOf(a, b)

__delitem__(a, b), delitem(a, b)
__getitem__(a, b), getitem(a, b)
__setitem__(a, b), setitem(a, b)
