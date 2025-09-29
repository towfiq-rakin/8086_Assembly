# 8086 Assembly Reference & Repository Guide

> A concise yet practical guide to 8086 (Intel 16‑bit) assembly: registers, flags, addressing modes, core instruction families, directives, and example snippets you can adapt for learning or labs.

---

## Table of Contents
1. What Is This Repository?
2. Quick Start
3. 8086 CPU Overview
4. Registers (General, Segment, Pointer/Index, Flags)
5. Flags Explained
6. Addressing Modes
7. Core Instruction Categories
8. String & REP Instructions
9. Interrupts & System Interface
10. Directives & Pseudo‑Ops
11. Sample Programs
12. Optimization & Tips
13. Common Pitfalls
14. Further Reading / References
15. License

---

## 1. What Is This Repository?

A collection of 8086 assembly examples (real mode) intended for educational use: understanding low‑level programming, CPU architecture fundamentals, and classic PC execution environments (DOS / BIOS).

---

## 2. Quick Start

| Goal | Option A (Emulator) | Option B (Native Toolchain) |
|------|---------------------|-----------------------------|
| Fast experimentation | Use [emu8086](http://www.emu8086.com/) GUI | Use NASM / MASM in DOSBox |
| Assemble & run COM | (Built‑in) | `nasm -f bin demo.asm -o demo.com` then run in DOSBox |
| Assemble & link EXE | (Limited) | `nasm -f obj prog.asm -o prog.obj` then link with TLINK / LINK |
| Debug | Emulator single-step | DOSBox + `debug` / emulator |

Recommended modern workflow (Linux/macOS/WSL):

```bash
# Install NASM
sudo apt install nasm

# Assemble a .COM (tiny model)
nasm -f bin hello.asm -o HELLO.COM

# Run with DOSBox
dosbox HELLO.COM
```

---

## 3. 8086 CPU Overview

- 16‑bit internal architecture (data bus 16 bits; address bus 20 bits → 1 MB addressable)
- Segmented memory model: Physical Address = Segment * 16 + Offset
- Little endian storage
- Flags register tracks arithmetic/logical state
- Predecessor to 80286/80386; forms base for legacy real‑mode environments

---

## 4. Registers

### 4.1 General Purpose (Can be accessed as 16-bit or split into 8-bit halves)

| 16-bit | High 8 | Low 8 | Typical Primary Use |
|--------|--------|-------|---------------------|
| AX     | AH     | AL    | Accumulator (arithmetic, I/O, string ops) |
| BX     | BH     | BL    | Base register (addressing base, data) |
| CX     | CH     | CL    | Count register (loop, shift/rotate count) |
| DX     | DH     | DL    | Data (I/O ports, extend multiply/divide) |

### 4.2 Segment Registers

| Register | Purpose |
|----------|---------|
| CS       | Code Segment (instruction fetch) |
| DS       | Data Segment (default for most memory data) |
| SS       | Stack Segment (stack push/pop) |
| ES       | Extra Segment (string ops target) |

### 4.3 Pointer and Index Registers

| Register | Role |
|----------|------|
| SP       | Stack Pointer (offset within SS) |
| BP       | Base Pointer (stack frame / indirect data) |
| SI       | Source Index (string source / general index) |
| DI       | Destination Index (string destination / general index) |
| IP       | Instruction Pointer (offset inside CS—never directly written, only via control transfer) |

### 4.4 Flags Register (Status & Control)

| Flag | Bit | Mnemonic | Meaning (1 =) |
|------|-----|----------|---------------|
| CF   | 0   | Carry    | Carry / borrow / extended bit |
| PF   | 2   | Parity   | Low byte has even parity |
| AF   | 4   | AuxCarry | BCD half-carry (bit 3→4) |
| ZF   | 6   | Zero     | Result == 0 |
| SF   | 7   | Sign     | MSB (bit 15) set |
| TF   | 8   | Trap     | Single-step (debug) |
| IF   | 9   | Interrupt| Maskable interrupts enabled |
| DF   | 10  | Direction| String ops decrement if 1 |
| OF   | 11  | Overflow | Signed overflow occurred |

(Other bits undefined / reserved.)

---

## 5. Flags Explained

- CF (Carry): Unsigned overflow; also used by rotations through carry.
- OF (Overflow): Signed overflow (e.g., adding two positives gives negative).
- ZF (Zero): Result equals zero.
- SF (Sign): Mirrors most significant bit of result (bit 15 in 16‑bit).
- PF (Parity): Even number of set bits in low 8 bits.
- AF (Aux Carry): BCD adjust operations (DAA/DAS/AAA/AAS/AAM/AAD).
- DF (Direction): Controls increment/decrement of SI/DI in string instructions.
- IF (Interrupt): 1 allows maskable hardware interrupts.
- TF (Trap): Enables single-step mode.

Flag testing via conditional jumps: e.g., `JC`, `JNC`, `JO`, `JNO`, `JS`, `JNS`, `JZ`, `JNZ`, `JP`, `JNP`, `JL`, `JLE`, `JG`, etc.

---

## 6. Addressing Modes

| Mode | Example | Meaning |
|------|---------|---------|
| Immediate | `MOV AX, 1234h` | Constant to register |
| Register | `MOV DX, AX` | Register ↔ register |
| Direct | `MOV AX, [1234h]` | From memory at offset in DS |
| Register Indirect | `MOV AL, [SI]` | DS:SI memory |
| Based | `MOV AX, [BP]` | SS:BP memory (unless override) |
| Indexed | `MOV AX, [DI]` | DS:DI |
| Based + Displacement | `MOV AX, [BP+6]` | Frame variable |
| Indexed + Displacement | `MOV AX, [SI+4]` | Array element |
| Based Indexed | `MOV AX, [BX+SI]` | Complex addressing |
| Based Indexed + Disp | `MOV AX, [BX+DI+8]` | Structure/array-of-struct |
| Segment Override | `MOV AL, ES:[DI]` | Use ES instead of default |
| Relative | `JMP SHORT label` | IP-relative control transfer |

Effective address components allowed: BX, BP, SI, DI in combinations.

---

## 7. Core Instruction Categories

### 7.1 Data Transfer
- MOV, XCHG
- PUSH / POP (also: PUSHF, POPF, PUSHA not on 8086, only 80186+)
- IN, OUT (port I/O)
- LEA (load effective address)
- LDS / LES (load pointer & segment)
- XLAT (table lookup)

### 7.2 Arithmetic
- ADD, ADC (add with carry)
- SUB, SBB (subtract with borrow)
- INC, DEC (do not affect CF)
- CMP (like SUB—flags only)
- NEG (two’s complement)
- MUL / IMUL (unsigned / signed multiply)
- DIV / IDIV (unsigned / signed divide)
- DAA, DAS (Decimal Adjust after ADD/SUB)
- AAA, AAS, AAM, AAD (ASCII adjust instructions—rarely used now)

### 7.3 Logical / Bit Manipulation
- AND, OR, XOR, NOT
- TEST (AND for flags only)
- SHL/SAL, SHR, SAR
- ROL, ROR, RCL, RCR

### 7.4 Control Transfer
- JMP (near, short, indirect)
- CALL / RET (near; far forms adjust CS:IP)
- INT n (software interrupt), INTO (interrupt on overflow)
- IRET (return from interrupt)
- Conditional Jumps: JE/JZ, JNE/JNZ, JC, JNC, JO, JNO, JS, JNS, JP/JPE, JNP/JPO, JL/JNGE, JLE/JNG, JG/JNLE, JGE/JNL
- LOOP, LOOPZ/LOOPE, LOOPNZ/LOOPNE (CX-based)

### 7.5 String Operations (Implicit SI/DI)
- MOVSB/MOVSW
- LODSB/LODSW
- STOSB/STOSW
- CMPSB/CMPSW
- SCASB/SCASW
Use REP, REPE/REPZ, REPNE/REPNZ prefixes.

### 7.6 Flag / Processor Control
- CLC, STC, CMC
- CLD, STD (clear/set direction)
- CLI, STI (clear/set interrupt enable)
- HLT (halt until interrupt)
- NOP (do nothing)
- WAIT (co-processor sync)

---

## 8. String & REP Instructions

| Base | Loads | Stores | Compare | Scan |
|------|-------|--------|---------|------|
| Byte | LODSB | STOSB | CMPSB | SCASB |
| Word | LODSW | STOSW | CMPSW | SCASW |

Prefixes:
- REP: Repeat while CX > 0 (unconditional)
- REPE / REPZ: Repeat while CX > 0 and ZF = 1
- REPNE / REPNZ: Repeat while CX > 0 and ZF = 0

Example:

```asm
CLD                 ; increment mode
MOV CX, length
MOV SI, offset src
MOV DI, offset dst
REP MOVSB           ; copy CX bytes from DS:SI to ES:DI
```

---

## 9. Interrupts & System Interface

- BIOS services: Via INT 10h (video), INT 13h (disk), INT 16h (keyboard)
- DOS services: INT 21h (functions in AH)
- Software interrupt pattern:

```asm
MOV AH, 09h         ; DOS print "$" terminated string
MOV DX, offset msg
INT 21h
```

Return to DOS:

```asm
MOV AH, 4Ch
MOV AL, 00h         ; return code
INT 21h
```

---

## 10. Directives & Pseudo‑Ops (Assembler dependent)

| Directive | Purpose |
|-----------|---------|
| ORG addr  | Set starting offset (e.g., `ORG 100h` for .COM) |
| DB, DW    | Define byte / word |
| EQU       | Constant symbolic binding |
| SEGMENT / ENDS | Define segment block |
| ASSUME    | Associate segment regs (MASM/TASM style) |
| PROC / ENDP | Procedure boundaries (MASM style) |
| END label | End of source / entry point label |
| TIMES n   | (NASM) Repeat following data/instruction n times |

Example:

```asm
ORG 100h          ; .COM program origin

msg db "Hello, world!$"

start:
    mov ah, 09h
    mov dx, msg
    int 21h

    mov ax, 4C00h
    int 21h
END start
```

---

## 11. Sample Programs

### 11.1 Hello World (.COM, NASM Syntax)

```asm
ORG 100h

section .text
    mov dx, msg
    mov ah, 09h
    int 21h

    mov ax, 4C00h
    int 21h

section .data
msg db "Hello 8086!", 13, 10, "$"
```

Assemble:

```bash
nasm -f bin hello.asm -o HELLO.COM
```

### 11.2 Input a Character and Echo Uppercase (Simplistic)

```asm
ORG 100h

start:
    mov ah, 01h       ; DOS: read char with echo
    int 21h
    ; AL has character
    cmp al, 'a'
    jb print
    cmp al, 'z'
    ja print
    sub al, 32        ; to uppercase

print:
    mov dl, al
    mov ah, 02h
    int 21h

    mov ax, 4C00h
    int 21h
```

### 11.3 Add Two Unsigned 16-bit Numbers From Memory

```asm
data1  dw 1234h
data2  dw 4321h
sum    dw 0

ORG 100h

start:
    mov ax, [data1]
    add ax, [data2]
    mov [sum], ax

    mov ax, 4C00h
    int 21h
```

---

## 12. Optimization & Tips

- Use `LEA` instead of complex ADD/MOV for effective address loads.
- Prefer register operations before memory writes (memory accesses are slower).
- Avoid unnecessary `PUSH`/`POP` pairs.
- Use `XCHG AX, reg` sparingly (it has implicit encoding advantages only in some cases).
- For clearing a register: `XOR AX, AX` is shorter/faster than `MOV AX, 0`.

---

## 13. Common Pitfalls

| Pitfall | Explanation / Fix |
|---------|--------------------|
| Forgetting `ORG 100h` for .COM | First 256 bytes reserved for PSP in DOS |
| Using BP without SS assumption | Default segment for `[BP]` is SS, not DS |
| Direction flag left set | Always `CLD` before string ops unless deliberate |
| Incorrect segment override | Remember MOV affects only offset register, not segment |
| Divide overflow | Ensure dividend fits (e.g., for 16-bit DIV, DX:AX / r/m16) |
| Using 32-bit instructions accidentally | 8086 has no 32-bit ops; stick to 8/16-bit |

---

## 14. Further Reading / References

- Intel 8086/8088 Programmer’s Reference Manual (Original PDFs)
- [PC DOS / MS-DOS Function List (INT 21h)](http://www.ctyme.com/intr/rb-2554.htm)
- Ralf Brown’s Interrupt List
- emu8086 built-in tutorials
- NASM Manual (syntax differences vs MASM)

---

## 15. License

Add a license (e.g., MIT) if you intend others to reuse code. Example:

```
MIT License © 2025 Your Name
```

---

## Quick Register & Instruction Cheat Sheet

General Purpose: AX BX CX DX  
Segment: CS DS SS ES  
Pointer/Index: SP BP SI DI IP  
Flags: CF PF AF ZF SF TF IF DF OF

Arithmetic: ADD SUB ADC SBB INC DEC MUL IMUL DIV IDIV  
Logic: AND OR XOR NOT TEST SHL SHR SAR ROL ROR RCL RCR  
Data: MOV XCHG LEA LDS LES PUSH POP IN OUT  
Control: JMP CALL RET INT IRET Jcc LOOP  
String: MOVS LODS STOS CMPS SCAS + REP/REPE/REPNE  
Flag Control: CLC STC CMC CLD STD CLI STI HLT NOP

---

## Contributing

1. Fork the repository
2. Create a branch: feature/new-example
3. Add well-commented `.asm` file
4. Open a Pull Request describing:
   - Purpose
   - Execution environment (emu8086, NASM+DOSBox)
   - Sample output

---

Feel free to extend this README with repository-specific folders and example descriptions once code files are added.

Happy hacking in 16 bits!
