% ���þ����������ʵ�ֺ����ƽ�

clear all;clc;

x = -1 : 0.1 : 1;
T = cos(x * pi);
n = -3 : 0.1 : 3;
% �������Ԫ���ݺ���
a1 = radbas(n);
a2 = radbas(n - 1.2);
a3 = radbas(n + 2);

a = a1 + 1.2 * a2 + 0.6 * a3;
plot(n,a1,'+',n,a2,':',n,a3,n,a,'p');
xlabel('��������');
ylabel('��Ȩ����');
legend('�������Ȩ�� a1','�������Ȩ�� a2','�������Ȩ�� a3','�������Ȩ�� a')

net = newrb(x,T,0.025,1);
x1 = -1 : 0.01 : 1;
y = sim(net,x1)
figure;
plot(x1,y,x,T,'o')
legend('�����ƽ�����','ԭ����')