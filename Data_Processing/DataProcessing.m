close all
clear,clc
% load China_Russia.mat
% data=China_Russia*100;

% load China_Myanmar.mat
% data=China_Myanmar*100;
data=load('Norway.dat');

%% 绘制处理前的边境线
figure
plot(data(:,1),data(:,2))
title('原始边境线')

%% 边境线相邻点的欧式距离
Distance=Dis_Ana(data);
figure
plot(1:length(Distance),Distance)
title('处理之前数据距离分布')

%% 筛选不合适的数据
[index,average] = Sift(Distance);         % 通过平均值筛选

% 标记处筛选出来的数据
figure
hold on 
plot(1:length(Distance),Distance)
for i=1:length(index)
    plot(index(i),Distance(index(i)),'bo')
end
title('距离分布')
legend('原数据','需修改的数据')
hold off

%% 插值
N=size(data,1)-1;
% 数据之间插入的点数
insert=zeros(N,1);
for i=1:N
    insert(i)=ceil(Distance(i)/average)+500;
end
newData = Interpolation(data,insert);

newDistance=Dis_Ana(newData);
figure
plot(1:length(newDistance),newDistance)
title('插值后的数据距离分布')

%% 生成最终的数据
n_new=size(newData,1);
FinalData=zeros(n_new,2);
FinalData(1,:)=newData(1,:);
cnt=1;
start=1;
finish=2;
while(finish<=n_new && start<=n_new)
    s1=newData(start,:);
    s2=newData(finish,:);
    if Euclidean_Dis(s1,s2)<=1
        finish=finish+1;
    else
        cnt=cnt+1;
        FinalData(cnt,:)=newData(finish-1,:);
        start=finish-1;
    end
end
FinalData=FinalData(1:cnt,:);

FinalDistance=Dis_Ana(FinalData);
check=find(FinalDistance>1)
figure
plot(FinalData(:,1),FinalData(:,2))
title('最终边境线')
figure
plot(1:length(FinalDistance),FinalDistance)
set(gca,'YLim',[0 1])
title('最终数据距离分布')
