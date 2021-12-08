clear,clc
close all
%% 1D Linear Path
far_dis=14;
acco_dis=4;
path_dis=150;
df=1;
[acco_index,Station_site]=Linear_Greedy(far_dis,acco_dis,path_dis,df);
%% 绘图
Plot_1D(path_dis,Station_site,acco_index,df)

%% 与far_dis的关系图
far_dis=10:2:100;
acco_dis=4;
path_dis=150;
df=1;
n=length(far_dis);
num=zeros(1,n);
for i=1:n
    [acco_index,Station_site]=Linear_Greedy(far_dis(i),acco_dis,path_dis,df);
    num(i)=size(Station_site,1);
end
figure
h=plot(far_dis,num,'ro-','MarkerSize',3);
set(h,'MarkerFaceColor',get(h,'color'));
xlabel('\it d_{farthest}')
ylabel('\it n')

%% 与path_dis的关系图
far_dis=14;
acco_dis=4;
path_dis=20:5:150;
df=1;
n=length(path_dis);
num=zeros(1,n);
for i=1:n
    [acco_index,Station_site]=Linear_Greedy(far_dis,acco_dis,path_dis(i),df);
    num(i)=size(Station_site,1);
end
figure
h=plot(path_dis,num,'ro-','MarkerSize',3);
set(h,'MarkerFaceColor',get(h,'color'));
xlabel('\it m')
ylabel('\it n')
