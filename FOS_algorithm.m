function [a,p_best]=FOS_algorithm(x,y,K,L,order)
N = length(x);
N0=max(K,L);
D(1,1) = 1;             %D[0,0] 
C(1) = mean(y(N0+1:N)); %C[0], the mean from N0 to N
g(1) = mean(y(N0+1:N)); %g0, the mean from N0 to N
Q(1) = g(1)^2 * D(1,1); %Q[0]=g0^2*D[0,0]
value=generate_can(K,L,order);% a structure to store all the possible candidates
p_best = struct('const', 1, 'x', [], 'y', []);%place to store the best candidate.                                             
M=1;
while (true) %refers to the big loof from m to M
    %%disp(['For term',num2str(M)]); 
    m = M;   %at first, m=M=1, and then increment
    % Evaluate Q for each candidate, choose the best candidate that has the
    % biggest Q
    clear Q_temp;
    for i=1:length(value)       %count for every possible term.
        Pm_n = generate_terms(x, y, value(i));% i refers to every possible term.    
        D(m+1,1) = mean(Pm_n(N0+1:N));%refers to D[m,0]
        for r=0:m-1             % refers to the loop r to m-1
            A(m+1, r+1) = D(m+1, r+1) ./ D(r+1, r+1);%refers to alpha[1,1]=D[m,r]/D[r,r]
            if (r+1 < M)
                Pm_r = generate_terms(x, y, p_best((r+1)+1));%for Pm_r, r starts from 1,so (r+1) 
            else
                Pm_r = Pm_n;
            end
            D(m+1, (r+1)+1) = mean(Pm_n(N0+1:N) .* Pm_r(N0+1:N)) - sum(A((r+1)+1, 1:r+1) .* D(m+1, 1:r+1));
        end% 1 refers to 0; we can get D[m,m] at last.
        C(m+1) = mean(y(N0+1:N) .* Pm_n(N0+1:N)) - sum(A(m+1, 1:m) .* C(1:m)); %calculate C[m],r from 0 to m-1.
        g(m+1) = C(m+1)/D(m+1, m+1); %calculate gm.
        Q_temp(i) = g(m+1)^2 * D(m+1, m+1); % calculate Q[m],there are lots of Q.
    end
    index = find(Q_temp == max(Q_temp)); % Find the maximum Q[M]
    Pm_n = generate_terms(x, y, value(index(1)));%Let Pm[n] be the best selected candidate .
    %% Since I found the best candidate, repeat and see if I should add this term
     D(m+1,1) = mean(Pm_n(N0+1:N));
        for r=1:m  % same as above, but this time I use r from 1:m, so r=r+1
            A(m+1, r) = D(m+1, r) ./ D(r, r);
            if (r < M)
                Pm_r = generate_terms(x, y, p_best(r+1));
            else
                Pm_r = Pm_n;
            end
            D(m+1, r+1) = mean(Pm_n(N0+1:N) .* Pm_r(N0+1:N)) - sum(A(r+1, 1:r) .* D(m+1, 1:r));
        end
        
    
    C(m+1) = mean(y(N0+1:N) .* Pm_n(N0+1:N)) - sum(A(m+1, 1:m) .* C(1:m));
    Q(m+1) = max(Q_temp);% use the previous Q[m], so that don't have to calculate again
    
    if ( Q(M+1) < 4/(N - N0 + 1) *(mean(y(N0+1:N).^2) - sum(Q(1:M))))% m=M, so it's the same
        M = M - 1; % see if satisfy the equation, if doesn't then don't add this term M decrease 1
        break;     % Q(m+1) means Q[M] , break the loop
    end
      
    p_best(m+1) = value(index(1));% for this certain m, add this best candidate to p_best()
    value(index(1)) = []; % remove it from the value
    
    g(m+1) = C(m+1) / D(m+1,m+1);  % find the coefficient gm 
        
    if (isempty(value)|| Q(m+1)<1e-5) % prevent that all the candidate has been selected but still                      
        break;          % doesn't satisfy the above condition, so jump out manually.
    end    
    M = M + 1;
end

figure(2);% there are 10 models, so in every figure there will be 10 lines,
% the lines won't be discriminative because the models might be similar.
plot(0:length(Q)-1, Q(1:end)); hold on;% plot of m and every Q[m], 
title('the Q[m] for each model');
ylabel('Q[m]');
xlabel('m');                    % where Q[m] is the biggest Q for the certain m


% calculate the coefficient am
for m=0:M  % from m to M
    v(m +1)=1;% v[0]=1
    for i = m+1:M 
        v(i +1) = -sum(A(i +1,m +1 : (i-1) +1) .* v(m +1 : (i-1) +1));% calculate v[i]
    end % alpha(i,from m to i-1)  v(from m to i-1)
    a(m +1) = sum(g(m +1:M +1).*v(m +1:M +1));
end


end           