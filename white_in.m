function [y]=white_in(n)
mu=0;sigma=1;
rng(0);
y=sigma*randn(n,1)+mu;% 3000white gausian noise,mean 0, var 1,sigma=var^0.5
var(y)
end

function [y]=whitega(n)
y=normrnd(0,1,1,3000);% 3000white gausian noise,mean 0, var 1
end