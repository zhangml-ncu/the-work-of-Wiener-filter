clc;
clear;
close all;
% 参数设置
L=2000;%信号长度
a=0.2;%AR模型参数
% w=repmat(0.02,L,1);
w=randn(L,1);
%% 产生原始信号s(n)
s=zeros(L,1);
s(1)=0; %原始信号的初始值
for n=2:L
    s(n)=a*s(n-1)+w(n);%原始信号
end
%% 加噪20dB 
SNR1 = 20; % 信噪比20dB
x1=awgn(s,SNR1,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x1维纳滤波
N=200;%维纳滤波器的阶数
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
y1=conv(x1,h1);%混合信号1通过维纳滤波器
Signal_Filter1=y1(1:L);
en1=s-Signal_Filter1;%误差信号等于期望信号与滤波输出信号的差值
MSE1=mean(en1.^2);
%% 加噪10dB
SNR2 = 10; % 信噪比10dB
x2=awgn(s,SNR2,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x2维纳滤波
N=200;%维纳滤波器的阶数
Rxx2=xcorr(x2,N-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N    %自相关矩阵
    for j=1:N
        rxx2(i,j)=Rxx2(N-i+j); % N*N维度;
    end
end
Rxs2=xcorr(x2,s,N-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N     %互相关向量
    rxs2(i)=Rxs2(N-1+i); %1*N维度
end
h2=inv(rxx2)*rxs2';%得到维纳滤波系数
y2=conv(h2,x2);%混合信号2通过维纳滤波器
Signal_Filter2=y2(1:L);
en2=s-Signal_Filter2;%误差信号等于期望信号与滤波输出信号的差值
MSE2=mean(en2.^2);
%% 加噪6dB
SNR3 = 6; % 信噪比6dB
x3=awgn(s,SNR3,'measured'); %在加噪声前先测量输入信号的功率，再根据SNR加噪声
%% 混合信号x3维纳滤波
N=200;%维纳滤波器的阶数
Rxx3=xcorr(x3,N-1,'biased'); % 自相关函数1*(2N-1)维度，返回一个延迟范围在[-N，N]的互相关函数序列,对称的;
for i=1:N    %自相关矩阵
    for j=1:N
        rxx3(i,j)=Rxx3(N-i+j); % N*N维度;
    end
end
Rxs3=xcorr(x3,s,N-1,'biased'); % 互相关函数1*(2N-1)维度
for i=1:N     %互相关向量
    rxs3(i)=Rxs3(N-1+i); % 1*N维度
end
h3=inv(rxx3)*rxs3';%得到维纳滤波系数
y3=conv(h3,x3);%混合信号2通过维纳滤波器
Signal_Filter3=y3(1:L);
en3=s-Signal_Filter3;%误差信号等于期望信号与滤波输出信号的差值
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
plot(Signal_Filter1);%滤波信号
title('SNR=20dB的观测信号经维纳滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
figure(3);
subplot(3,1,1);
plot(s);
title('原始信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,2);
plot(x2);%加上白噪声的混合信号
title('SNR=10dB的输入信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
subplot(3,1,3);
plot(Signal_Filter2);%滤波信号
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
plot(Signal_Filter3);%滤波信号
title('SNR=6dB的观测信号经维纳滤波后的信号');
xlabel('时间');ylabel('幅度');
ylim([-40,40]);
save('origial signal.mat','s');
