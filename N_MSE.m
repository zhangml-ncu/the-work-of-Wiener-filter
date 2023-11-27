clc;
clear;
close all;
load('origial signal.mat','s');
% 参数设置
L=2000; %信号长度
SNR= 20; % 信噪比
%% 加噪
N=1:1:10; %维纳滤波器的阶数
for m=1:length(N)
    n=N(m);
x=awgn(s,SNR,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x1维纳滤波
Rxx=xcorr(x,n-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
     for i=1:n    %自相关矩阵
         for j=1:n
            rxx(i,j)=Rxx(n-i+j); % N*N维度
         end
     end
Rxs=xcorr(x,s,n-1,'biased'); % 互相关函数1*(2N-1)维度
     for i=1:n    %互相关向量
         rxs(i)=Rxs(n-1+i); % 1*M维度
     end
h=inv(rxx)*rxs';%得到维纳滤波系数
y=conv(h,x);%混合信号2通过维纳滤波器
Signal_Filter=y(1:L);
en=s-Signal_Filter;%误差信号等于期望信号与滤波输出信号的差值
MSE(:,m)=mean(en.^2);  %滤波后输出信号相对于原信号的统计均方误差
end
figure(1)
plot(N,MSE,'LineWidth',1.5);
title('维纳滤波器的阶数对实验结果的影响');
xlabel('维纳滤波器阶数');ylabel('均方误差MSE');
grid on;