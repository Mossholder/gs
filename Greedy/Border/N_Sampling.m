% 地面站数量和采样数的关系
close all
clear,clc
N=[1:2:15 20:10:200];

df=5;                      % 一个飞行单位的距离（相邻点飞行点沿边境线的距离）
far_dis=14;                 % 单个UAV在不受补给的情况下可飞行far_dis个飞行单位
acco_dis=4;                 % 对接补给并伴飞消耗acco_dis个飞行单位

d_data=1;                   % 原始数据相邻点之间的距离（可近似为欧式距离），不可更改，与data紧密相关
ds=df/d_data;               % 采样间隔
if ds~=fix(ds)
    Error('Parameter Error !');
end


load 'Data/Ireland.mat'
map_site=Ireland(1:ds:end,:);  % 飞行点位置数据
IRELAND=zeros(1,length(N));
for i=1:length(N)
    [Station_site,Supply_index] = Border_Greedy(far_dis,acco_dis,map_site,df,N(i));
    IRELAND(i)=size(Station_site,1);
end

load 'Data/Norway.mat'
map_site=Norway(1:ds:end,:);  % 飞行点位置数据
NORWAY=zeros(1,length(N));
for i=1:length(N)
    [Station_site,Supply_index] = Border_Greedy(far_dis,acco_dis,map_site,df,N(i));
    NORWAY(i)=size(Station_site,1);
end

load 'Data/Brazil.mat'
map_site=Brazil(1:ds:end,:);  % 飞行点位置数据
BRAZIL=zeros(1,length(N));
for i=1:length(N)
    [Station_site,Supply_index] = Border_Greedy(far_dis,acco_dis,map_site,df,N(i));
    BRAZIL(i)=size(Station_site,1);
end

figure
hold on
h1=plot(N,IRELAND,'bo-','MarkerSize',5);
set(h1,'MarkerFaceColor',get(h1,'color'));
h2=plot(N,NORWAY,'r^-','MarkerSize',5);
set(h2,'MarkerFaceColor',get(h2,'color'));
h3=plot(N,BRAZIL,'ks-','MarkerSize',5);
set(h3,'MarkerFaceColor',get(h3,'color'));
legend('Ireland border','Norway border','Brazil border')
set(gca,'XTick',0:20:200)
xlabel('\it N')
ylabel('\it n')
% title('')