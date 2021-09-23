# Itertools Module

```py
# accumulate([1,2,3,4,5]) -> 1, 3(1+2), 6(1+2+3), 10(1+2+3+6), 15(1+2+3+4+5)
# accumulate(iter, func( , )) -> iter[0], func(iter[0] + iter[1]) + func(prev + iter[2]), ...
accumulate(iterable, func(_, _))

# iteratore restituisce elementi dal primo iterable,
# poi procede al successivo fino alla fine degli iterabili
# non funziona se l'iterable è uno solo
chain(*iterabili)

# concatena elementi del singolo iterable anche se contiene sequenze
chain.from_iterable(iterable)

# restituisce sequenze di lunghezza r a partire dall'iterable
# elementi trattati come unici in base al loro valore
combinations(iterable, r)

# # restituisce sequenze di lunghezza r a partire dall'iterable permettendo la ripetizione degli elementi
combinations_with_replacement(iterable, r)

# iteratore filtra elementi di data restituendo solo quelli che hanno
#  un corrispondente elemento in selectors che ha valore vero
compress(data, selectors)

count(start, step)

# iteratore restituente valori in sequenza infinita
cycle(iterable)

# iteratore scarta elementi dell'iterable finché il predicato è vero
dropwhile(predicato, iterable)

# iteratore restituente valori se il predicato è falso
filterfalse(predicato, iterable)

# iteratore restituisce tuple (key, group)
# key è il criterio di raggruppamento
# group è un generatore restituente i membri del gruppo
groupby(iterable, key=None)

# iteratore restituisce slice dell'iterable
isslice(iterable, stop)
isslice(iterable, start, stop, step)

# restituisce tutte le permutazioni di lunghezza r dell'iterable
permutations(iterable, r=None)

# prodotto cartesiano degli iterabili
# cicla iterabili in ordine di input
# [product('ABCD', 'xy') -> Ax Ay Bx By Cx Cy Dx Dy]
# [product('ABCD', repeat=2) -> AA AB AC AD BA BB BC BD CA CB CC CD DA DB DC DD]
product(*iterabili, ripetizioni=1)

# restituisce un oggetto infinite volte se ripetizioni non viene specificato
repeat(oggetto, ripetizioni)

# iteratore computa func(iterable)
# usato se iterable è sequenza pre-zipped (seq di tuple raggruppanti elementi)
starmap(func, iterable)

# iteratore restituente valori da iterable finché predicato è vero
takewhile(predicato, iterable)

# restituisce n iteratori indipendenti dal singolo iterable
tee(iterable, n=2)

# produce un iteratore che aggrega elementi da ogni iterable
# se gli iterabili hanno lunghezze differenti i valori mancanti sono riempiti secondo fillervalue
zip_longest(*iterable, fillvalue=None)
```
