# Common Regex Syntax

## Classi Di Caratteri

`\d` qualsiasi cifra (0-9)  
`\D` qualsiasi carattere non cifra  
`\s` spazio bianco (space, tab, new line)  
`\S` qualsiasi carattere  non spazio binaco  
`\w` qualsiasi carattere alfanumerico(a-z, A-Z)  
`\W` qualsiasi carattere non alfanumerico  
`\b` spazio intorno alle parole (solo inizio o fine stringa)  
`\B` spazio intorno alle parole (solo se all'interno della stringa, no ad inizio o fine)  
`\A` ricerca solo all'inizio della stringa  
`\Z` ricerca solo al fondo della stringa  
`.` tutti i caratteri tranne linea nuova (CRLF)  

## Quantificatori

`+` una o più ripetizioni  
`*` zero o più ripetizioni  
`?` zero o una ripetizione  
`{m}` esattamente *m* volte  
`{m, n}` minimo *m* volte massimo *n* volte  

The `*`, `x`, and `?` qualifiers are all greedy; they match as much text as possible  
Adding `?` *after* the qualifier makes it perform the match in non-greedy or minimal fashion; as few characters as possible will be matched.

## Caratteri Speciali

`\a, \b, \f, \n, \r, \t, \u, \U, \v, \x, \\, \?, \*, \+ , \., \^, \$`   caratteri speciali  
`\(`, `\)` escape delle parentesi nella stringa

## Delimitatori

`^` cerca corrispondenza ad inizio stringa o linea  
`$` cerca corrispondenza a fondo stringa o linea  
`^__$` corrispondenza deve essere l'intera stringa  

## Classi Caratteri

`[__]` un carattere tra quelli nella classe (`[ab]` --> a or b)  
`[__]{m , n}` caratteri consecutivi tra quelli nella classe (`[aeiou]{2}` --> ae, ao, ...)  
`[a-z]` sequenza di caratteri minuscoli  
`[A-Z]` sequenza di caratteri maiuscoli  
`[a-zA-Z]` sequenza di carateri minuscoli o maiuscoli  
`[a-z][A-Z]` equenza di caratteri miuscoli seguiti da sequenza di caratteri maiuscoli  
`[^__]` tutto tranne quello nella classe (**attenzione**: includere `\n` per evitare di includere linee multiple di testo)

GLi unici simboli con effetto nelle classi di caratteri sono `^`, `\`, `-` e `]`.
Per essere usati devono essere usati come escape: `[\]\[\^\-]`

## Gruppi

`(__)` sottogruppo della REGEX, utile per raggruppare parti della REGEX  
`(REGEX_1 | REGEX_2)` cerca corrispondenza di REGEX multiple (R1 OR R2)  
`(?#__)` cerca commenti  
`(?=__)` corrisponde solo se `__` è prossima substringa  
`(?!__)` corrisponde solo se `__` non è prossima substringa  
`(?<=__)` corrisponde se `__` è substringa precedente  
`(?<!__)` corrisponde solo se `__` non è substringa precedente

`\<number>` fa riferimento all'n-esimo gruppo.

## Casi Particolari

`(.*)` corrisponde con qualsiasi cosa
`(.*?)` corrisponde con qualsiasi cosa, non-greedy match
