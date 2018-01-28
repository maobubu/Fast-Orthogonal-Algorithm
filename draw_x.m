mu=0;sigma=1;
subplot(2,1,1)
plot(x1,'b');hold on,plot(x2,'g');hold on,plot(x3);hold off,grid on;% x1:1-1000,x2:1001-2000,x32001-3000
subplot(2,1,2)
j=300; %number of Histrogram bins
[f,t]=hist(x,j);
bar(t,f/trapz(t,f)); hold on;
%Theoretical PDF of Gaussian Random Variable
g=(1/(sqrt(2*pi)*sigma))*exp(-((t-mu).^2)/(2*sigma^2));
plot(t,g);hold off; grid on;
title('Theoretical PDF and Simulated Histogram of White Gaussian Noise');
legend('Histogram','Theoretical PDF');
xlabel('Bins');
ylabel('PDF f_x(x)');