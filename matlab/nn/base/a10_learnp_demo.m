% ����learnp�����Ը�֪���������ѵ��,ʵ�֡�����
clear all;
clc;
% ���������Сֵ
err_goal = 0.0015;
% ���ѵ������
max_epoch = 9999;
% ��������
X = [0 1 0 1;0 1 1 0];
% Ŀ������
T = [0 1 1 1];
% ������֪������
net = newp([0 1;0 1],1);
W = rand(1,2);
b = rand;
net.iw{1,1} = W;
net.b{1} = b;

for epoch = 1:max_epoch
    y = sim(net,X);
    E = T - y;
    sse = mae(E);
    if( sse < err_goal)
        break;
    end
    % ѵ��
    dW = learnp(W,X,[],[],[],[],E,[],[],[],[],[]);
    db = learnp(b,ones(1,4),[],[],[],[],E,[],[],[],[],[]);
    % ��������Ĳ���
    W = W + dW;
    b = b + db;
    net.iw{1,1} = W;
    net.b{1} = b;
end
epoch,W,y
