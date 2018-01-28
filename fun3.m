function [y]=fun3(n,x)
y=zeros(n,1);
for i=5:3000
y(i)=2+0.1*x(i-1)^2+0.31*y(i-3)*x(i-1)-0.31*x(i-2)*y(i-4)*x(i-3)+0.17*x(i-3)*x(i-4)+0.14*x(i-2)*y(i-3);
end
end