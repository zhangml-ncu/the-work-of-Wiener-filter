clc;
clear;
close all;
% 参数设置
SNR = 20; % 信噪比20dB
L1=2000;%信号长度
a=1;%AR模型参数
w=randn(L,1);
%% 产生原始信号s(n)
s=zeros(L,1);
s(1)=0; %原始信号的初始值
for n=2:L
    s(n)=a*s(n-1)+w(n);%原始信号
end
%% 加噪
x1=awgn(s,SNR,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%观测信号 x=s+v.，给s(n)加入信噪比为20dB的高斯白噪声
L2=1000;
s2=s(1:L2);
x2=awgn(s2,SNR,'measured');
L3=10;
s3=s(1:L3);
x3=awgn(s3,SNR,'measured');
%% L=2000 维纳滤波
N=100;%维纳滤波器的阶数
Rxx1=xcorr(x1,N-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N    %自相关矩阵
    for j=1:N
        rxx1(i,j)=Rxx1(N-i+j); % N*N维度;
    end
end
Rxs1=xcorr(x1,s,N-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N     %互相关向量
    rxs1(i)=Rxs1(N-1+i); % 1*M维度
end
h1=inv(rxx1)*rxs1';%得到维纳滤波系数
y1=conv(h1,x1);%混合信号2通过维纳滤波器
Signal_Filter1=y1(1:L);
en1=s-Signal_Filter1;%误差信号等于期望信号与滤波输出信号的差值
MSE1=mean(en1.^2);
%% L=1000 维纳滤波
N=100;%维纳滤波器的阶数
Rxx2=xcorr(x2,N-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N    %自相关矩阵
    for j=1:N
        rxx2(i,j)=Rxx2(N-i+j); % N*N维度;
    end
end
Rxs2=xcorr(x2,s,N-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N     %互相关向量
    rxs2(i)=Rxs2(N-1+i); % 1*M维度
end
h2=inv(rxx2)*rxs2';%得到维纳滤波系数
y2=conv(h2,x2);%混合信号2通过维纳滤波器
Signal_Filter2=y2(1:L2);
en2=s-Signal_Filter2;%误差信号等于期望信号与滤波输出信号的差值
MSE2=mean(en2.^2);
%% L=10 维纳滤波
N=100;%维纳滤波器的阶数
Rxx3=xcorr(x3,N-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N    %自相关矩阵
    for j=1:N
        rxx3(i,j)=Rxx3(N-i+j); % N*N维度;
    end
end
Rxs3=xcorr(x3,s,N-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N     %互相关向量
    rxs3(i)=Rxs3(N-1+i); % 1*M维度
end
h3=inv(rxx3)*rxs3';%得到维纳滤波系数
y3=conv(h3,x3);%混合信号2通过维纳滤波器
Signal_Filter3=y3(1:L3);
en3=s-Signal_Filter3;%误差信号等于期望信号与滤波输出信号的差值
MSE3=mean(en3.^2);
%%
figure(1)
subplot(2,2,1);
plot(Signal_Filter1);
title('信号长度L=2000时滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([0,80]);
subplot(2,2,2);
plot(Signal_Filter2);
title('信号长度L=1000时滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([0,80]);
subplot(2,2,3);
plot(Signal_Filter3);
title('信号长度L=10时滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([0,80]);
subplot(2,2,4);
plot(s);
title('原始信号');
xlabel('时间');ylabel('幅度');
ylim([0,80]);