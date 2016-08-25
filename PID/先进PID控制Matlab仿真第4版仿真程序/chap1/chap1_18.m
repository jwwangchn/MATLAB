%PID Controller with Partial differential
clear all;
close all;

ts=0.001;
sys=tf(5.235e005,[1,87.35,1.047e004,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;
y_1=0;y_2=0;y_3=0;
yn_1=0;
error_1=0;error_2=0;ei=0;

kp=0.20;ki=0.05;

sys1=tf([1],[0.04,1]);   %Low Freq Signal Filter
dsys1=c2d(sys1,ts,'tustin');
[num1,den1]=tfdata(dsys1,'v');
f_1=0;

M=3;
for k=1:1:1000
time(k)=k*ts;

yd(k)=20;  %Step Signal
%Linear model
y(k)=-den(2)*y_1-den(3)*y_2-den(4)*y_3+num(2)*u_1+num(3)*u_2+num(4)*u_3;
     
if M==1                 %No noisy signal
   error(k)=yd(k)-y(k); 
   filty(k)=y(k);
end

n(k)=5.0*rands(1);      %Noisy signal
yn(k)=y(k)+n(k);

if M==2                 %No filter
   filty(k)=yn(k);
   error(k)=yd(k)-filty(k);
end
if M==3                 %Using low frequency filter
   filty(k)=-den1(2)*f_1+num1(1)*(yn(k)+yn_1);
   error(k)=yd(k)-filty(k);
end

%I separation
if abs(error(k))<=0.8
   ei=ei+error(k)*ts;
else
   ei=0;
end
   u(k)=kp*error(k)+ki*ei;
%----------Return of PID parameters------------
yd_1=yd(k);
u_5=u_4;u_4=u_3;u_3=u_2;u_2=u_1;u_1=u(k);   
y_3=y_2;y_2=y_1;y_1=y(k);

f_1=filty(k);
yn_1=yn(k);

error_2=error_1;
error_1=error(k);
end
figure(1);
subplot(211);
plot(time,yd,'r',time,filty,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
subplot(212);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('u');
figure(2);
plot(time,n,'r','linewidth',2);
xlabel('time(s)');ylabel('Noisy signal');