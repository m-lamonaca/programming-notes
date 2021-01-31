# CSV Module Cheat Sheet

```python
# itera linee di csvfile
.reader(csvfile, dialect, **fmtparams) --> oggetto reader

# METODI READER
.__next__()  # restituisce prossima riga dell'oggetto iterabile come una lista o un dizionario

# ATTRIBUTI READER
dialect  # descrizione read-only del dialec usato
line_num  # numero di linee dall'inizio dell'iteratore
fieldnames

# converte data in stringhe delimitate
# csvfile deve supportare .write()
#tipo None convertito a stringa vuota (semplifica dump di SQL NULL)
.writer(csvfile, dialect, **fmtparams) --> oggetto writer

# METODI WRITER
# row deve essere iterabile di stringhe o numeri oppure dei dizionari
.writerow(row)  # scrive row formattata secondo il dialect corrente
.writerows(rows)  # scrive tutti gli elementi in rows formattati secondo il dialect corrente. rows è iterdabile di row

# METODI CSV
# associa dialect a name (name deve essere stringa)
.register_dialect(name, dialect, **fmtparams)

# elimina il dialect associato a name
.unregister_dialect()

# restituisce il dialet associato a name
.get_dialect(name)

# elenco dialec associati a name
.list_dialect(name)

# restituisce (se vuoto) o setta il limite del campo del csv
.field_size_limit(new_limit)

'''
csvfile    --oggetto iterabile restituente una string ad ogni chiamata di __next__()
          se csv è un file deve essere aperto con newline='' (newline universale)
dialect    --specifica il dialetto del csv (Excel, ...) (OPZIONALE)

fmtparams    --override parametri di formattazione (OPZIONALE)   https://docs.python.org/3/library/csv.html#csv-fmt-params
'''

# oggetto operante come reader ma mappa le info in ogni riga in un OrderedDict le cui chiavi sono opzionali e passate tramite fieldnames
class csv.Dictreader(f, fieldnames=None, restket=none, restval=None, dialect, *args, **kwargs)
'''
f    --file da leggere
fieldnames    --sequenza, definisce i nomi dei campi del csv. se omesso usa la prima linea di f
restval, restkey    --se len(row) > fieldnames dati in eccesso memorizzati in restval e restkey

parametri aggiuntivi passati a istanza reader sottostante
'''

class csv.DictWriter(f, fieldnames, restval='', extrasaction, dialect, *args, **kwargs)
'''
f    --file da leggere
fieldnames    --sequenza, definisce i nomi dei campi del csv. (NECESSARIO)
restval    --se len(row) > fieldnames dati in eccesso memorizzati in restval e restkey
extrasaction    --se il dizionario passato a writerow() contiene key non presente in fieldnames extrasaction decide azione da intraprendere (raise causa valueError, ignore ignora le key aggiuntive)

parametri aggiuntivi passati a istanza writer sottostante
'''

# METODI DICTREADER
.writeheader()  # scrive una riga di intestazione di campi come specificato da fieldnames

# classe usata per dedurre il formato del CSV
class csv.Sniffer
.sniff(campione, delimiters=None)  #analizza il campione e restituisce una classe Dialect. delimiter è sequenza di possibili delimitatori di caselle
.has_header(campione) --> bool  # True se prima riga è una serie di intestazioni di colonna

#COSTANTI
csv.QUOTE_ALL  # indica a writer di citere (" ") tutti i campi
csv.QUOTE_MINIMAL  # indica a write di citare solo i campi contenenti caratteri speciali come delimiter, quotechar ...
csv.QUOTE_NONNUMERIC  # indica al vriter di citare tutti i campi non numerici
csv.QUOTE_NONE  # indica a write di non citare mai i campi
```
