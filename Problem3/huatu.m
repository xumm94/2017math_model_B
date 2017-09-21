clear;
clc;
p = [0.001,0.0013,0.0016,0.002];
temp = [4,5,6,8];
load('c.mat');
f = 1e7 : 1e7 :4e10;
f = f';

S21 = ones(4000,4);
cmap=colormap(jet(4)); 
y_lim = [40,5,5,5];
daikuan = [19.51,20.53,19.97];
for i = 1 : 4
    p0 = p(i);
    Ns = (p0 /c(4)*c(7) + c(5)*c(6)*p0 /(c(4) + c(8)*p0)) / (c(2)/c(3) + c(5)*p0/(c(4) + c(8)*p0));
    Y = 1/c(7) + 1/c(3) + c(5)*p0/(c(4) + c(8)*p0) - c(5)*(Ns-c(6))/((1+c(8)*p0/c(4))^2);
    Z = 1/(c(7)*c(3)) + c(5)*p0/((c(4) + c(8)*p0)*c(7)) - (((1-c(2))/c(3)))*c(5)*(Ns-c(6))/((1+c(8)*p0/c(4))^2);
    S21(:,i) = 20*log10(Z./((Z - 4*pi^2*f.^2).^2 + 4*pi^2*f.^2*Y^2).^0.5);
    subplot(2,2,i)
    plot(f/1e9,S21(:,i),'Color',cmap(i,:))
    xlabel('f/GHz')
    ylabel('H/DB')
    grid on 
    title(['外部温度为20℃偏置电流为', num2str(temp(i)) , 'mA时幅频特性曲线'])
    hold on
end

subplot(2,2,1)
hold on 
plot([0,25.64],[-10.2,-10.2],'--')
hold on 
plot([25.64,25.64],[-20,-10.2],'--')

subplot(2,2,2)
hold on 
plot([0,28.15],[-10,-10],'--')
hold on 
plot([28.15,28.15],[-20,-10],'--')


subplot(2,2,3)
hold on 
plot([0,29.52],[-10,-10],'--')
hold on 
plot([29.52,29.52],[-20,-10],'--')

subplot(2,2,4)
hold on 
plot([0,30.9],[-10,-10],'--')
hold on 
plot([30.9,30.9],[-20,-10],'--')
