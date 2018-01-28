function [y]=uni_in(n)
rng(5);
y = -2 + (2+2)*rand(n,1);% from -2 to 2 uniform distribution
end