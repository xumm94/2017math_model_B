clear;
clc;
load('L-I-20C.mat')
T = 293;
X=[U I.*1E-3 P.*1E-3 293.*ones(1401,1)];

%使用(0,1)之间的功率值拟合Ith0
index = find(0<P & P<1)
H = polyfit(I(index).*1E-3,P(index).*1E-3,1)
p1 = polyval(H,I(index).*1E-3);
figure(1)
plot(I(index),p1,'o')
hold on
plot(I(index),P(index).*1E-3,'-')
xlabel('驱动电流/mA')
ylabel('光功率/mW')
title('利用光功率-驱动电流起始线性关系求Ith0（20℃）')
legend('拟合曲线','实测曲线')
syms x
eq1 = H(1)*x+H(2);
Ith0 = double(solve(eq1,x))

% 在确定Ith0后拟合其它参数
b0 = [0.5,1.246E-3,2.6E3,-2.545E-5,2.908E-7,-2.531E-10,1.022E-12];
f = inline('b(1)*(X(:,2)-2.9752E-04*ones(1401,1)-b(2)*ones(1401,1)-b(4)*(X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3))-b(5)*(X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^2-b(6)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^3-b(7)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^4)))','b','X');
[b1,r1,~,CovB,MSE,ErrorModelInfo] = nlinfit(X,X(:,3),f,b0,statset('MaxIter',100,'Display','final'));
b1
MSE

%求20℃时的UI关系曲线
d0 = [-5.893 ,5.16,-0.5753,0.004009,2.87e-05,0.004456,-0.3845,14.9];
ff = inline('(d(1)*ones(1401,1)+d(2)*X(:,4)+d(3)*X(:,4).^2+d(4)*X(:,4).^3).*(d(5)*ones(1401,1)+d(6)*X(:,2)+d(7)*X(:,2).^2+d(8)*X(:,2).^3)','d','X');
[d1,dr1,~,dCovB,dMSE,dErrorModelInfo] = nlinfit(X,X(:,1),ff,d0,statset('MaxIter',200,'Display','final'));
d1
dMSE
UU = (d1(1)*ones(1401,1)+d1(2)*X(:,4)+d1(3)*X(:,4).^2+d1(4)*X(:,4).^3).*(d1(5)*ones(1401,1)+d1(6)*X(:,2)+d1(7)*X(:,2).^2+d1(8)*X(:,2).^3);
figure(2)
plot(X(:,2),UU,'b')
hold on
plot(X(:,2),X(:,1),'r')
xlabel('驱动电流/mA')
ylabel('电压U/V')
title('电压-驱动电流曲线关系图(20℃)(增加高次项)')
legend('拟合曲线','实测曲线')

%求出不同温度下的电压值和功率值，并作图
U_withtemp = zeros(1401,size(10:10:90,2));
for T=10:10:90
    U_withtemp(:,T/10) = (d1(1)*ones(1401,1)+d1(2)*(T+273)*ones(1401,1)+d1(3)*(T+273)^2*ones(1401,1)+d1(4)*(T+273)^3*ones(1401,1)).*(d1(5)*ones(1401,1)+d1(6)*X(:,2)+d1(7)*X(:,2).^2+d1(8)*X(:,2).^3);
end

%在模型参数确定后，由UI值求P值
figure(3)
P_withtemp = zeros(1401,size(10:10:90,2));
P0 = zeros(1401,size(10:10:90,2));
for T=10:10:90
    fprintf('Now will calculate temperature %d.\n',T);
    for j =1:1401        
        u=U_withtemp(j,T/10);
        i=X(j,2);
        syms PP;
        eq = b1(1)*(i-2.9752E-04-b1(2)-b1(4)*((T+273)+(u*i-PP)*b1(3))-b1(5)*((T+273)+(u*i-PP)*b1(3)).^2-b1(6)*(((T+273)+(u*i-PP)*b1(3)).^3-b1(7)*(((T+273)+(u*i-PP)*b1(3)).^4)))-PP;
        p = solve(eq,PP);        
        P_withtemp(j,T/10) = double(p(2));
    end
    P0(:,T/10) = P_withtemp(:,T/10);
    P0(P0(:,T/10)<= 0,T/10)= 0;
    plot(X(:,2), P0(:,T/10))
    hold on
end
 xlabel('电流强度/mA')
ylabel('光功率/mW')
title('不同温度下的L-I曲线')
legend('10℃','20℃','30℃','40℃','50℃','60℃','70℃','80℃','90℃')

%检测在6~8mA工作电流下输出的品平均光功率不低于2mW的温度曲线
figure(4)
II = repmat(X(:,2),1,9);
plot(II.*1E3,P0.*1E3)
hold on
plot(X(:,2).*1E3,X(:,3).*1E3)
legend('10℃','20℃拟合','30℃','40℃','50℃','60℃','70℃','80℃','90℃','20℃实测')
xlabel('电流强度/mA')
ylabel('光功率/mW')
title('不同温度下的L-I曲线(增加高次项)')
hold on
plot([0,14],[2,2],'black--')
hold on
plot([6,6],[0,3.5],'black--')
hold on
plot([8,8],[0,3.5],'black--')