# Functools Module Cheat Sheet

Hiegher-order functions and operations on callable objects.

```py
# crea nuova funzione con argomenti (*args, **kwarg) parzialmente fissati
new_func = partial(func, *args, **kwargs)

# crea nuovo metodo con argomenti (*args, **kwarg) parzialmente fissati
new_method = partialmethod(func, *args, **kwargs)

# applica ripetutamente funzione( , ) all'iterabile per creare un output singolo
# funzione applicata ai primi due elementi
# restituisce inizzializzatore se l'iterabile è vuoto (dipendente dalla funzione)
reduce(funzione((arg_1, arg_2), iterabile, inizzializzatore)  # -> singolo output

# decoratore che salva maxsixe:int chiamate recenti in cache
# utilizza dizionario per memorizzazione, argomenti (posizionali e keyworded devono essere hashabili)
# se maxsixe=None cache cresce indefinitivamente e feature LRU è disattivata
# LRU --> Least Recent Used. Elementi poco usati rimossi dalla cache
# per efficienza maxsize=2**n
@lru_cache(maxsize=128, typed=False)

# decoratore che trasforma la funzione in una single-dispatch generic function
# generic function --> singola funzione implementa la stessa operazione per tipi diversi (ALTERNATIVA A METHOD OVERLOAD)
# single dispatch --> forma di generic function in cui l'implementazione è decissa in base ad un singolo argomento
# ATTENZIONE: single dispatch deciso dal primo argomento
@singledispatch  # crea decorated_func.register per raggruppare funzioni in una generic function
@decorated_func.register()  # decide implementazione basandosi su type annotation
@decorated_func.register(type)  # decide implementazione secondo argomento type (da usare se non è presente type annotation)
# il nome di decorated_func è irrilevante
# è utile usare register(type) su ABC per supportare classi più generiche e classi future

# decoratore per aggiornare wrapper function per apparire come wrapperd function
# funz_decoratrice mantiene argomenti e docstring della funzione decorata
def decorator(funzione):
    @wraps(funzione)
    def wrapper():  #funz_decoratrice dentro decorator

# crea operatori uguaglianza se classe ne implementa almeno uno e __eq__()
@total_ordering
```
