%% 实验内容三：太阳黑子活动分析
clear; clc; close all;

% 尝试读取文件，如果文件不存在，生成一个模拟文件供演示使用
filename = "D:\a大学实验\数字信号处理实验\语音文件和太阳黑子数据\yearssn.csv";
if ~exist(filename, 'file')
    warning('未找到 yearssn.csv，正在生成模拟数据用于演示...');
    % 生成模拟数据：年份 1700-2014，主要周期 11年，次要干扰
    sim_year = 1700:2014;
    sim_data = 100 + 80*sin(2*pi*(1/11)*sim_year) + 20*rand(size(sim_year)); 
    % 保存为 csv 格式，以便后面读取代码能通运行
    fid = fopen(filename, 'w');
    for k = 1:length(sim_year)
        fprintf(fid, '%d, %f\n', sim_year(k), sim_data(k));
    end
    fclose(fid);
end

% --- 正式读取与分析代码 ---
% 读取数据 (通常第一列是年份，第二列是黑子数)
try
    data = dlmread(filename); % 或者用 csvread, readmatrix
catch
    error('读取文件失败，请检查路径。');
end

years = data(:, 1);
sunspots = data(:, 2);

figure('Name', '实验三：太阳黑子');
subplot(2,1,1);
plot(years, sunspots);
title('太阳黑子活动历史数据');
xlabel('年份'); ylabel('数量'); grid on;

% 进行 FFT 分析
N = length(sunspots);       % 数据长度
xk = fft(sunspots);

% --- 关键步骤：去除直流分量 ---
% 实验书 Page 4 的参考代码里写了 xk(1)=[]; 
% 直流分量(0Hz)通常非常大，会掩盖主要周期分量，所以要去掉
xk(1) = 0; % 将直流分量置零，或者按书中方法剔除 xk_noDC = xk(2:end);

xk_abs = abs(xk);
% 计算半边频谱 (只看正频率部分)
xk_half = xk_abs(1:floor(N/2));
freq_axis = (0:floor(N/2)-1) * (1/N); % 归一化频率 (次/年)

% 转换频率轴为周期轴 (周期 = 1/频率)
% 为了绘图方便，我们先画频率谱，从图中观察峰值

subplot(2,1,2);
plot(freq_axis, xk_half, 'b-'); 
title('太阳黑子活动频谱');
xlabel('频率 (1/年)'); ylabel('幅度');
xlim([0 0.2]); % 主要关注低频段
grid on;

% --- 自动寻找最大峰值并计算周期 ---
[max_val, max_idx] = max(xk_half);
main_freq = freq_axis(max_idx);
cycle_years = 1 / main_freq;

text(main_freq, max_val, ['\leftarrow 主峰 T \approx ' num2str(cycle_years, '%.1f') ' 年']);
disp(['计算得到的太阳黑子活动周期约为：', num2str(cycle_years), ' 年']);