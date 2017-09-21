clear;
clc;

load('S21_5.mat');
f = f/10^9;
c0 = [100000 100000];
fun = @pinfu_2canshu;
c = lsqcurvefit(fun,c0,f,S21);
S21_cal = pinfu_2canshu(c,f);
plot(f,S21,'b');
hold on 
plot(f,S21_cal,'r');
xlabel('f/GHz')
ylabel('H/DB')
legend('实验曲线','拟合曲线')
grid on 
title('Z和Y拟合的曲线图')