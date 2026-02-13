# DSP_Code — 数字信号处理实验

本仓库收录大学《数字信号处理》课程的 MATLAB 实验代码。

## 目录结构

```
├── 实验二/          DFT/FFT 基础实验
│   ├── sub1.m      单一频率信号 DFT（频谱泄漏 vs 整周期截断）
│   ├── sub2.m      DTMF 信号"8"分析（补零与真实分辨率对比）
│   └── sub3.m      太阳黑子活动周期的 FFT 分析
├── 实验三/          数字滤波器设计与应用
│   ├── sub1.m      IIR 滤波器设计（Butterworth / Chebyshev，脉冲响应不变法 / 双线性变换法）
│   ├── sub2.m      IIR 低通滤波器应用（多频信号滤波）
│   └── sub3.m      FIR 滤波器设计（Kaiser 窗）与应用
└── 杂话/            杂项脚本
```

## 环境要求

- **MATLAB**（建议 R2020a 及以上）
- **Signal Processing Toolbox**（`butter`、`cheby1`、`freqz`、`impinvar`、`bilinear`、`fir1`、`kaiser` 等函数依赖此工具箱）

## 使用方法

每个 `sub*.m` 文件都是独立脚本，脚本开头已包含 `clear; clc; close all;`，可直接运行：

```matlab
% 方式一：命令行
run('实验二/sub1.m')

% 方式二：在 MATLAB 编辑器中打开文件，按 F5 运行
```

## 实验内容简介

### 实验二 — DFT/FFT 基础

| 脚本 | 内容 |
|------|------|
| `sub1.m` | 100Hz 正弦信号采样，对比 N=16（整周期截断，无泄漏）与 N=20（非整周期截断，有泄漏） |
| `sub2.m` | DTMF "8" 双音信号（852Hz + 1336Hz），对比 N=10、补零至 N=100、N=1000 三种情况下的频谱分辨率 |
| `sub3.m` | 读取太阳黑子历史数据，通过 FFT 分析其约 11 年的活动周期 |

### 实验三 — 数字滤波器

| 脚本 | 内容 |
|------|------|
| `sub1.m` | 三阶 Butterworth 低通（脉冲响应不变法 vs 双线性变换法）、Chebyshev 高通、Butterworth 带通、一阶带阻 |
| `sub2.m` | 设计 Butterworth 低通滤波器，从三频混合信号中提取 0.08Hz 分量，展示时域与频域对比 |
| `sub3.m` | Kaiser 窗 FIR 低通设计，使用 `fdatool` 导出系数进行滤波，含自定义频谱计算函数 |

## License

本项目仅用于学习与课程实验目的。
