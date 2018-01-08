%% ��������
clear all;
clc;
% ��������������Ŀ�꺯��
P = [-0.5 -0.5 0.3 -0.1 -0.8;...,
     -0.5 0.5 -0.5 1.0 0.0];
T = [1 1 0 0 0];
 % ����������
 plotpv(P,T);
 
 % ����������
 net = newp([-40 1;-1 50],1);
 
 hold on
 % ���طֽ��߿ص�
 linehandle = plotpc(net.IW{1},net.b{1});
 net.adaptParam.passes = 3;
 linehandle = plotpc(net.IW{1},net.b{1});
 
 % ѵ��������
 for a = 1 : 25
     [net,Y,E] = adapt(net,P,T);
     linehandle = plotpc(net.IW{1},net.b{1},linehandle);
     drawnow;
 end
 title('�������')
 