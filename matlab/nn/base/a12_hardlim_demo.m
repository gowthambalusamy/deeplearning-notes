% ʹ��hardlim����ѵ����֪������
% ʵ�֡����� 
clear all;clc;

% �������ֵ
err_goal = 0.0015;
% ����������
max_epoch = 5000;

X = [0 0 1 1;0 1 1 0];
T = [0 1 1 1];

[M,N] = size(X);
[L,N] = size(T);

Wij = rand(L,M);
b1 = zeros(L,1)

for epoch = 1 : max_epoch
    net = netsum(Wij * X,b1);
    y = hardlim(net);
    E = T - y;
    sse = mae(E);
    if(sse < err_goal)
        break;
    end
    Wij = Wij + E * X';
    b1 = b1 + E;
end
X1 = X
epoch,Wij
net = netsum(Wij * X1,b1);
y = hardlim(net)