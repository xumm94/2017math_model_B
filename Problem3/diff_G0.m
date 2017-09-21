clear
clc
load('c.mat');
G0 = c(5) * linspace(0.5,1.5,11);
load('S21_5.mat')

S21 = ones(2500,11);
cmap=colormap(jet(11)); 
for i = 1 : 11
    p0 = 1.9e-3;
    c(5) = G0(i);
    Ns = (p0 /c(4)*c(7) + c(5)*c(6)*p0 /(c(4) + c(8)*p0)) / (c(2)/c(3) + c(5)*p0/(c(4) + c(8)*p0));
    Y = 1/c(7) + 1/c(3) + c(5)*p0/(c(4) + c(8)*p0) - c(4)*c(5)*(Ns-c(6))/(c(4)+ c(8)*p0);
    Z = 1/(c(7)*c(3)) + c(5)*p0/((c(4) + c(8)*p0)*c(7)) - (c(4)*(1-c(2))/c(3))*c(5)*(Ns-c(6))/(c(4)+ c(8)*p0);
    S21(:,i) = 20*log10(Z./((Z - 4*pi^2*f.^2).^2 + 4*pi^2*f.^2*Y^2).^0.5);
    plot(f/1e9,S21(:,i),'Color',cmap(i,:))
    hold on
end
legend('0.5G0','0.6G0','0.7G0','0.8G0','0.9G0','1.0G0','1.1G0','1.2G0','1.3G0','1.4G0','1.5G0')
xlabel('f/GHz')
ylabel('H/DB')
grid on 
title('偏置电流为7.5mA温度为20℃不同G0的幅频响应图')