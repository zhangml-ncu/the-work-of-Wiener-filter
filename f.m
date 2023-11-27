clc;
clear;
close all;
% 参数设置
L=2000; %信号长度
var_w=1;  %噪声w(n)的方差
a=1;  %AR模型参数
w=sqrt(var_w)*randn(L,1);
%% 产生原始信号s(n)
s=zeros(L,1);
s(1)=0;  %原始信号的初始值
for n=2:L
    s(n)=a*s(n-1)+w(n);  %原始信号
end
S=fft(s);
%% 加噪20dB 
SNR1 = 20; % 信噪比20dB 
x1=awgn(s,SNR1,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%观测信号 x=s+v， 给s(n)加入信噪比为20dB的高斯白噪声
X1=fft(x1);
%% 混合信号x1维纳滤波
% 维纳滤波
H1 = fft(s) ./ fft(x1); % 频域解
y1 = real(ifft(H1 .* fft(x1))); % 滤波后的信号
en1=s-y1;  %误差信号等于期望信号与滤波输出信号的差值
MSE1=mean(en1.^2);
%% 加噪10dB
SNR2 = 10; %信噪比10dB
x2=awgn(s,SNR2,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%观测信号 x=s+v.，给s(n)加入信噪比为20dB的高斯白噪声
X2=fft(x2);
%% 混合信号x2维纳滤波
% 维纳滤波
H2 = fft(s) ./ fft(x2); % 频域解
y2 = real(ifft(H2 .* fft(x2))); % 滤波后的信号
en2=s-y2;  %误差信号等于期望信号与滤波输出信号的差值
MSE2=mean(en2.^2);
%% 加噪6dB
SNR3 = 6; % 信噪比6dB
x3=awgn(s,SNR3,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%观测信号 x=s+v.，给s(n)加入信噪比为20dB的高斯白噪声
X3=fft(x3);
%% 混合信号x3维纳滤波
% 维纳滤波
H3 = fft(s)./fft(x3); % 频域解
y3 = real(ifft(H3 .* fft(x3))); % 滤波后的信号
en3=s-y3;  %误差信号等于期望信号与滤波输出信号的差值
MSE3=mean(en3.^2);
figure(1)
subplot(3,1,1);
plot(x1);
title('SNR=20dB时的观测信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,2);
plot(x2);
title('SNR=10dB时的观测信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,3);
plot(x3);
title('SNR=6dB时的观测信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
figure(2);
subplot(3,1,1);
plot(s);
title('原始信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,2);
plot(x1);%加上高斯噪声的混合信号
title('SNR=20dB的输入信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,3);
plot(y1);%滤波信号
title('SNR=20dB的观测信号经维纳滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
figure(3);
subplot(3,1,1);
plot(s);%余弦信号
title('原始信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,2);
plot(x2);%加上白噪声的混合信号
title('SNR=10dB的输入信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,3);
plot(y2);%滤波信号
title('SNR=10dB的观测信号经维纳滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
figure(4);
subplot(3,1,1);
plot(s);%余弦信号
title('原始信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,2);
plot(x3);%加上白噪声的混合信号
title('SNR=6dB的输入信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,3);
plot(y3);%滤波信号
title('SNR=6dB的观测信号经维纳滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
