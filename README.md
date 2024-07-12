**NAME** : SATHISH SARAVANAMUTHU

**COMPANY** : CODTECH IT SOLUTIONS

**ID** : CT08DS2462

**DOMAIN** : VLSI

**DURATION** : JUNE TO JULY 2024

**MENTOR** : NEELA SANTHOSH KUMAR


### Project Overview

#### UART (UNIVERSAL ASYNCHRONOUS RECEIVERTRANSMITTER) DESIGN

This project implements a UART (Universal Asynchronous Receiver/Transmitter) module in Verilog. It includes modules for both transmitter and receiver, along with a comprehensive testbench for simulation.

## Key Features

- **uart_tx.v**: Verilog module for UART transmitter.
  - Asynchronously transmits data with configurable baud rate and clock frequency.
  
- **uart_rx.v**: Verilog module for UART receiver.
  - Asynchronously receives data and outputs received data with reception completion flag.

- **uart_tb.v**: Verilog testbench for UART module simulation.
  - Validates functionality of UART transmitter and receiver.
  - Sets initial conditions, transmits data, and verifies received data for correctness.

## Simulation Instructions

### Setup

1. Clone or download the repository to your local machine.
2. Ensure you have a compatible Verilog simulation tool (e.g., ModelSim, Vivado, Quartus).

### Simulation

1. Compile all Verilog files (`uart_tx.v`, `uart_rx.v`, `uart_tb.v`) in your simulation tool.
2. Set `uart_tb` as the top-level module and run the simulation.
3. Monitor waveforms and examine simulation logs to verify UART functionality.

### Verification

- Check simulation results to ensure that transmitted and received data align with expected values.
- Validate timing and signal integrity to confirm correct operation of the UART module.

## Project Structure

- **rtl/**
  - Contains Verilog source files (`uart_tx.v`, `uart_rx.v`) for transmitter and receiver.
- **sim/**
  - Includes Verilog testbench (`uart_tb.v`) and simulation scripts.
- **docs/**
  - Documentation files, including this README.md.
 
## OUTPUT
![image](https://github.com/user-attachments/assets/ad48c49e-f5af-42e0-bd71-59846bd87848)


