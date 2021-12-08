close all
clear,clc
% 数据量对地面站数量的影响

load('Data/Ireland.mat')
data1=Ireland;
load('Data/Norway.mat')
data2=Norway;
load('Data/Brazil.mat')
data3=Brazil;

% 可设置参数
df=5;                       % 一个飞行单位的距离（相邻点飞行点沿边境线的距离）
far_dis=14;                 % 单个UAV在不受补给的情况下可飞行far_dis个飞行单位
acco_dis=4;                 % 对接补给并伴飞消耗acco_dis个飞行单位
N=500;
flight_num=50:10:460;        % 飞行单位

% 不可设置参数及计算参数
d_data=1;                   % 原始数据相邻点之间的距离（可近似为欧式距离），不可更改，与data紧密相关
ds=df/d_data;               % 采样间隔
if ds~=fix(ds)
    Error('Parameter Error !');
end

% 保证data的初始点是起点，结束点是终点
map_site1=data1(1:ds:end,:);  
map_site2=data2(1:ds:end,:);
map_site3=data3(1:ds:end,:);

out1=zeros(1,length(flight_num));
out2=zeros(1,length(flight_num));
out3=zeros(1,length(flight_num));
% out=zeros(1,length(flight_num));
for i=1:length(flight_num)
    in1=map_site1(1:flight_num(i)+1,:);
    in2=map_site2(1:flight_num(i)+1,:);
    in3=map_site3(1:flight_num(i)+1,:);
    [Station_site1,Supply_index1] = Border_Greedy(far_dis,acco_dis,in1,df,N);
    [Station_site2,Supply_index2] = Border_Greedy(far_dis,acco_dis,in2,df,N);
    [Station_site3,Supply_index3] = Border_Greedy(far_dis,acco_dis,in3,df,N);
    out1(i)=size(Station_site1,1);
    out2(i)=size(Station_site2,1);
    out3(i)=size(Station_site3,1); 
%     out(i)=floor((flight_num(i)-2)/far_dis);
end

figure
hold on 
% h=plot(flight_num,out,'gx-','MarkerSize',5);
% set(h,'MarkerFaceColor',get(h,'color'));
h1=plot(flight_num,out1,'bo-','MarkerSize',5);
set(h1,'MarkerFaceColor',get(h1,'color'));
h2=plot(flight_num,out2,'r^-','MarkerSize',5);
set(h2,'MarkerFaceColor',get(h2,'color'));
h3=plot(flight_num,out3,'ks-','MarkerSize',5);
set(h3,'MarkerFaceColor',get(h3,'color'));

legend('Ireland','Norway','Brazil')

xlabel('\it m')
ylabel('\it n')
hold off 