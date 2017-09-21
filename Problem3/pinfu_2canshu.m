function [S21] = pinfu_2canshu(c,f)
    S21 = 20*log10(c(1)./((c(1) - f.^2).^2 + f.^2*c(2)^2).^0.5);
end