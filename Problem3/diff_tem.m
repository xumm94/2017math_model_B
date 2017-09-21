p = [0.00205941984952908,0.00188506486977532,0.00160305723868174,0.00118089579672479,0.000574946514798918];
load('c.mat');
load('S21_5.mat')

S21 = ones(2500,5);
cmap=colormap(jet(5)); 
for i = 1 : 5
    p0 = p(i);
    Ns = (p0 /c(4)*c(7) + c(5)*c(6)*p0 /(c(4) + c(8)*p0)) / (c(2)/c(3) + c(5)*p0/(c(4) + c(8)*p0));
    Y = 1/c(7) + 1/c(3) + c(5)*p0/(c(4) + c(8)*p0) - c(4)*c(5)*(Ns-c(6))/(c(4)+ c(8)*p0);
    Z = 1/(c(7)*c(3)) + c(5)*p0/((c(4) + c(8)*p0)*c(7)) - (c(4)*(1-c(2))/c(3))*c(5)*(Ns-c(6))/(c(4)+ c(8)*p0);
    S21(:,i) = 20*log10(Z./((Z - 4*pi^2*f.^2).^2 + 4*pi^2*f.^2*Y^2).^0.5);
    plot(f/1e9,S21(:,i),'Color',cmap(i,:))
    hold on
end
legend('10��','20��','30��','40��','50��')
xlabel('f/GHz')
ylabel('H/DB')
grid on 
title('ƫ�õ���Ϊ7.5mAʱ��ͬ�¶ȵķ�Ƶ��Ӧͼ')