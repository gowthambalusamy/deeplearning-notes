% ʵ��һ���������
clear all;
clc;
P = [0 0 1 1;0 1 0 1];
T = [0 1 1 1];

% ����һ����֪������,ȨֵΪ1
net = newp(minmax(P),1);
% �������,ѵ��ǰ�����
disp('before train:')
Y = sim(net,P)
% ����ѵ����������
net.trainParam.epochs = 20;
net = train(net,P,T);
disp('after train:')
Y = sim(net,P)
% ���������������
err1 = mae(Y-T)
plotpv(P,T)
title('�������')
