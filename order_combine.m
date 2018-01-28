function y = order_combine(v, k)
%V is a vector of length N, produces a matrix with
% (N+1-1)!/K!(N-1)! (i.e., "N+K-1 choose K") rows and K columns. Each row of
% the result has K of the elements in the vector V. 
%Pick k from vector V; order is irrelevant;
error(nargchk(2, 2, nargin));

if sum(size(v) > 1) > 1
    error('First argument must be a vector.');
end

if any(size(k) ~= 1) | (k ~= round(k)) | (k < 0)
    error('Second argument must be a scalar.');
end

if k == 0
    y = zeros(0, k);
elseif k == 1
    y = zeros(length(v), 1);
    for i = 1:length(v)
        y(i) = v(i);
    end
else
    v = v(:);
    y = [];
    m = length(v);
    if m == 1
        y = v(1, ones(k, 1));
    else
        for i = 1 : m
            y_recr = order_combine(v(i:end), k-1);
            s_repl = v(i);
            s_repl = s_repl(ones(size(y_recr, 1), 1), 1);
            y = [ y ; s_repl, y_recr ];
        end
    end
end