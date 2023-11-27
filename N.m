clc;
clear;
close all;
load('origial signal.mat','s');
% 参数设置
L=2000;
SNR = 10; % 信噪比10dB
%% 加噪10dB 
x=awgn(s,SNR,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% N=1 维纳滤波
N1=1;%维纳滤波器的阶数
Rxx1=xcorr(x,N1-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N1    %自相关矩阵
    for j=1:N1
        rxx1(i,j)=Rxx1(N1-i+j); % N*N维度;
    end
end
Rxs1=xcorr(x,s,N1-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N1     %互相关向量
    rxs1(i)=Rxs1(N1-1+i); % 1*M维度
end
h1=inv(rxx1)*rxs1';%得到维纳滤波系数
y1=conv(h1,x);%混合信号2通过维纳滤波器
Signal_Filter1=y1(1:L);
en1=s-Signal_Filter1;%误差信号等于期望信号与滤波输出信号的差值
MSE1=mean(en1.^2);
%% N=3 维纳滤波
N2=3;%维纳滤波器的阶数
Rxx2=xcorr(x,N2-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N2    %自相关矩阵
    for j=1:N2
        rxx2(i,j)=Rxx2(N2-i+j); % N*N维度;
    end
end
Rxs2=xcorr(x,s,N2-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N2     %互相关向量
    rxs2(i)=Rxs2(N2-1+i); % 1*M维度
end
h2=inv(rxx2)*rxs2';%得到维纳滤波系数
y2=conv(h2,x);%混合信号2通过维纳滤波器
Signal_Filter2=y2(1:L);
en2=s-Signal_Filter2;%误差信号等于期望信号与滤波输出信号的差值
MSE2=mean(en2.^2);
%% N=10 维纳滤波
N3=10;%维纳滤波器的阶数
Rxx3=xcorr(x,N3-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N3    %自相关矩阵
    for j=1:N3
        rxx3(i,j)=Rxx3(N3-i+j); % N*N维度;
    end
end
Rxs3=xcorr(x,s,N3-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N3     %互相关向量
    rxs3(i)=Rxs3(N3-1+i); % 1*M维度
end
h3=inv(rxx3)*rxs3';%得到维纳滤波系数
y3=conv(h3,x);%混合信号2通过维纳滤波器
Signal_Filter3=y3(1:L);
en3=s-Signal_Filter3;%误差信号等于期望信号与滤波输出信号的差值
MSE3=mean(en3.^2);
%%
figure(1)
subplot(2,2,1);
plot(Signal_Filter1);
title('阶数N=1时滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([0,40]);
grid on;
subplot(2,2,2);
plot(Signal_Filter2);
title('阶数N=3时滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([0,40]);
grid on;
subplot(2,2,3);
plot(Signal_Filter3);
title('阶数N=10时滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([0,40]);
grid on;
subplot(2,2,4);
plot(s);
title('原始信号');
xlabel('时间');ylabel('幅度');
ylim([0,40]);
grid on;