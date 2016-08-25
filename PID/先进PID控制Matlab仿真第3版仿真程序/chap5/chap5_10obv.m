function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
tol=3.0;
th_tol=u(1);
yp=th_tol;

ut=u(2);
ut_tol=u(3);
z_tol=[x(3);x(4)];
thp_tol=x(3);
thp=x(1);wp=x(2);
%%%%%%%%%%%%%%%%%%%
A=[0 1;-1 -10];
C=[1 0];

H=[0;1];

k1=10;k2=-1;
K=[k1 k2]';
z=[thp wp]';
%%%%%%%%%%%%%%%%%%
E=expm(A*tol);  %EXPM Matrix exponential

dz=A*z+H*ut+E*K*(yp-C*z_tol);
dz_tol=A*z_tol+H*ut_tol+K*(yp-C*z_tol);

for i=1:2
    sys(i)=dz(i);
    sys(i+2)=dz_tol(i);
end
function sys=mdlOutputs(t,x,u)
thp=x(1);wp=x(2);
thp_tol=x(3);wp_tol=x(4);

sys(1)=thp;
sys(2)=wp;
sys(3)=thp_tol;
sys(4)=wp_tol;