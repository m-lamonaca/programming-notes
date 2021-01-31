# Itertools Module

```py
# iteratore restituisce somma cumulativa, se presente viene applicata func( , )
# accumulate([1,2,3,4,5]) -> 1, 3(1+2), 6(1+2+3), 10(1+2+3+6), 15(1+2+3+4+5)
# accumulate(iter, func( , )) -> iter[0], func(iter[0] + iter[1]) + func(ris_prec + iter[2]), ...
accumulate(iterabile, func(_, _))

# iteratore restituisce elemenmti dal primo iterabile,
# poi procede al successivo fino alla fine degli iterabili
# non funziona se l'iterabile è uno solo
chain(*iterabili)

ChainMap(*maps)  # A ChainMap groups multiple dicts or other mappings together to create a single, updateable view. Lookups search the underlying mappings successively until a key is found. A ChainMap incorporates the underlying mappings by reference. So, if one of the underlying mappings gets updated, those changes will be reflected in ChainMap

# concatena elementi del singolo iterabile anche se contiene sequenze
chain.from_iterable(iterabile)

# restituisce sequenze di lunghezza r a partire dall'iterabile
# elementi trattati come unici in base al loro valore
combinations(iterabile, r)

# # restituisce sequenze di lunghezza r a partire dall'iterabile permettendo la ripetizione degli elementi
combinations_with_replacement(iterabile, r)

# iteratore filtra elementi di data restituenso solo quelli che hanno
#  un corrispondente elemento in selectors che ha valore vero
compress(data, selectors)

# iteratore restituiente valori equidistanti a partire da start
#! ATTENZIONE: sequenza numerica infinita
count(start, step)

# iteratore restituiente valori in sequenza infinita
cycle(iterabile)

# iteratore droppa elementi dell'iterabile finchè il predicato è vero
dropwhile(predicato, iterabile)

# iteratore restituiente valori se il predicato è falso
filterfalse(predicato, iterabile)

# iteratore restituisce tuple (key, group)
# key è il criterio di raggruppamento
# group è un generatore restituiente i membri del gruppo
groupby(iterabile, key=None)

# iteratore restituisce slice dell'iterabile
isslice(iterable, stop)
isslice(iterable, start, stop, step)

# restituisce tutte le permutazioni di lunghezza r dell'iterabile
permutations(iterabile, r=None)

# prodotto cartesiano degli iterabili
# cicla iterabili in ordine di input
# [product('ABCD', 'xy') -> Ax Ay Bx By Cx Cy Dx Dy]
# [product('ABCD', repeat=2) -> AA AB AC AD BA BB BC BD CA CB CC CD DA DB DC DD]
product(*iterabili, ripetizioni=1)

# restituisce un oggetto infinite volte se ripetizioni non viene specificato
repeat(oggetto, ripetizioni)

# iteratore computa func(iterabile)
# usato se iterabile è sequenza pre-zipped (seq di tuple raggruppanti elementi)
starmap(func, iterabile)

# iteratore restituiente valori da iterabile finchè predicato è vero
takewhile(predicato, iterabile)

# restituisce n iteratori indipendenti dal singolo iterabile
tee(iterabile, n=2)

# produce un iteratore che aggrega elementi da ogni iterabile
# se gli iterabili hanno lunghezze differenti i valori mancanti sono riempiti secondo fillervalue
zip_longest(*iterabile, fillvalue=None)
```
