function [ y_final ] = generate_func( p,a,x,y )
%y_final is the final result of the algorithm. a matrix that have 1 column
%and N rows. The first row equals to y(0), second row equals to y(1) and go on.
y_final = zeros(length(x),1);% generate y_final for the final value.
for i=1:length(p)        
    y_final = y_final + a(i) * generate_terms(x, y, p(i));
end

end
