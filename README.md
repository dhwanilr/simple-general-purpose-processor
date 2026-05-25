# 8-bit General-Purpose Processor (VHDL FPGA Design)

## Overview
This project implements an **8-bit General-Purpose Processor Unit (GPU)** designed in **VHDL** using the **Intel Quartus II** environment. The system follows a classical digital processor architecture consisting of:

- Register-based storage unit
- Finite State Machine (FSM) control unit
- Hierarchical decoder (4-to-16 via 3-to-8 blocks)
- Arithmetic Logic Unit (ALU)
- Seven-segment display interface

The final design is synthesized and deployed on an **Altera FPGA board**, with outputs visualized through onboard HEX displays.

---

## System Architecture

The processor is composed of four main hardware blocks:

### 1. Storage Unit (Registers)
- Two 8-bit registers (`latch1`)
- Captures input buses **A** and **B** on rising clock edge
- Provides stable operands to the ALU

### 2. Control Unit (FSM)
- Finite State Machine acting as an **up-counter (0-8 cycle)**
- Outputs a **4-bit state signal**
- Drives system sequencing and operation selection
- Includes seven-segment output for state/ID display

### 3. Control Unit (Decoder)
- **4×16 decoder** built structurally from **3×8 decoder blocks**
- Converts FSM state into a **one-hot 16-bit microcode signal (OP)**
- Enables selection of ALU operations

### 4. ALU Core
- Executes arithmetic, logic, and bitwise operations
- Inputs: `A (8-bit)`, `B (8-bit)`, `OP (16-bit)`
- Outputs result + status flags (e.g., negative/overflow)

---

## ALU Operations 

The ALU supports 9 microcoded operations:

| Function | Microcode | Operation |
|----------|-----------|-----------|
| 1 | `0000000000000001` | Addition `A + B` |
| 2 | `0000000000000010` | Subtraction `A - B` |
| 3 | `0000000000000100` | Bitwise NOT `¬A` |
| 4 | `0000000000001000` | NAND |
| 5 | `0000000000010000` | NOR |
| 6 | `0000000000100000` | AND |
| 7 | `0000000001000000` | OR |
| 8 | `0000000010000000` | XOR |
| 9 | `0000000100000000` | XNOR |
