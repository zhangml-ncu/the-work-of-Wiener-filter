clc;
clear;
close all;
load('origial signal.mat','s');
% 参数设置
L=2000;%信号长度
%% 加噪
SNR= 30:2:50; % 信噪比
for m=1:length(SNR)
    snr=SNR(m);
x=awgn(s,snr,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x1维纳滤波
N=200;%维纳滤波器的阶数
Rxx=xcorr(x,N-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
     for i=1:N    %自相关矩阵
         for j=1:N
            rxx(i,j)=Rxx(N-i+j); % N*N维度;
         end
     end
Rxs=xcorr(x,s,N-1,'biased'); % 互相关函数1*(2N-1)维度
     for i=1:N     %互相关向量
         rxs(i)=Rxs(N-1+i); % 1*M维度
     end
h=inv(rxx)*rxs';%得到维纳滤波系数
y=conv(h,x);%混合信号通过维纳滤波器
Signal_Filter=y(1:L);
en=s-Signal_Filter;%误差信号等于期望信号与滤波输出信号的差值
MSE(:,m)=mean(en.^2);    
end
figure(1)
plot(SNR,MSE,'LineWidth',1.5);
title('信噪比对实验结果的影响');
xlabel('信噪比/dB');ylabel('均方误差MSE');
grid on;