function [y]=fun1(n,x)
y=zeros(n,1);
for i=4:3000
y(i)=1.5+0.1*x(i-1)^2+0.11*y(i-1)*x(i-2)-0.22*x(i-3)*y(i-1)*x(i-1)+0.51*x(i-2)*x(i-1);
end
end