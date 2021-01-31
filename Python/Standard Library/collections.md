
# Collections Module

```py
# COUNTER()
# sottoclasse dizionario per contare oggetti hash-abili
from collections import Counter
Counter(sequenza)  # -> oggetto Counter
# {item: num comparese in sequenza, ...}

var = Counter(sequenza)
var.most_common(n)  # produce lista degli elementi più comuni (n più comuni)
sum(var.values())  # totale di tutti i conteggi
var.clear()  #reset tutti i conteggi
list(var)  # elenca elementi unici
set(var)  # converte in un set
dict(var)   # converte in un dizionario regolare
var.items()  # converte in una lista di coppie (elemento, conteggio)
Counter(dict(list_of_pairs))  # converte da una lista di coppie
var.most_common[:-n-1:-1]  # n elementi meno comuni
var += Counter()  # rimuove zero e conteggi negativi


# DEFAULTDICT()
# oggetto simil-dizionario che come primo argomento prende un tipo di default
# defaultdict non solleverà mai un eccezione KeyError.
# le chiavi non esistenti ritornano un valore di default (default_factory)
from collections import defaultdict
var = defaultdict(default_factory)
var.popitem()  # rimuove e restituisce primo elemento
var.popitem(last=True) # rimuove e restituisce ultimo elemento


# OREDERDDICT()
# sottoclasse dizionario che "ricorda" l'ordine in cui vengono inseriti i contenuti
# dizionari normali hanno ordinamento casuale
nome_dict = OrderedDict()
# OrderedDict con stessi elementi ma ordine diverso sono considerati diversi


# USERDICT()
# implementazione pura in pythondi una mappa che funziona come un normale dizionario.
# Designata per creare sottoclassi
UserDict.data  # recipiente del contenuto di UserDict


# NAMEDTUPLE()
# ogni namedtuple è rappresentata dalla propria classe
from collections import namedtuple
NomeClasse = namedtuple(NomeClasse, parametri_separati_da_spazio)
var = NomeClasse(parametri)
var.attributo  # accesso agli attributi
var[index]  # accesso agli attributi
var._fields  # accesso ad elenco attributi
var = classe._make(iterabile)  # trasformain namedtuple
var._asdict()  # restituisce oggetto OrderedDict a partire dalla namedtuple


# DEQUE()
# double ended queue (pronunciato "deck")
# lista modificabuile da entrambi i "lati"
from collections import deque
var = deque(iterabile, maxlen=num)  # -> oggetto deque
var.append(item)  # aggiunge item al fondo
var.appendleft(item)  # aggiunge item all'inizio
var.clear()  # rimuove tutti gli elementi
var.extend(iterabile)  # aggiunge iterabile al fondo
var.extendleft(iterabile)  # aggiunge iterabile all'inizio'
var.insert(index, item)  # inserisce  in posizione index
var.index(item, start, stop)  # restituisce posizione di item
var.count(item)
var.pop()
var.popleft()
var.remove(valore)
var.reverse()  # inverte ordine elementi
var.rotate(n)  # sposta gli elementi di n step (dx se n > 0, sx se n < 0)
var.sort()
```
