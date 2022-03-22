clc;
clear;
close all;

load 'data.mat';
%  样本总数
n=length(allpts);
%  聚类的簇数
k = 2;
% 高斯尺度参数
sigsq = 0.15;

%  获取距离矩阵
euclidean_distance = pdist(allpts);
dist_matrix = squareform(euclidean_distance);

% 邻域半径
epsilon = Get_Epsilon(n,euclidean_distance,dist_matrix);

%   获的邻接矩阵 W
W_ = exp(-dist_matrix ./ (2 * sigsq * sigsq * CNN(n,dist_matrix,epsilon)));
W = W_ - diag(diag(W_));

%  获得度矩阵
D = diag(sum(W));
%   获得拉普拉斯矩阵
L = D^(-.5) * (D - W) * D^(-.5);

% V has matrix of all eigenvectors unarranged and Value has unsorted eigenvalues
[Vector,Value] = eig(L);
% sort V eigenvectors and Value eigenvalues from smallest to largest   
[d,ind] = sort(diag(Value));
Values = Value(ind,ind);
Vs = Vector(:,ind);
% First K columns of V need to be clustered
V = Vs(:,1:k);
U = zeros(size(V));
% Regularization operation
for i = 1:n
    for j = 1:k
        U(i,j) = V(i,j) / norm(V(i,:));
    end
end

labels = kmeans(U,k);

d1 = zeros(2,n);
d2 = zeros(2,n);

% 画图展示分类结果
for i = 1:n
    if labels(i)==1
        d1(:,i) = allpts(i,:)';
    else
        d2(:,i) = allpts(i,:)';
    end
end
d1(find(d1==0))=[];
d2(find(d2==0))=[];
reshape_d1 = reshape(d1,2,[]);
reshape_d2 = reshape(d2,2,[]);
plot(reshape_d1(1,:),reshape_d1(2,:),'rx');
hold on
plot(reshape_d2(1,:),reshape_d2(2,:),'gx');



function count = CNN(n,dist_matrix,epsilon)
    leq_epsilon = (dist_matrix <= epsilon);
    count = zeros(n);
    for i = 1:n
        for j = 1:n
            count(i,j) = sum(leq_epsilon(i,:) & leq_epsilon(j,:))+1;
        end
    end
end

function epsilon = Get_Epsilon(n,euclidean_distance,dist_matrix)
    % 从小到大排序
    order_euclidean_distance = sort(euclidean_distance);
    min_d = order_euclidean_distance(1);
    max_d = order_euclidean_distance(length(euclidean_distance));
    mean_d = sum(euclidean_distance) / length(euclidean_distance);
    
    % 把每一行内的数据从小到大排序
    order_dist_matrix = sort(dist_matrix, 2);
    % 从最近邻里寻找最大值和均值
    nearest_neighbor = sort(order_dist_matrix(:,2));
    max_n = nearest_neighbor(n);
    mean_n = sum(nearest_neighbor) / n;
    epsilon = 20 * mean_d + 54 * min_d + 13 - max_n - 6 * max_d - 65 * mean_n;
end