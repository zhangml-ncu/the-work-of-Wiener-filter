clc;
clear;
close all;
load('origial signal.mat','s');
% 参数设置
SNR1= 20; % 信噪比20dB
%% 加噪
L=50:50:300;%信号长度
for m=1:length(L)
    l=L(m);
    S=s(1:l,:);
x=awgn(S,SNR1,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x1维纳滤波
N=10;%维纳滤波器的阶数
Rxx=xcorr(x,N-1,'biased'); % 自相关函数
     for i=1:N    %自相关矩阵
         for j=1:N
            rxx(i,j)=Rxx(N-i+j); % N*N维度;
         end
     end
Rxs=xcorr(x,S,N-1,'biased'); % 互相关函数
     for i=1:N     %互相关向量
         rxs(i)=Rxs(N-1+i);  % 1*M维度
     end
h=inv(rxx)*rxs'; %得到维纳滤波系数
y=conv(h,x); %混合信号通过维纳滤波器
Signal_Filter=y(1:l);
en=S-Signal_Filter;%误差信号等于期望信号与滤波输出信号的差值
MSE1(:,m)=mean(en.^2);    
end
SNR2= 10; % 信噪比20dB
%% 加噪
L=50:50:300;%信号长度
for m=1:length(L)
    l=L(m);
    S=s(1:l,:);
x=awgn(S,SNR2,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x1维纳滤波
N=10;%维纳滤波器的阶数
Rxx=xcorr(x,N-1,'biased'); % 自相关函数
     for i=1:N    %自相关矩阵
         for j=1:N
            rxx(i,j)=Rxx(N-i+j); % N*N维度;
         end
     end
Rxs=xcorr(x,S,N-1,'biased'); % 互相关函数
     for i=1:N     %互相关向量
         rxs(i)=Rxs(N-1+i);  % 1*M维度
     end
h=inv(rxx)*rxs'; %得到维纳滤波系数
y=conv(h,x); %混合信号通过维纳滤波器
Signal_Filter=y(1:l);
en=S-Signal_Filter;%误差信号等于期望信号与滤波输出信号的差值
MSE2(:,m)=mean(en.^2);    
end
SNR3= 6; % 信噪比20dB
%% 加噪
L=50:50:300;%信号长度
for m=1:length(L)
    l=L(m);
    S=s(1:l,:);
x=awgn(S,SNR3,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x1维纳滤波
N=10;%维纳滤波器的阶数
Rxx=xcorr(x,N-1,'biased'); % 自相关函数
     for i=1:N    %自相关矩阵
         for j=1:N
            rxx(i,j)=Rxx(N-i+j); % N*N维度;
         end
     end
Rxs=xcorr(x,S,N-1,'biased'); % 互相关函数
     for i=1:N     %互相关向量
         rxs(i)=Rxs(N-1+i);  % 1*M维度
     end
h=inv(rxx)*rxs'; %得到维纳滤波系数
y=conv(h,x); %混合信号通过维纳滤波器
Signal_Filter=y(1:l);
en=S-Signal_Filter;%误差信号等于期望信号与滤波输出信号的差值
MSE3(:,m)=mean(en.^2);    
end
figure(1)
plot(L,MSE1,'-s','LineWidth',1.5);
hold on;
plot(L,MSE2,'-*','LineWidth',1.5);
hold on;
plot(L,MSE3,'-o','LineWidth',1.5);
title('信号长度对实验结果的影响');
xlabel('信号长度');ylabel('均方误差');
legend( 'SNR=20dB','SNR=10dB','SNR=6dB'); 
grid on;