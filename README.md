# FP8 Adder Design & CMOS Characterization (EE4415)
# [Project Link](https://docs.google.com/document/d/1Iqqsh-52q-gNjQFsKYfF-DmyKTG7gHlCscdHGcIPiLc/edit?tab=t.0#heading=h.qdf1624piuu4)

## Overview
This project explores both **digital IC design** and **analog CMOS characterization** through:
1. A pipelined FP8 (E4M3) floating-point adder
2. Transistor- and circuit-level simulations using Cadence Virtuoso

The goal is to understand **performance trade-offs across abstraction levels** — from MOSFET physics to RTL architecture.

---

## FP8 Adder (RTL + Synthesis)

### Description
Designed a low-precision FP8 adder based on the E4M3 format:
- 1 sign bit
- 4 exponent bits
- 3 mantissa bits

### Features
- Multi-stage pipeline implementations:
  - 3-stage (baseline)
  - 4-stage (repipelined)
  - 5-stage (deep pipeline)
- Key operations:
  - Operand alignment
  - Exponent comparison and shifting
  - Addition
  - Normalization and rounding

### Verification
- Passed all **256 test cases**
- Waveform validation using DVE

### Synthesis
- Timing constraints applied (1.5 ns clock)
- Explored timing closure by reducing clock period
- Identified **critical paths and bottlenecks**
- Evaluated:
  - Throughput improvement
  - Area overhead
  - Pipeline efficiency

### Files
- `3_stage.v`, `3_stage_improved.v`, `4_stage.v`, `5_stage.v` – RTL implementation
- `tb_FP8_ADDER.v` - sample testbench (for 3-stage)
- `constraints.tcl` – constraints file
- `run.tcl` - run script
- 
---

## Cadence Virtuoso (Analog IC)
# [Project Link](https://docs.google.com/document/d/1Iqqsh-52q-gNjQFsKYfF-DmyKTG7gHlCscdHGcIPiLc/edit?tab=t.0)

### MOSFET Characterization
- Simulated NMOS and PMOS (W = 1µm, L = 50nm)
- Plotted ID–VDS characteristics across multiple VDD
- Determined effective ON resistance using two-endpoint method
- Analyzed short-channel behavior

### CMOS Inverter Design
- Sized inverter for switching threshold ≈ VDD/2
- Extracted:
  - VTC curve
  - Noise margins (VIL, VIH, VOL, VOH)
  - Supply current vs input voltage

### Transient Analysis
- Measured propagation delays (tpHL, tpLH)
- Studied delay vs capacitive load
- Estimated intrinsic capacitance

### Inverter Chain Optimization
- Modeled multi-stage inverter chains
- Analyzed rise/fall time matching
- Explored fanout and load scaling effects

### Power Analysis
- Estimated:
  - Switching power
  - Short-circuit power
  - Leakage power

---

## Key Learnings
- Trade-offs between **pipeline depth, area, and throughput**
- Relationship between **device physics and digital timing**
- Practical experience with:
  - RTL design (Verilog)
  - Simulation (VCS, DVE)
  - Synthesis (Design Compiler)
  - Analog simulation (Cadence Virtuoso)

---

## Notes
- Simulation netlists and outputs from Cadence Virtuoso are included in the report appendix
- FreePDK45 models were used for all simulations
