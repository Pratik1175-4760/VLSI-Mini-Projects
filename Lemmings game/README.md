# 🧠 Lemming FSM Controller (Verilog)

This project is a digital clone of the **classic 90s Lemmings game** 👾 — where tiny creatures mindlessly walk until they hit something, fall into doom, or dig through ground. Your job? Build an FSM that keeps this Lemming alive and acting smart in a dumb world. 😅

---

## 🎮 What’s the Game?

In **Lemmings**, these cute but clueless dudes walk left or right until:
- They hit a wall and turn around
- There's no ground and they fall ☠️
- You tell them to dig down ⛏️

This FSM mimics that exact behavior — in hardware 🔩.

---

## ⚙️ Features

- Walks 🚶 left or right
- Falls when no ground 😱
- Digs when you say so ⛏️
- Bumps and turns 🔁
- Ignores dig/bump when falling

---

## 🧠 Inputs / Outputs

| Signal        | Direction | Meaning                        |
|---------------|-----------|--------------------------------|
| `clk`         | In        | System clock                   |
| `reset`       | In        | Resets FSM to start (left)     |
| `ground`      | In        | Is Lemming on ground?          |
| `dig`         | In        | Tell Lemming to dig            |
| `bump_left`   | In        | Wall on the left?              |
| `bump_right`  | In        | Wall on the right?             |
| `walk_left`   | Out       | Walking left                   |
| `walk_right`  | Out       | Walking right                  |
| `aaah`        | Out       | Falling scream 💀              |
| `digging`     | Out       | Digging animation              |

---

## 🔁 State Machine (Simplified)

```text
LEFT  --bump-->  RIGHT
LEFT  --dig-->   DIG_L
LEFT  --fall-->  FALL_L

RIGHT --bump-->  LEFT
RIGHT --dig-->   DIG_R
RIGHT --fall-->  FALL_R

DIG_L / DIG_R --no ground--> FALL_L / FALL_R
FALL_L / FALL_R --land--> LEFT / RIGHT
```

---

## 🧪 Vivado Testbench

Includes scenarios for:
- Turning on bumps
- Falling off cliffs
- Digging only on ground
- Ignoring bump/dig while falling

---

## 🧠 Code Summary

- Enum-style FSM with 6 states: `LEFT`, `RIGHT`, `DIG_L`, `DIG_R`, `FALL_L`, `FALL_R`
- One `always_ff` block for state update on clock
- One `always_comb` block for state logic and outputs
- Outputs set based on state, then transition logic applied

---

## 🛠 Built Using

- ✅ **Vivado** (no third-party sim tools)
- ✅ **Verilog-2001** (HDL standard)

---

> 🧠 FSMs aren't just logic — they’re brain cells for your hardware.
