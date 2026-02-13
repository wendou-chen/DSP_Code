%% IIR 内容 2: 滤波器应用
clear; clc; close all;

% 1. 信号参数
f1 = 0.08; 
f2 = 0.2; 
f3 = 0.36;
Fs = 1;         % 采样频率 1Hz
N = 1500;       % 数据点数
n = 0 : N-1;    % 时间序列

% 2. 生成输入信号
xn = sin(2*pi*f1*n) + sin(2*pi*f2*n) - cos(2*pi*f3*n);

% 3. 设计 IIR 低通滤波器 (保留 f1, 滤除 f2, f3)
% 通带截止 fp 取 0.1, 阻带截止 fs 取 0.17 (处于 f1 和 f2 之间)
fp = 0.1; fs_stop = 0.17; 
Rp = 1; As = 40;

% 计算阶数和截止频率 (Buttord需要归一化频率: f/(Fs/2))
% 注意：buttord 如果不加 's' 直接输入归一化数字频率
Wp = fp / (Fs/2); 
Ws = fs_stop / (Fs/2);
[n_order, wn] = buttord(Wp, Ws, Rp, As); 

% 设计数字滤波器
[b, a] = butter(n_order, wn);

% 4. 信号滤波
yn = filter(b, a, xn);

% 5. 绘制时域波形对比
figure('Name', 'IIR 应用 - 时域波形');
subplot(2,1,1); plot(n, xn); title('滤波前信号 x(n)'); axis([0 200 -3 3]); grid on;
subplot(2,1,2); plot(n, yn, 'r'); title('滤波后信号 y(n)'); axis([0 200 -3 3]); grid on;

% 6. 频谱分析 (补全代码部分)
figure('Name', 'IIR 应用 - 频谱对比');

% --- 绘制滤波前频谱 ---
Xk = fft(xn, N);
magX = abs(Xk);
magX_uni = magX(1 : N/2+1);       % 单边谱
magX_uni(2:end-1) = 2*magX_uni(2:end-1) / N; % 幅度修正
magX_uni(1) = magX_uni(1)/N;
magX_uni(end) = magX_uni(end)/N;

f_axis = (0 : N/2) * Fs / N;      % 频率轴

subplot(2,1,1);
plot(f_axis, magX_uni, 'b');
title('滤波前信号频谱'); xlabel('频率/Hz'); ylabel('幅度'); grid on;
% 标记频率点
text(f1, max(magX_uni), '\leftarrow f1 (0.08)');
text(f2, max(magX_uni), '\leftarrow f2 (0.2)');

% --- 绘制滤波后频谱 ---
Yk = fft(yn, N);
magY = abs(Yk);
magY_uni = magY(1 : N/2+1);       
magY_uni(2:end-1) = 2*magY_uni(2:end-1) / N; 
magY_uni(1) = magY_uni(1)/N;
magY_uni(end) = magY_uni(end)/N;

subplot(2,1,2);
plot(f_axis, magY_uni, 'r');
title('滤波后信号频谱 (IIR Lowpass)'); xlabel('频率/Hz'); ylabel('幅度'); grid on;
text(f1, max(magY_uni), '\leftarrow f1 保留');
text(f2, 0, '\leftarrow f2 滤除');