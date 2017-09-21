clear
clc
load('c.mat');
tao_p = c(7) * linspace(0.5,1.5,11);
load('S21_5.mat')

S21 = ones(2500,11);
cmap=colormap(jet(11)); 
for i = 1 : 11
    p0 = 1.9e-3;
    c(7) = tao_p(i);
    Ns = (p0 /c(4)*c(7) + c(5)*c(6)*p0 /(c(4) + c(8)*p0)) / (c(2)/c(3) + c(5)*p0/(c(4) + c(8)*p0));
    Y = 1/c(7) + 1/c(3) + c(5)*p0/(c(4) + c(8)*p0) - c(4)*c(5)*(Ns-c(6))/(c(4)+ c(8)*p0);
    Z = 1/(c(7)*c(3)) + c(5)*p0/((c(4) + c(8)*p0)*c(7)) - (c(4)*(1-c(2))/c(3))*c(5)*(Ns-c(6))/(c(4)+ c(8)*p0);
    S21(:,i) = 20*log10(Z./((Z - 4*pi^2*f.^2).^2 + 4*pi^2*f.^2*Y^2).^0.5);
    plot(f/1e9,S21(:,i),'Color',cmap(i,:))
    hold on
end
legend('0.5tao_p','0.6tao_p','0.7tao_p','0.8tao_p','0.9tao_p','1.0tao_p','1.1tao_p','1.2tao_p','1.3tao_p','1.4tao_p','1.5tao_p')
xlabel('f/GHz')
ylabel('H/DB')
grid on 
title('偏置电流为7.5mA温度为20℃不同tao_p的幅频响应图')