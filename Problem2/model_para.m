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
plot(I(index),p1.*1E3,'o')
hold on
plot(I(index),P(index),'-')
xlabel('驱动电流/mA')
ylabel('光功率/mW')
title('利用光功率-驱动电流起始线性关系求Ith0（20℃）')
legend('拟合曲线','实测曲线')
syms x
eq1 = H(1)*x+H(2);
Ith0 = double(solve(eq1,x))

% 在确定Ith0后拟合其它参数
b0 = [0.5,1.246E-3,2.6E3,-2.545E-5,2.908E-7,-2.531E-10,1.022E-12,2.022E-14];
f = inline('b(1)*(X(:,2)-2.9752E-04*ones(1401,1)-b(2)*ones(1401,1)-b(4)*(X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3))-b(5)*(X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^2-b(6)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^3-b(7)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^4)-b(8)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b(3)).^5)))','b','X');
[b1,r1,~,CovB,MSE,ErrorModelInfo] = nlinfit(X,X(:,3),f,b0,statset('MaxIter',100,'Display','final'));
b1
MSE

%在模型参数确定后，由UI值求P值
P0 = []
for j =1:1401
    u=X(j,1);
    i=X(j,2);
    syms PP;
    eq = b1(1)*(i-2.9752e-04-b1(2)-b1(4)*(293+(u*i-PP)*b1(3))-b1(5)*(293+(u*i-PP)*b1(3)).^2-b1(6)*((293+(u*i-PP)*b1(3)).^3-b1(7)*((293+(u*i-PP)*b1(3)).^4)))-PP;
    p = solve(eq,PP);
    P0(j) = double(p(2));
end
figure(2)
P0(P0 <= 0)= 0;
plot(X(:,2).*1E3,P0.*1E3,'b')
hold on
plot(X(:,2).*1E3,X(:,3).*1E3,'r')
xlabel('驱动电流/mA')
ylabel('光功率/mW')
title('光功率-驱动电流曲线关系图（20℃）')
legend('拟合曲线','实测曲线')

%P0 = b1(1)*(X(:,2)-0.2975E-3*ones(1401,1)-b1(2)*ones(1401,1)-b1(4)*(X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b1(3))-b1(5)*(X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b1(3)).^2-b1(6)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b1(3)).^3-b1(7)*((X(:,4)+(X(:,1).*X(:,2)-X(:,3))*b1(3)).^4)));