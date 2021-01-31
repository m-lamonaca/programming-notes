# Java Server Pages Cheat Sheet

Java embedded in html.
Codice + JSP salvati in file `.war`

[TEMP Notes Source](https://github.com/maboglia/CorsoJava/blob/master/appunti/057_JSP_appunti.md#corso-jsp---le-direttive)

## Directives

Le direttive Le direttive permettono di definire la struttura di tutto il documento JSP. Indicano gli aspetti principali del *servlet* in cui sarà convertito il file JSP.

Sono processati al momento della conversione in servlet, a compile-time.

Le direttive esistenti sono: *page*, *include* e *taglib*.

- `<%@ page attribute="value" %>`
- `<%@ include file="path" %>`
- `<%@ taglib ...%>`

Introdotte dal simbolo `@` possono contenere diversi attributi, in alcuni casi concatenabili come per la direttiva import.

### Attributi Direttiva `Page`

**`import="package.class"`**  
Lista di package o classes, separati da virgola, che saranno importati per essere utilizzati nel codice java.

**`session ="true | false"`**
Specifica se la pagina fa parte di una sessione HTTP. Se si inizializza a true, è disponibile l'oggetto implicito sessione.

**`buffer ="dimensione-kb"`**
Specifica la dimensione di un buffer di uscita di tipo stream, per il client.

**`errorPage="url"`**
Specifica una pagina JSP che sarà processata nel caso si verifichi un errore.

**`isErrorPage="true|false"`**
Indica che la pagina è una pagina di errore JSP e può mostrare a video l'output dell'errore verificatosi. Per default è settata false.

**`contentType="MIME-Type"`**, **`contentType="MIME-Type; charset=Character-Set"`**
valore MIME di default è text/html

### Direttiva `Include`

Indica al motore JSP di includere il contenuto del file corrispondente, inserendolo al posto della direttiva nella pagina JSP. Il contenuto del file incluso è analizzato al momento della traduzione del file JSP e si include una copia del file stesso nel servlet generato. Una volta incluso, se si modifica il file non sarà ricompilato nel servlet. Il tipo di file da includere può essere un file html (*statico*) o un file jsp (*dinamico*).

```jsp
<html>
  <head>
    <title> pagina di prova Direttive  </title>
  </head>
  <body>
    <h1>pagina di prova Direttive inclusione</h1>
    <%@ include file="/hello_world.html" %>
    <%@ include file=”/login.jsp” %>
  </body>
</html>
```

### Direttiva `Taglib`

Permette estendere i marcatori di JSP con etichette o marcatori generati dall'utente (etichette personalizzate).

Sintassi: `<%@ taglib uri="taglibraryURI" prefix="tagPrefix" %>`

Esempi librerie standard:

- JSTL core
- JSTL sql
- JSTL function

## Implicit Objects

JSP utilizza gli oggetti impliciti (built-in).

Gli oggetti impliciti sono oggetti istanziati automaticamente dall’ambiente JSP, non dobbiamo preoccuparci di importarli e istanziarli.  
Per utilizzarli è sufficiente usare la sintassi `nomeOggetto.nomeMetodo`.

Oggetti disponibili per l’uso in pagine JSP:

- **out**: per scrivere codice HTML nella risposta (System.out di Java)
- **session**: dati specifici della sessione utente corrente
- **request**: richiesta HTTP ricevuta e i suoi attributi, header, cookie, parametri, etc.
- **page**: la pagina e le sue proprietà.
- **config**: dati di configurazione
- **response**: risposta HTTP e le sue proprietà.
- **application**: dati condivisi da tutte le pagine della web application
- **exception**: eventuali eccezioni lanciate dal server; utile per pagine di errore
- **pageContext**: dati di contesto per l’esecuzione della pagina

Gli oggetti impliciti possono essere:

- oggetti legati alla servlet relativa alla pagina JSP
- oggetti legati all’input e all’output della pagina JSP
- oggetti che forniscono informazioni sul contesto in cui la JSP viene eseguita
- oggetti risultanti da eventuali errori

Ambito Definisce dove e per quanto tempo saranno accessibili gli oggetti (oggetti impliciti, JavaBeans, ...):

- di pagina: l'oggetto è accessibile dal servlet che rappresenta la pagina
- di richiesta: l'oggetto viene creato e poi distrutto dopo l'uso
- di sessione: l'oggetto è accessibile durante tutta la sessione
- di applicazione: l'oggetto è accessibile dal servlet che rappresenta la pagina

---

## Code in JSP Page

`<% /* code here */ %>` is used to embed java code in a JSP page.
`<%= var %>` is used to get a value from a variable to be displayed.

### Request Parameters

```java
Type variable = request.getParameter("request_parameter");  // parameter of a GET request
```
