function [ value ] = terms( x, y, lag)

value = ones(length(x),1);

for i=1:length(lag.x)   
    k = lag.x(i);       %get all the x(i)(refers to the lags) in struct lag
    value = value.*delay(x,k);%e.g x(n-k1)*x(n-k2)
end

for i=1:length(lag.y)   
    l = lag.y(i);       %get all the y(i)(refers to the lags) in struct lag
    value = value.*delay(y,l);%e.g x(n-k1)*x(n-k2)*y(n-l1)
end

end