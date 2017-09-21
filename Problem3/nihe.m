clear;
clc;
close all
load('S21_5.mat');

H = S21;
c0 = [0.7 1e-3 0.4e-9 1.54e-8 1.8e6 5.1e8 4.14e-12 1.23e-7];


[c,r1,~,CovB,MSE,ErrorModelInfo] = nlinfit(f,H,@pinfu,c0,statset('MaxIter',100,'Display','final','TolX',1e-100));
c0 = c;
MSE0 = MSE;

MSE
S21_cal = pinfu(c0,f);
plot(f/1e9,S21,f/1e9,S21_cal)
legend('实验曲线','拟合曲线')
xlabel('f/GHz')
ylabel('H/DB')
grid on 
title('偏置电流为7.5mA温度为20℃时频率响应曲线图')


