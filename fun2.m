function [y]=fun2(n,x)
y=zeros(n,1);
for i=7:3000
y(i)=1.5-0.15*x(i-3)^2+0.04*y(i-2)*x(i-4)+0.42*x(i-1)*y(i-3)*x(i-5)-0.21*x(i-6)*x(i-2)+0.04*x(i-4);
end
end