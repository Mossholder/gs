% 在边境线上设置地面站，UAV-T资源耗尽时在
clear,clc
close all
df=10;                   % 一个飞行单位的距离（相邻点飞行点沿边境线的距离）
far_dis=14;             % 单个UAV在不受补给的情况下可飞行far_dis个飞行单位
%% 边境线和地面站位置
m=30;                   % 飞行点数
[station,num] = Scenario_1_Fun(far_dis,m,df);
figure
hold on
h=plot((0:m)*df,zeros(1,m+1),'bo','MarkerSize',3);
set(h,'MarkerFaceColor',get(h,'color'));
plot((0:m)*df,zeros(1,m+1),'c-')
h=plot(station,zeros(1,length(station)),'r^','MarkerSize',7);
set(h,'MarkerFaceColor',get(h,'color'));

xlabel('Euclidean Distance')
legend('Flight Point','Border','Ground Station')
x_tick=[0 station m*df];
set(gca,'Xtick',x_tick,'YLim',[-0.5 1],'Ytick',[ ])
hold off

%% 边境线长度和地面站数量的关系图
m1=5:5:100;
m=far_dis*(1:5);
num=zeros(1,length(m));
num1=zeros(1,length(m1));

for i=1:length(m)
    [station,num(i)] = Scenario_1_Fun(far_dis,m(i),df);
    
end
for i=1:length(m1)
    [station1,num1(i)] = Scenario_1_Fun(far_dis,m1(i),df);
end

figure
subplot(211)
w1=plot(m1,num1,'bo-','MarkerSize',5);
set(w1,'MarkerFaceColor',get(w1,'color'));
xlabel('\it m')
ylabel('\it n')
set(gca,'Xtick',m,'YLim',[0 num(end)+1])

subplot(212)
w=plot(m,num,'bo-','MarkerSize',5);
set(w,'MarkerFaceColor',get(w,'color'));
xlabel('\it m')
ylabel('\it n')
set(gca,'Xtick',m,'YLim',[0 num(end)+1])


%% 地面站数量与far_dis关系图
m=500;
far_dis=5:5:100;
n=zeros(1,length(far_dis));
for i=1:length(far_dis)
    n(i)=floor((m-1)/far_dis(i));
end
figure
grid on
w1=plot(far_dis,n,'ro-','MarkerSize',5);
set(w1,'MarkerFaceColor',get(w1,'color'));
xlabel('\it d_{farthest}')
ylabel('\it n')
grid off
