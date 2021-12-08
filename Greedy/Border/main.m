%{
  飞行点是在边境线上等间隔取得，相邻飞行点沿路径的的长度是相等的，但是欧氏距离不一定相等
  假定原始数据相邻点的欧式距离一致，飞行点可在原始距离上对其进行采样而得
%}
close all
clear,clc
%% 设置参数
df=5;                      % 一个飞行单位的距离（相邻点飞行点沿边境线的距离）
far_dis=14;                 % 单个UAV在不受补给的情况下可飞行far_dis个飞行单位
acco_dis=4;                 % 对接补给并伴飞消耗acco_dis个飞行单位
N=500;

%% 导入边境数据
% 中俄边境线
% load Data/China_Russia.mat       
% data=China_Russia;

% 中蒙边境线
% load Data/China_Mongolia.mat
% data=China_Mongolia;

% 中缅边境线
% load Data/China_Myanmar.mat
% data=China_Myanmar;

% 爱尔兰边境线
% load Data/Ireland.mat
% data=Ireland;

% 挪威边境线
% load Data/Norway.mat
% data=Norway;

% 巴西边境线
load Data/Brazil.mat
data=Brazil;

%% 数据处理
% 输入数据分析
% Dis_Ana(data);

% 调整坐标
xmin=min(data(:,1));
ymin=min(data(:,2));
data=data-ones(size(data,1),1)*[xmin-1 ymin-1];

% 不可设置参数及计算参数
d_data=1;                   % 原始数据相邻点之间的距离（可近似为欧式距离），不可更改，与data紧密相关
ds=df/d_data;               % 采样间隔
if ds~=fix(ds)
    Error('Parameter Error !');
end
% 保证data的初始点是起点，结束点是终点
map_site=data(1:ds:end,:);  % 飞行点位置数据
data=data(1:(size(map_site,1)-1)*ds+1,:);

%% 算法部分
tic
% 执行算法
[Station_site,Supply_index] = Border_Greedy(far_dis,acco_dis,map_site,df,N);
% 验证算法正确性
correctness=Verify(map_site,Station_site,Supply_index,far_dis,acco_dis,df);
% 绘图
Plot_2D(data,map_site,Station_site,Supply_index,ds);
toc
