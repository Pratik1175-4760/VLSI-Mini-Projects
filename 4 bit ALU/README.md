# 🔢 4-bit ALU (Arithmetic Logic Unit) — Verilog

This is a basic 4-bit ALU designed in Verilog, capable of performing both **arithmetic** and **logic** operations. It also generates essential **status flags** such as carry, overflow, zero, sign, and parity.

> ⚠️ Note: This is a **beginner-level design** focused on understanding ALU fundamentals. It's not optimized for synthesis or hardware implementation yet.

---

## 📘 Features

- **Inputs**:
  - `a [3:0]` – 4-bit signed input
  - `b [3:0]` – 4-bit signed input
  - `select [2:0]` – Operation selector
- **Outputs**:
  - `out [3:0]` – 4-bit result
  - `carry` – Unsigned overflow (carry-out)
  - `overflow` – Signed overflow
  - `zero` – Result is zero
  - `sign` – Sign bit of result
  - `parity` – Even parity of result

---

## 🔁 Supported Operations

| `select` | Operation       | Notes                                      |
|----------|------------------|---------------------------------------------|
| `000`    | Addition         | Signed/Unsigned, sets carry & overflow      |
| `001`    | Subtraction      | Sets borrow (as carry), overflow            |
| `010`    | Multiplication   | Only LSB stored, checks overflow/carry      |
| `011`    | Division         | Detects divide-by-zero and signed overflow  |
| `100`    | Bitwise AND      | `out = a & b`                               |
| `101`    | Bitwise OR       | `out = a | b`                               |
| `110`    | Bitwise XOR      | `out = a ^ b`                               |
| `111`    | Bitwise NOT      | `out = ~a` (only `a` is used)               |

---

## 🧪 Simulation Overview

The testbench (`alu_tb.v`) covers:

- Signed/unsigned overflow cases
- Negative result handling
- All logic operations
- Edge cases like division by zero


---

## 📚 Learning Goals

This project is meant to help beginners:
- Understand arithmetic and logical ops in Verilog
- Implement and test combinational logic
- Handle signed and unsigned data properly
- Detect and handle overflow, carry, and edge cases
- Practice writing a complete testbench

---

## 🚀 Tools Used

- **Vivado (For simulation and waveform generation)**
- **Verilog (IEEE 1364)** – Hardware description language

---

## 📌 Limitations
- No pipelining or clocked logic (pure combinational)
- Only 4-bit result shown from multiply/divide
- No division remainder
- NOT operation is unary on `a` only

---

## 🛠️ Future Improvements

- Extend to 8-bit or 16-bit ALU
- Add support for shift and rotate operations
- Include remainder output for division
- Synthesize and test on FPGA board
- Add test automation for coverage

---

> “Master the fundamentals. Rest will follow automatically.”


