
function [ x1 ] = delay( x, k )

x1 = [zeros(k,1); x(1:end-k)];%calculate the delay for given x. 
%if k is delay, than add k of 0 infront of the data x.

end