# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Digital Signal Processing (DSP) lab project** implemented in MATLAB. It contains experimental code for a university-level DSP course, organized by lab sessions (实验). All code is written in MATLAB `.m` script files with Chinese comments.

## Repository Structure

- `实验二/` — Lab 2: DFT/FFT fundamentals
  - `sub1.m` — Single-frequency DFT analysis (spectral leakage vs. periodic truncation)
  - `sub2.m` — DTMF signal "8" analysis (zero-padding vs. true resolution)
  - `sub3.m` — Sunspot activity period analysis using FFT
- `实验三/` — Lab 3: Digital filter design and application
  - `sub1.m` — IIR filter design (Butterworth, Chebyshev; impulse invariance vs. bilinear transform; lowpass/highpass/bandpass/bandstop)
  - `sub2.m` — IIR filter application (Butterworth lowpass filtering a multi-tone signal)
  - `sub3.m` — FIR filter design (Kaiser window) and application with `fdatool`-exported coefficients
- `杂话/` — Miscellaneous/scratch scripts

## How to Run

Each `sub*.m` file is a standalone MATLAB script. Run directly in MATLAB:

```matlab
run('实验二/sub1.m')
```

Or open in MATLAB and press F5. Each script begins with `clear; clc; close all;` so they are self-contained.

## Key Conventions

- **Language**: Comments, titles, labels, and figure annotations are in Chinese.
- **Naming**: Sub-experiments within a lab are named `sub1.m`, `sub2.m`, `sub3.m`.
- **Plotting**: Every script produces `figure` windows with `subplot` layouts. Titles use descriptive Chinese text. Grid is always enabled.
- **Frequency axis**: Scripts use `fftshift` for centered spectra or manual half-spectrum extraction. Frequency axes are labeled in Hz (not normalized) unless the context is purely digital.
- **Filter design workflow**: Analog prototype → frequency pre-warping → `bilinear` or `impinvar` → `freqz` for verification. Direct digital design uses `butter`/`cheby1` with normalized frequencies.
- **External data**: `实验二/sub3.m` references an external CSV file (`yearssn.csv`) with a fallback to generate simulated data if the file is missing.

## MATLAB Toolbox Dependencies

- Signal Processing Toolbox (required for `butter`, `cheby1`, `freqz`, `impinvar`, `bilinear`, `fir1`, `kaiser`, `buttord`, `cheb1ord`)

## Git Remote

- Origin: `git@github.com:wendou-chen/DSP_Code.git` (SSH)
