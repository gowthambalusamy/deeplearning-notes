% ʹ��newff����BP����

clear all;clc;

X = [1 2;-1 2;2 3];
T = [1 2;2 1];

net = newff(X,T,5);
net = train(net,X,T);

X1 = X;
disp('���������:')
sim(net,X1)