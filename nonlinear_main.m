clc ;
clear all;
%% Initial.Generate input x[n], generate 3 systems and out put y[n].
N=3000;%3000white gausian noise,mean 0, var 1
x0=white_in(N);% generate white gaussian noise.
x1=sin_in(N);% generate Sin wave signal.
x2=tria_in(N);% generate Triangular signal. requires the signal processing
%tool box
x3=uni_in(N);%generate white uniform noise.
x_in=x0;%input data can be changed from x0 to x3, each represent a input
y1=fun3(N,x_in);% output after go through the  nonlinear system,function 1
y2=fun2(N,x_in);%function 3
y3=fun3(N,x_in);% function 2
y_ture=fun3(N,x_in);% true output data, can be changed by changing the function.
draw_xy;% draw some figures
%% start the main part
P=[0,25,50,100];% set P to 0,25,50,100
for j=1:length(P)
    
    clear am;
    clear Pm_n_best;
disp(['For P equals to ',num2str(P(j)),'  ====================================']);
y_noise=add_noise(y_ture,P(j),N);% add a white gaussian noise to the output. refers to W[n]
%% Use the first 1000 sample to find the best model for the system
order=3;% set order to 3.
rng(2);% remember the random number, only use for testing 
K = randi([5,6], 10, 1);% generate random integer number for K and L, range from 7 to 15.
rng(3);
L = randi([5,6], 10, 1);% the randominteger can be changed to what ever number,
                        % but it will affect the computation speed if it's too big.
    for i = 1:length(K)
         N0 = max(K(i),L(i));
         disp(['For model ',num2str(i),' +_+_+_+_+_+_+_+_+_+_+_+_+']);
         fprintf('Choosen K:%d L:%d\n',K(i),L(i));
         tic  % apply FOS algorithm for the first 1000 sample to find the best model.
         [am{i}, pm_n_best{i}] = FOS_algorithm( x_in(1:(N/3)), y_noise(1:(N/3)), K(i), L(i), order );%Pm_n_best is a structure to store the
         y_final=generate_func(pm_n_best{i},am{i},x_in(1:(N/3)),y_noise(1:(N/3)));
         temp =y_noise(1:(N/3))-y_final;
         MSE_first_1000(i) = mean(temp(N0+1:(N/3)).^2)/var(y_noise(N0+1:(N/3))) *100;
         toc      %best candidates for each term. Ass x from 1 to 1000 into the FOS algorithm, the algorithm will calculate the mean from N0+1 to N.
    end
%% Use the 1001-2000 number to calculate the MSE for 10 different models and select the best model.
    for i=1:length(K)
        N0 = max(K(i),L(i));
        y_final=generate_func(pm_n_best{i},am{i},x_in((N/3)+1:(N/3)*2),y_noise((N/3)+1:(N/3)*2));%from 1001 to 2000.
        temp =y_noise((N/3)+1:(N/3)*2)-y_final;% y_noise refers to W[n] for noisy signal or Z[n] for noise free signal.
        %y_noise uses the value from the previous 1000 to calculate the, first few values from 1000 to 2000, but y_final doesn't use any
        %previous value, so it is not accurate to calculate the mean and MSE from 1001 to 2000, instead, I should use 1001+N0 to 2000.
        MSE_percent(i) = mean(temp(N0+1:(N/3)).^2)/var(y_noise((N/3)+N0+1:(N/3)*2)) *100;
    end
    
index = find(MSE_percent == min(MSE_percent));% find the smallest MSE_percent
a_fselect = am{index(1)};% put the coefficient of the best model into a struct
p_fselect = pm_n_best{index(1)};%  put the term of the best model into a struct
%% Use the 2001-3000 sample to compare the final model with the original output y[n](not the w[n])
y_final = generate_func(p_fselect, a_fselect, x_in(2*N/3+1:N),y_noise(2*N/3+1:N)); % from 2001 to 3000 
temp =y_ture(2*(N/3)+1:N)-y_final;% same reason as above
MSE_final_percent= mean(temp(N0+1:N/3).^2)/var(y_ture(2*(N/3)+N0+1:N)) *100;% final MSE percent, compared with original signal
temp =y_noise(2*(N/3)+1:N)-y_final;
MSEpercent1 = mean(temp(N0+1:N/3).^2)/var(y_noise(2*(N/3)+N0+1:N)) *100;% testing MSE Percent, compared with noise signal
Ideal_MSE_percent=100*P(j)/(100+P(j));
%% print the results to command window 
fprintf('the final equation is: \n');
print_equation(a_fselect,p_fselect);% print the equation in the command window(Only works well for the non-linear equation)
fprintf('The Ideal MSE is %f %%. \n',Ideal_MSE_percent)% print the ideal MSE
fprintf('Print the first 1000 points MSE perent(1-1000): \n')
fprintf(1,'%.3f%% ',MSE_first_1000);% print all the first 1000 points MSE_percent. 
fprintf('\n');
fprintf('Print the second 1000 points MSE perent(1001-2000): \n')
fprintf(1,'%.3f%% ',MSE_percent);% print all the second 1000 points MSE_percent.
fprintf('\n');
fprintf('The final MSE is %.3f %%. \n',MSE_final_percent)% print the final MSE Percent
fprintf('The testing MSE is %.3f %%.',MSEpercent1)% print the testing MSE
%% Compare the original out put with the final model output from 1--3000 points
% draw the figures, each corresponding P will have 2 figures.
y_compare = generate_func(p_fselect, a_fselect, x_in(1:N),y_noise(1:N)); % from 1 to 3000 
figure(2+j)
plot(y_ture,'--r');hold on,plot(y_compare);hold off;
title(['compare the generated y[n] with the original y[n], when P=',num2str(P(j))])
xlabel('n');
ylabel('y[n]');
legend('y3', 'y_compare');
grid on;
figure(6+j)
plot(y_ture,'--r');hold on,plot(y_compare);hold off;axis([1000 1100 -10 10]);
title(['compare the generated y[n] with the original y[n], when P=',num2str(P(j))])
xlabel('n');
ylabel('y[n]');
legend('y3', 'y_compare');
grid on;
end