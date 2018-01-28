function [z]=add_noise(y,P,n)
mu=0;
v= P*var(y)/100;% v is the variance of the noise.
sigma=(v)^0.5;%sigma is the square root of the noise
z= zeros(n,1);
rng(1);
noise= sigma *randn(n,1)+mu; % the noise is a white gaussian singal with
% 0 mean and variance which is P/100 of outputs variance.                               
for i=1:3000 
    z(i,1)=y(i,1)+noise(i,1);
end


end

