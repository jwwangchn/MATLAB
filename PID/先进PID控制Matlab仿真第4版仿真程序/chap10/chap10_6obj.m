%***********���������������������ͼ�·���ƽ����ֵ֮�͵��Ӻ���*************%
function Object=object(path,distance,flag)  %path,distance��2000ά
global TE G ts
w=0.60;
th_1=0;tol_1=0;e_1=0;
tmax=3*TE; %Ŀ�꺯����������Ϊ3TE
thd=0.5;
thop_1=0;dthop_1=0;
x1_1=0;x2_1=0;
for k=1:1:G   %Begin th(k)��2��ʼ��thop��1����Ӧ

t(k)=k*ts;
    if t(k)<=TE
       thop(k)=path(k); %Ҫ�ƽ������Ź켣
       dthop(k)=(thop(k)-thop_1)/ts;
       ddthop(k)=(dthop(k)-dthop_1)/ts;
    else
        thop(k)=thd;
        dthop(k)=0;
        ddthop(k)=0;        
    end    
    
%��ɢģ��
I=1/133;b=25/133;
d(k)=1*sin(k*ts);

x2(k)=x2_1+ts*1/I*(tol_1-b*x2_1+d(k));
x1(k)=x1_1+ts*x2(k);

th(k)=x1(k); 
dth(k)=x2(k); 

e(k)=thop(k)-th(k);
de(k)=(e(k)-e_1)/ts;         
    
kp=300;kd=0.30;

    tol(k)=kp*e(k)+kd*de(k);
    energy(k)=abs(tol(k)*dth(k));

    tol_1=tol(k);
    x1_1=x1(k);
    x2_1=x2(k);
    e_1=e(k);
    thop_1=thop(k);
    dthop_1=dthop(k);
end 
%************����������******************%
energy_all=0;
for k=1:1:G
    energy_all=energy_all+energy(k);
end
dis=sum(distance);%�ο��켣�ıƽ����
%********����Ŀ��********%
Object=w*energy_all+(1-w)*dis;  %used for main.m
if flag==1
    t(1)=0;
    th0=0;
    for k=1:1:G   %>TE ������ԭ��
        t(k)=k*ts;
    if t(k)<TE
        thr(k)=(thd-th0)*(t(k)/TE-1/(2*pi)*sin(2*pi*t(k)/TE))+th0;   %����ԭ��Ĳο��켣
    else 
        thr(k)=thd;
    end
    end
        figure(1);
        plot(t,thr,'k.-',t,thop,'k',t,th,'k-.','linewidth',2);
        legend('Ideal trajectory','Optimal trajectory', 'Trajectory tracking');
        xlabel('Time (s)');ylabel('Joint angle tracking');
        figure(2);
        plot(t,tol,'k','linewidth',2);
        xlabel('Time (s)');ylabel('Control input,tol');
end
end