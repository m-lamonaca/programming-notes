# Operator Module Cheat Sheet

```py
# OPERATORI CONFRONTO
__lt__(a, b), lt(a, b)  # a < b
__le__(a, b), le(a, b)  # a <= b
__eq__(a, b), eq(a, b)  # a == b
__ne__(a, b), ne(a, b)  # a != b
__ge__(a, b), ge(a, b)  # a >= b
__gt__(a, b), gt(a, b)  # a > b

# OPERATOTI LOGICI
not_(obj)  # not obj
truth(obj)  # True o Flase ini base a valore verità oggetto (come costruttore bool)
is_(a, b)   # return a is b
is_not(a, b) # return a is not b

# OPARATORI BINARI E MATEMATICI
__abs__(a, b), abs(obj)  # valore assoluto di obj
__add__(a, b), add(a, b)  # a + b
__sub__(a, b), sub(a, b)  # a - b
__mul__(a,b), mul(a,b)  # a * b
__mul__(a, b), pow(a,b)  # a ** b
__truediv__(a, b), truediv(a, b)  # a / b
__floordiv__(a, b), floordiv(a, b)  # return a // b
__mod__(a, b), mod(a, b)  # a % b
__neg__(obj), neg(obj)  # -obj
__index__(a), index(a)  # converte a in intero

__and__(a, b), and_(a, b)   # a and b binario (a & b)
__or__(a, b), or_(a, b)  # a or b binario (a | b)
__xor__(a, b), xor(a, b)  # a xor b binario (a ^ b)

__inv__(obj), inv(obj), __inverse__(obj), inverse(obj)  # inverso binario di obj, ~obj
__lshift__(obj), lshift(a, b)  # restituisce a spostato a sinistra di b

__concat__(a, b), concat(a, b)  # a + b per sequenze (CONCATENZIONE)
__contains__(a, b), contains(a, b)  # return b in a
countOf(a, b)  # numero occorrenze b in a
indexOF(a, b)  # restituisce prima occorrenza di b in a

__delitem__(a, b), delitem(a, b)  # rimuove valore a in posizione b
__getitem__(a, b), getitem(a, b)  # restituisce valore a in posizione b
__setitem__(a, b), setitem(a, b)  # setta valore a in psoizione b

# ATTRGETTER
# restituisce oggetto chiamabile che recupera attributo attr da oggetto
funz = attrgetter(*attr)
funz(var)  # restituisce var.attr

# ITEMGETTER
# restituisce oggetto chiamabile che recupera item dall'oggetto
# implementa __getitem__
funz = itemgetter(*item)
funz(var)  # restituisce var[item]

# METHODCALLER
# restutiusce oggetto che chiama metodo method sull'oggetto
var = methodcaller(method, args)
var(obj)  # return obj.method()
```
