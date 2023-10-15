# Assembly (Inter - x86_64)

> **WARN**: Since assembly is _not_ portable all instructions will only work under a 64bit Linux system.

## Compiling & Linking

```sh
# compiling
nasm -g -f elf64 src.asm  # -g adds debug info, -f specifies the 64bit ELF format

# linking
ld -o src src.o  # -o specifies the output name
```

## Basics

### Exports & Sections

Symbols can be exported to be linked against with the linker

Every program in ELF has several sections:

- `data`: global variables
- `rodata`: global constants (read-only data)
- `bss`: space reserved at program startup
- `text`: CPU instructions

```asm
; export the '_start' symbol for linking
global _start

; specify a section
section .data
section .text
```

### Labels & Declarations

Anything that's on the beginning of a line and is followed by a colon (`:`) is a label. Labels generally store addresses.

Declaration instructions:

- `db`: declare bytes
- `dw`: declare word (2 bytes)
- `dd`: declare double word (4 bytes)
- `dq`: declare quad word (8 bytes)
- `equ`: set a name to the value of an expression

> **Note**: See the NASM manual, section 3.2.1 for the full list.
> **Note**: all byte declaarations are [Little Endian](https://en.wikipedia.org/wiki/Endianness "Endiannes")

```asm
arr: db 0x12,0x34,0x56,0x78,0x90
```

### Registers

There are several registers available on x86_64.  
Some serve a specific purposes (e.g. registers for storing floating point ; numbers), while others are called "general purpose" registers.

There are 16 of them:

- `rax`: accumulator
- `rbx`: base
- `rcx`: counter
- `rdx`: destination
- `rsp` and `rbp`: stack pointer and base pointer
- `rsi` and `rdi`: source and destination index
- `r8` through `r15`: lack of creativity

The prefix `r` means that instructions will use **all 64 bits** in the registers.  

For all those registers, except `r8` through `r15`, it's possible to access:

- the **lowest 32 bits** with `e` _prefix_ (e.g. `eax`, `ebp`)
- the **lowest 16 bits** _without_ any _prefix_ (e.g. `ax`, `si`)

For registers `rax` through `rdx`, it's possible to access:

- the **lowest byte** with the `l` _suffix_, replacing the trailing `x` (e.g. `al`)
- the **highest byt** in the 16 bits with the `h` _suffix_, in the same way (e.g. `ah`)

## Instructions

Instructions are operations that the CPU knowns how to execute directly.  
They are separated from their operands by whitespace, and the operands are separated from other with commas.

```asm
<instr> <operand1>, <operand2>, ..., <operand_n>

; Intel syntax dictates the first operand is the destination, and the second is the source
<instr> DEST, SOURCE
```

```asm
mov eax, 0x12345678  ; copies 4 bytes to eax
inc rdi  ; INC: increment
dec rsi  ; DEC: decrement
```

### `add`

Adds the two operands and stores the result in the _destination_.

```asm
add rdi, rbx  ; Equivalent to rdi += rbx
```

### `sub`

Subtract the two operands and stores the result in the _destination_.

```asm
sub rsi, rbx  ; Equivalent to rsi -= rbx
```

### `mul`, `div`, `imul`, `idiv`

`mul` and `div` interpret their  operands as unsigned integers.  
`imul` and `idiv` interpret their operands as signed integers in two's complement.

`mul` and `div` instructions take a single operand because they use fixed registers for the other number.

For `mul`, the result is `rax` * `<operand>`, and it's a _128-bit_ value stored in `rdx:rax`,
meaning the _64 lower bits_ are stored in `rdx`, while the _64 upper bits_ are stored in `rax`.

For `div`, the operand is the **divisor** and the **dividend** is `rdx:rax`,
meaning it's a _128-bit_ value whose _64 upper bits_ are in `rdx` and whose _64 lower bits_ are in `rax`.  
The **quotient** is a _64-bit_ value stored in `rax`, and the **remainder** is also a _64-bit_ value, stored in `rdx`.

### `and`, `or`, `xor`

```asm
and rdi, rsi  ; bitwise AND
or rdi, rsi  ; bitwise OR
xor rdi, rsi  ; bitwise XOR
```

### `shr`, `shl`

```asm
shr rsi, 2  ; right (logical) bitshift: equivalent to rsi >> 2
shl rsi, 3  ; left (logical) bitshift: equivalent to rsi << 3
```

**Note**: there's `sar` for arithmetic right shift and `sal` for arithmetic shift left.
