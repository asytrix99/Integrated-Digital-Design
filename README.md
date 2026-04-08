# FP8 Adder Design & CMOS Characterization (EE4415)
# [FP8 Adder Design: Project Link](https://docs.google.com/document/d/1j5Em5DMRkhHdtFFg1FSJavrnN78bd-we7Lo8ZnCGIF4/edit?tab=t.0#heading=h.10pd3q3lqsui)
# [CMOS Characterization: Project Link](https://docs.google.com/document/d/1Iqqsh-52q-gNjQFsKYfF-DmyKTG7gHlCscdHGcIPiLc/edit?tab=t.0)
# [6T SRAM Bitcell Analysis: Project Link](https://docs.google.com/document/d/1Nurh1H6hgguYYYuR4lYYvtk0-4Kf5-wo9NFIXETXrC4/edit?tab=t.0)

## Overview
This project explores both **digital IC design** and **analog CMOS characterization** through:
1. A pipelined FP8 (E4M3) floating-point adder
2. Transistor- and circuit-level simulations using Cadence Virtuoso
3. 6T SRAM bitcell analysis using Cadence Virtuoso

The goal is to understand **performance trade-offs across abstraction levels** - from MOSFET physics to RTL architecture.

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
- Explored timing closure by reducing the clock period
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
---

## Cadence Virtuoso (Analog IC)

### MOSFET Characterization
- Simulated NMOS and PMOS (W = 1µm, L = 50nm)
- Plotted ID–VDS characteristics across multiple VDD
- Determined effective ON resistance using the two-endpoint method
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

## SRAM Bitcell Analysis

### Setup
Designed and simulated a 6T SRAM cell using FreePDK45 (Cadence Virtuoso)
- Transistor sizing:
- Pull-up (PMOS): 200 nm
- Pull-down (NMOS): 400 nm
- Access (NMOS): 200 nm
- Supply voltage: VDD = 1.2 V
- Static Noise Margin (SNM) Analysis

Performed DC sweep simulations to generate butterfly curves for different operating modes:
- Hold SNM
Condition: VWL = 0, BL = BLB = VDD
- Read SNM
Condition: VWL = VDD, BL = BLB = VDD
- Write SNM
Condition: BL = VDD, BLB = 0

Methodology:
-Plotted VQB vs VQ characteristics for both cross-coupled inverters
-Extracted SNM by fitting the largest square within the butterfly curve
-Compared stability across operating conditions

### Key Observations
- Hold SNM > Read SNM > Write SNM
- Read operation reduces stability due to access transistor contention
- Write margin is limited by the ability to flip the cross-coupled inverter state
