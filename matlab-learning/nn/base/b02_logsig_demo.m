% logsig ����

clear all;clc; 
n = -5 : 0.1 : 5;
a = logsig(n);
plot(n,a);grid on;
xlabel('��������');
ylabel('����S�ʹ�������');