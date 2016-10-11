clc
clear 
close all

%% ��ͨ PID
% PID ����
kp = 10;
ki = 0.01;
kd = 1;

% PID ���Ʋ���
error = 0;
ts = 0.001;    %����ʱ��
currentCoordinate(1) = 10;    %��ǰ����
time(1) = 0;
move = 0;        %�ƶ�����
sumError = 0;    %����ۼ�

for k = 1:1000
    time(k+1) = ts*k;
    goalCoordinate = 20;
    currentCoordinate(k+1) = currentCoordinate(k) + move;
    
    lastError = error;              %��ǰ���
    sumError = sumError+error;      %������
    error = goalCoordinate - currentCoordinate(k+1);
    rate = error - lastError;
    speed(k) = error * kp + sumError * ki + rate * kd;
    move = speed(k) * ts;
end
speed(k+1)=speed(k);
figure(1)
subplot(2,2,1)
plot(time,currentCoordinate)
title('��ͨPID')
subplot(2,2,2)
plot(time,speed)
title('ת���ٶ�')


clear
%% ����ʽ PID
% PID ����
kp = 40;
ki = 0.01;
kd = 1;

% PID ���Ʋ���
error = 0;
error_1 = 0;
error_2 = 0;
xError=[0,0,0];    %�洢����error
speed(1) = 0;
speed(2) = 0;

ts = 0.001;    %����ʱ��
currentCoordinate(1) = 10;    %��ǰ����
time(1) = 0;
move = 0;        %�ƶ�����
sumError = 0;    %����ۼ�
PIDMaxOutput=7;
PIDMinOutput=1;
for k = 1:1000
    time(k+1) = ts*k;
    goalCoordinate = 20;    %Ŀ������
    dSpeed = xError(1) * kp + xError(2) * ki + xError(3) * kd;%�ٶ�����
    speed(k+1) = speed(k) + dSpeed;
    
    move = speed(k+1) * ts;
    currentCoordinate(k+1) = currentCoordinate(k) + move;
    %����һ��������Χ
%     if currentCoordinate(k+1) >= 10
%         currentCoordinate(k+1) = 10;
%     else currentCoordinate(k+1) <= -10
%         currentCoordinate(k+1) =-10;
%     end
    error = goalCoordinate - currentCoordinate(k+1);
    
    xError(1) = error - error_1;
    xError(2) = error - 2*error_1 + error_2;
    xError(3) = error;
    error_2 = error_1;
    error_1 = error;
end
subplot(2,2,3)
plot(time,currentCoordinate)
title('����ʽPID')
subplot(2,2,4)
plot(time,speed)
title('ת���ٶ�')
