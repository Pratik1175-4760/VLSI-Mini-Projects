# 🚦 Basic Traffic Light Controller (Verilog)

This project implements a simple traffic light controller using Verilog HDL. It models a finite state machine (FSM) that cycles through **Green → Yellow → Red** lights based on clock cycles.

> ⚠️ **Note**: This is a beginner-level design, kept minimal on purpose to focus on state transitions and sequential logic concepts in Verilog.

---

## 🧠 Functionality Overview

The traffic light cycles through three states:
- **GREEN** (light = `3'b001`) → **YELLOW** (light = `3'b010`) → **RED** (light = `3'b100`), then back to GREEN.
- State transitions occur after fixed clock cycle durations.

### ⏱ Timing Parameters
| State   | Duration (in clock cycles) |
|---------|-----------------------------|
| GREEN   | 25 cycles                   |
| YELLOW  | 4 cycles                    |
| RED     | 30 cycles                   |

---

## 🔧 Module Description

### `traffic_light` Module

| Port   | Direction | Description                          |
|--------|-----------|--------------------------------------|
| `clk`  | Input     | System clock (e.g., 50 MHz simulated) |
| `reset`| Input     | Active-high synchronous reset         |
| `light`| Output    | 3-bit output indicating current light (RED, YELLOW, GREEN)

### Output Encoding
- `light[2]` = RED
- `light[1]` = YELLOW
- `light[0]` = GREEN

---

## 🔍 Simulation Results

<img width="862" height="496" alt="image" src="https://github.com/user-attachments/assets/e04f5e1c-1562-4429-8732-b2ff5f5b0d1c" />


- At `t = 0`, `reset` is high. The system initializes to **GREEN**.
- At ~`250 ns`, it transitions to **YELLOW**.
- At ~`290 ns`, it moves to **RED**.
- Around `t = 440 ns`, the cycle restarts with **GREEN**.

This waveform confirms the FSM is cycling correctly through all three states as per design.

---

## 🧪 Testbench Description

### Clock:
- Period: 10 ns (toggled every 5 ns)

### Reset:
- Asserted for the first 10 ns to initialize the system

### Simulation Duration:
- 500 ns (enough to observe one full traffic cycle)

---


---

## 🚧 Future Improvements (Planned)
- Pedestrian crossing input
- Configurable timing using parameters or switches
- 7-segment timer display integration
- FSM diagram generation
- RTL and Gate-level synthesis

---

## 📢 Notes
- This is a **basic FSM project** aimed at beginners in Verilog.
- No debounce, enable, or clock division logic has been added.
- Ideal for understanding sequential logic, FSM implementation, and simulation in Verilog.

---

## 🛠 Tools Used
- **Vivado(for simulation and waveform)**
- **Verilog** (IEEE 1364)

> “Build simple, understand deep.”

