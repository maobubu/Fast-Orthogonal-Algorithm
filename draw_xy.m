figure(1)
subplot(4,1,1),plot(x_in); 
ylabel('x[n]');        
xlabel('n'); 
grid on;
subplot(4,1,2),plot(x_in);hold on,plot(y1,'g');hold off;%axis([1 3000 -2 2]);
ylabel('y1[n]');  
xlabel('x[n]');
grid on;
subplot(4,1,3),plot(x_in);hold on,plot(y2,'g');hold off;%axis([1 3000 -2 2]);
ylabel('y2[n]');  
xlabel('x[n]');
grid on;
subplot(4,1,4),plot(x_in);hold on,plot(y3,'g');hold off;%axis([1 3000 -2 2]);
ylabel('y3[n]');  
xlabel('x[n]');
grid on;