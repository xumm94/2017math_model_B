
function [S21] = pinfu(c,f)
 
    p0 = 1.95e-3;
    Ns = (p0 /c(4)*c(7) + c(5)*c(6)*p0 /(c(4) + c(8)*p0)) / (c(2)/c(3) + c(5)*p0/(c(4) + c(8)*p0));
    Y = 1/c(7) + 1/c(3) + c(5)*p0/(c(4) + c(8)*p0) - c(5)*(Ns-c(6))/((1+c(8)*p0/c(4))^2);
    Z = 1/(c(7)*c(3)) + c(5)*p0/((c(4) + c(8)*p0)*c(7)) - (((1-c(2))/c(3)))*c(5)*(Ns-c(6))/((1+c(8)*p0/c(4))^2);
    S21 = 20*log10(abs(Z./((Z - 4*pi^2*f.^2).^2 + 4*pi^2*f.^2*Y^2).^0.5));
end
% 
% function [S21] = pinfu(c,f)
%  
%     p0 = 1.95e-3;
%     Ns = (p0 /c(3)*c(6) + c(4)*c(5)*p0 /(c(3) + c(7)*p0)) / (c(1)/c(2) + c(4)*p0/(c(3) + c(7)*p0));
%     Y = 1/c(6) + 1/c(2) + c(4)*p0/(c(3) + c(7)*p0) - c(4)*(Ns-c(5))/((1+c(7)*p0/c(3))^2);
%     Z = 1/(c(6)*c(2)) + c(4)*p0/((c(3) + c(7)*p0)*c(6)) - (((1-c(1))/c(2)))*c(4)*(Ns-c(5))/((1+c(7)*p0/c(3))^2);
%     S21 = 20*log10(Z./((Z - 4*pi^2*f.^2).^2 + 4*pi^2*f.^2*Y^2).^0.5);
% end




















