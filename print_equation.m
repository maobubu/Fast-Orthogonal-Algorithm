function [ y_final ] = print_equation( a,p)
%print the final equation.
fprintf('y=');
for i=1:length(p)        
fprintf('(%f)',a(i));
    for j=1:length(p(i).x)   
    k = p(i).x(j);       %get all the x(i)(refers to the lags) in struct lag
    fprintf('*x(n-%d)',k);
    end

    for z=1:length(p(i).y)   
    l = p(i).y(z);       %get all the y(i)(refers to the lags) in struct lag
    fprintf('*y(n-%d)',l);
    end
if(i~=length(p))
    fprintf('+');
end

end
fprintf('\n');

end