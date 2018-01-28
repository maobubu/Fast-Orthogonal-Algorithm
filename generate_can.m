function [P]=generate_can(K,L,order)
N0=max(K,L);
% ==============Structure of p:============================

p = struct('const', [], 'x', [], 'y', []); %const don'y have to be one
P = struct(p);
%==========================================================
% generate all candidates
counter = 1;
for total_order = 1 : order
    for x_order = 0:total_order
       
        
        y_order = total_order - x_order;
        
        x_value = order_combine(0:K, x_order);%a function that helps calculate N!/K!(N-K)! pick K from N. 
        y_value = order_combine(1:L, y_order);%and put in to a matrix. column is the value of K, 
                                        %row is the value which has been picked 
        
        if (size(x_value,1) >= 1)
            for j = 1:size(x_value,1)
                P(counter).x = x_value(j, :);
                if (size(y_value,1) >= 1)
                    for k = 1:size(y_value,1)
                        P(counter).x = x_value(j, :);
                        P(counter).y = y_value(k, :);
                        
                        counter = counter + 1;
                    end
                else
                    counter = counter+1;
                end
            end
        else
            for k = 1:size(y_value,1)
                P(counter).y = y_value(k, :);
                
                counter = counter + 1;
             end
        end
    end
end