%% 实验内容二：DTMF 信号"8"分析 (补零与分辨率)
clear; clc; close all;

f1 = 852;       % DTMF "8" 低频
f2 = 1336;      % DTMF "8" 高频
Fs = 8000;      % 采样率 8000Hz

% --- 情况(1): 数据长 n=10, FFT点数 N=10 ---
n_len1 = 10;
N_fft1 = 10;
n1 = 0 : n_len1-1;
xn1 = sin(2*pi*f1/Fs*n1) + sin(2*pi*f2/Fs*n1);

Xk1 = fft(xn1, N_fft1);
f_axis1 = (-N_fft1/2 : N_fft1/2-1) * (Fs/N_fft1);
Xk1_shift = fftshift(Xk1);

figure('Name', '实验二：DTMF信号分析');
subplot(3,2,1); stem(n1, xn1, 'filled'); title('原始数据 n=10'); xlabel('n'); grid on;
subplot(3,2,2); stem(f_axis1, abs(Xk1_shift), 'filled'); 
title(['N=10 幅度谱 (分辨率=' num2str(Fs/N_fft1) 'Hz)']); xlabel('Hz'); grid on;

% --- 情况(2): 数据长 n=10, 补90个零 -> N=100 ---
% 注意：补零增加了谱线密度，被称为"高密度频谱"，但没有增加有效信息长度
xn2 = [xn1, zeros(1, 90)]; % 补零
N_fft2 = 100;
n2 = 0 : N_fft2-1;

Xk2 = fft(xn2, N_fft2);
f_axis2 = (-N_fft2/2 : N_fft2/2-1) * (Fs/N_fft2);
Xk2_shift = fftshift(Xk2);

subplot(3,2,3); stem(n2, xn2, 'filled'); title('数据 n=10, 补零至 100'); xlabel('n'); grid on;
subplot(3,2,4); plot(f_axis2, abs(Xk2_shift), '.-'); % 使用 plot 连线看包络更清晰
title('N=100 (高密度频谱)'); xlabel('Hz'); grid on;
text(-2000, 4, '两个峰分不开', 'Color', 'r');

% --- 情况(3): 数据长 n=1000, N=1000 (真实高分辨率) ---
n_len3 = 1000;
N_fft3 = 1000;
n3 = 0 : n_len3-1;
xn3 = sin(2*pi*f1/Fs*n3) + sin(2*pi*f2/Fs*n3);

Xk3 = fft(xn3, N_fft3);
f_axis3 = (-N_fft3/2 : N_fft3/2-1) * (Fs/N_fft3);
Xk3_shift = fftshift(Xk3);

subplot(3,2,5); plot(n3, xn3); title('数据 n=1000'); xlim([0 100]); xlabel('n (局部)'); grid on;
subplot(3,2,6); plot(f_axis3, abs(Xk3_shift)); 
title(['N=1000 (高分辨率频谱)']); xlabel('Hz'); xlim([-2000 2000]); grid on;
text(852, max(abs(Xk3_shift)), '\leftarrow 852Hz');
text(1336, max(abs(Xk3_shift)), '\leftarrow 1336Hz');