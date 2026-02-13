%% IIR 内容 1: 滤波器设计基础
clear; close all; clc;

% --- ① 三阶巴特沃斯低通 (脉冲响应不变法 vs 双线性变换法) ---
disp('任务1：三阶巴特沃斯低通');
Fs = 4000; 
fc = 1000;
% 模拟原型设计
[b, a] = butter(3, 2*pi*fc, 's'); 

% 方法A: 脉冲响应不变法
[Bz1, Az1] = impinvar(b, a, Fs);
% 方法B: 双线性变换法
[Bz2, Az2] = bilinear(b, a, Fs);

% 绘图对比
[h1, w] = freqz(Bz1, Az1, 512);
[h2, w] = freqz(Bz2, Az2, 512);
f_axis = w * Fs / (2*pi);

figure(1);
plot(f_axis, 20*log10(abs(h1)), 'b', 'LineWidth', 1.5); hold on;
plot(f_axis, 20*log10(abs(h2)), 'r--', 'LineWidth', 1.5);
legend('脉冲响应不变法', '双线性变换法');
title('三阶巴特沃斯低通滤波器对比');
xlabel('频率/Hz'); ylabel('幅度/dB'); grid on;


% --- ② 数字高通滤波器 (双线性变换法) ---
disp('任务2：数字高通滤波器');
Fs2 = 1000; 
Rp = 1; As = 20; % 题目要求: 通带波动1dB(示例代码给0.5), 阻带衰减20dB
fp = 400; fs_stop = 320;

% 频率预畸变 (Pre-warping)
Wp = 2*Fs2*tan(2*pi*fp/(2*Fs2));
Ws = 2*Fs2*tan(2*pi*fs_stop/(2*Fs2));

% 计算阶数和截止频率
[N, Wn] = cheb1ord(Wp, Ws, Rp, As, 's');
[b_hp, a_hp] = cheby1(N, Rp, Wn, 'high', 's');

% 双线性变换
[Bz_hp, Az_hp] = bilinear(b_hp, a_hp, Fs2);
[h_hp, w_hp] = freqz(Bz_hp, Az_hp, 512);

figure(2);
plot(w_hp*Fs2/(2*pi), 20*log10(abs(h_hp)));
title('双线性变换-高通滤波器');
xlabel('频率/Hz'); ylabel('幅度/dB'); grid on;


% --- ③ 数字带通滤波器 (保留 2025-2225Hz) ---
disp('任务3：数字带通滤波器');
Fs3 = 8000;
f_pass = [2025 2225];
f_stop = [1500 2700];
Rp = 1; As = 40;

Wp3 = 2*Fs3*tan(pi*f_pass/Fs3);
Ws3 = 2*Fs3*tan(pi*f_stop/Fs3);

[N3, Wn3] = buttord(Wp3, Ws3, Rp, As, 's');
[b_bp, a_bp] = butter(N3, Wn3, 's');
[Bz_bp, Az_bp] = bilinear(b_bp, a_bp, Fs3);

figure(3); % <--- 加上这一行，创建一个新的图窗
freqz(Bz_bp, Az_bp); 
title('带通滤波器幅频响应');


% --- ④ 一阶陷波/带阻滤波器 (去除100Hz) ---
% 题目比较特殊，要求直设一阶，截止频率95和105
% 注：标准带阻至少需要2阶才能构成notch，这里尝试满足题目要求的参数设计
Fs4 = 1000;
f_c = [95 105];
Wn4 = f_c / (Fs4/2); % 归一化
[b_bs, a_bs] = butter(1, Wn4, 'stop'); 
figure(4); freqz(b_bs, a_bs); title('一阶带阻滤波器');