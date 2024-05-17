# [Assembly (RISC-V)][book]

[book]: https://riscv-programming.org/book/riscv-book.html "An Introduction to Assembly Programming with RISC-V"

Assembly programs are encoded as plain text files and contain four main elements:

- **Comments**: comments are textual notes that are often used to document information on the code.
- **Labels**: labels are "markers" that represent program locations.
- **Instructions**: Assembly instructions are instructions that are converted by the assembler into machine instructions.
- **Directives**: Assembly directives are commands used to coordinate the assembling process.

## Assembly Language

### Labels

**Labels** are "markers" that represent program _locations_. They can be inserted into an assembly program to "mark" a program position so that it can be referred to by assembly instructions.

```asm
x:  # <-- label definition
  .word 10

sum:
  lw a0, x
  addi a0, a0, 10
  ret
```

Assemblers usually accept two kinds of labels: **symbolic** and **numeric** labels.

Symbolic labels are deﬁned by an _identifier_ followed by `:`.
They are stored as symbols in the symbol table and are often used to identify global variables and routines.

Numeric labels are deﬁned by a _single decimal digit_ followed by `:`.
They are used for local reference and are _not included_ in the symbol table of executable files. They can be redefined repeatedly in the same assembly program.  

References to numeric labels contain a _suffix_ that indicates whether the reference is to a numeric label positioned before (`b` suffix) or after (`f` suffix) the reference.

### Symbols

Program **symbols** are "names" that are associated with _numerical values_ and the **symbol table** is a data structure that maps each program symbol to its value.  
Labels are automatically converted into program symbols by the assembler and associated with a numerical value that represents its position in the program, which is a memory address.

It's possible to explicitly define symbols with the `.set` (or `.equ`) directive.

```asm
.set answer, 42

get_answer:
  li a0, answer
  ret
```

### References & Relocations

Each reference to a label must be replaced by an address during the assembling and linking processes. **Relocation** is the process in which the code and data are assigned new memory addresses so that they do not conflict with addresses of coming from the other linked sources.

The **relocation table** is a data structure that contains information that describes how the program instructions and data need to be modiﬁed to reﬂect the addresses reassignment. Each object ﬁle contains a relocation table and the linker uses their information to adjust the code when performing the relocation process.

### Global vs Local Symbols

Symbols are classified as _local_ or _global_ symbols.

**Local symbols** are only visible on the same ﬁle, i.e., the linker does not use them to resolve undefined references on other files.  
**Global symbols**, on the other hand, are used by the linker to resolve undefined reference on other files.

By default, the assembler registers labels as local symbols. The `.globl` directive instructs the assembler to register a label as a global symbol.

```asm
.globl exit

exit:
  li a0, 0
  li a7, 93
  ecall
```

### Program Entry Point

Every program has an **entry point**: the point from which the CPU must start executing the program.
The entry point is deﬁned by an address, which is the address of the _first_ instruction that must be executed.

```asm
.globl start # <-- program entry point 
```

> **Note**: the `start` label **must** be registered as a _global_ symbol for the linker to recognize it as the entry point.

## Program Sections

Executable and object files, and assembly programs are usually organized in **sections**.  
A section may contain data or instructions, and the contents of each section are mapped to a set of consecutive main memory addresses.

The following sections are often present on executable files generated for Linux-based systems:

- `.text`: a section dedicated to store the program instructions.
- `.data`: a section dedicated to store initialized global variables.
- `.bss`: a section dedicated to store uninitialized global variables.
- `.rodata`: a section dedicated to store constants.

When linking multiple object files, the linker groups information from sections with the same name and places them together into a single section on the executable ﬁle.

To instruct the assembler to add the assembled information into other sections, the programmer (or the compiler) may use the `.section <name>` directive.

```asm
.section .text

update_y:
  la t1, y
  sw a0, (t1)
  ret

update_x:
  la t1, x
  sw a0, (t1)
  ret

.section .data

x: .word 10
y: .word 12
```

### Assembly Instructions

Assembly instructions are instructions that are converted by the assembler into machine instructions.  
They are usually encoded as a string that contains a **mnemonic** and a sequence of parameters, known as **operands**.

A **pseudo-instruction** is an assembly instruction that does not have a corresponding machine instruction on the ISA, but can be translated automatically by the assembler into one or more alternative machine instructions to achieve the same effect.

The operands of assembly instructions may contain:

- **A register name**: a register name identifies one of the ISA registers.

 <!-- RV32I ISA registers are numbered from 0 to 31 and are named x0, x1, ..., x31. 
 RV32I registers may also be identified by their aliases, for example, a0, t1, ra, etc.-->

- **An immediate value**: an immediate value is a numerical constant that is directly encoded into the machine instruction as a sequence of bits.
- **A symbol name**: symbol names identify symbols on the symbol table and are replaced by their respective values during the assembling and linking processes.
  Their value are encoded into the machine instruction as a sequence of bits.

### Immediate Values

Immediate values are represented on assembly language by a sequence of alphanumeric characters.

- Sequences started with the `0x` and the `0b` prefixes are interpreted as hexadecimal and binary numbers, respectively.  
- Octal numbers are represented by a sequence of numeric digits starting with digit `0`.  
- Sequences of numeric digits starting with digits `1` to `9` are interpreted as decimal numbers.
- Alphanumeric characters represented between single quotation marks are converted to numeric values using the ASCII table
- To denote a negative integer, it suffices to add the `-` prefix.

```asm
li a0, 10        # load value ten into register a0
2 li a1, 0xa     # load value ten into register a1
3 li a2, 0b1010  # load value ten into register a2
4 li a3, 012     # load value ten into register a3
5 li a4, ’0’     # load value forty eight into register a4
6 li a5, ’a’     # load value ninety seven into register a5
```

### The `.<value>` Directives

The `.byte`, `.half`, `.word`, and `.dword` directives add one or more values to the active section. Their arguments may be expressed as immediate
values, symbols (which are replaced by their value during the assembling and linking processes) or by arithmetic expressions that combine both.

The `.string`, `.asciz`, and `.ascii` directives add strings to the active section. The string is encoded as a sequence of bytes.

| Directive | Arguments        | Description                                      |
|:---------:|:----------------:|:------------------------------------------------:|
| `.byte`   | `expr [, expr]*` | Emit one or more **8bit** comma separated words  |
| `.half`   | `expr [, expr]*` | Emit one or more **16bit** comma separated words |
| `.word`   | `expr [, expr]*` | Emit one or more **32bit** comma separated words |
| `.dword`  | `expr [, expr]*` | Emit one or more **64bit** comma separated words |
| `.string` | `string`         | Emit `NULL` terminated string                    |
| `.asciz`  | `string`         | Alias for `.string`                              |
| `.ascii`  | `string`         | Emit string without `NULL` character             |

### The `.set` and `.equ` directives

The `.set name, expression` directive adds a symbol to the symbol table.  
It takes a name and an expression as arguments, evaluates an expression to a value and store the name and the resulting value into the symbol table.

The `.equ` directive performs the same task as the .set directive.

### The `.globl` directive

The `.globl` directive can be used to turn local symbols into global ones.

```asm
.global start
.global max_value

.set max_value, 42

start:
  li a0, max_value
  jal process_temp
  ret
```

### The `.skip` directive

The `.bss` section is dedicated for storing _uninitialized_ global variables.  
These variables need to be allocated on memory, but they do not need to be initialized by the loader when a program is executed. As a consequence, their initial value do not need to be stored on executable nor object files.

To allocate variables on the `.bss` section it suffices to declare a label to identify the variable and advance the `.bss` location counter by the amount of bytes the variable require, so further variables are allocated on other address.  
The `.skip N` directive is a directive that advances the location counter by `N` units and can be used to allocate space for variables on the `.bss` section.

```asm
.section .bss
x: .skip 4
y: .skip 80
z: .skip 4
```

### The `.align` directive

Some ISA's require instructions or multi-byte data to be stored on addresses that are multiple of a given number.

The proper way of ensuring the location counter is aligned is by using the `.align N` directive.  
The `.align N` directive checks if the location counter is a _multiple_ of `2^N`, if it is, it has no effect on the program, otherwise, it advances the location counter to the next value that is a multiple of `2^N`.
