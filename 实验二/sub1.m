%% 实验内容一：单一频率信号 DFT (泄漏与整周期截断)
clear; clc; close all;

% 参数定义
f = 100;            % 信号频率 100Hz
Fs = 8 * f;         % 采样频率 800Hz
T = 1 / Fs;         % 采样间隔

% --- ① 绘制 10 个周期的时域模拟信号 ---
% 为了看起来像"连续/模拟"信号，使用很小的步长绘图
t_analog = 0 : 0.0001 : 10*(1/f);
x_analog = sin(2*pi*f*t_analog);

figure('Name', '实验一：单一频率信号');
subplot(3,1,1);
plot(t_analog, x_analog);
title('100Hz 连续信号波形 (10个周期)');
xlabel('t/s'); ylabel('幅度');
grid on;

% --- ② N=16 (整周期截断) 和 N=20 (非整周期截断) 对比 ---
N_values = [16, 20];

for i = 1:length(N_values)
    N = N_values(i);
    n = 0:N-1;
    xn = sin(2*pi*f/Fs*n); % 离散采样
    
    % 计算 DFT (FFT)
    Xk = fft(xn, N);
    
    % 频率轴计算 (使用 fftshift 将零频移到中心)
    f_axis = (-N/2 : N/2-1) * (Fs/N);
    Xk_shift = fftshift(Xk);
    
    % 绘图
    subplot(3, 2, 2*i+1);
    stem(n, xn, 'filled');
    title(['离散信号 (N=' num2str(N) ')']);
    xlabel('n'); ylabel('幅度'); grid on;
    
    subplot(3, 2, 2*i+2);
    stem(f_axis, abs(Xk_shift), 'filled');
    title(['幅度谱 (N=' num2str(N) ')']);
    xlabel('频率/Hz'); ylabel('幅度'); grid on;
    % 标注说明
    if N==16
        text(0, max(abs(Xk_shift))*0.8, '无泄漏', 'Color', 'r', 'HorizontalAlignment', 'center');
    else
        text(0, max(abs(Xk_shift))*0.8, '有频谱泄漏', 'Color', 'r', 'HorizontalAlignment', 'center');
    end
end