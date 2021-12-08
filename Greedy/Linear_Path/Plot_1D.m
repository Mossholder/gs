%{
 input     path_dis        UAV-T 路径
           Station_site    地面站位置   
           acco_index      伴飞索引矩阵
           df              采样间隔
%}
function Plot_1D(path_dis,Station_site,acco_index,df)
figure
hold on
title('Linear Path')
xlabel('Distance')
% dx=0.1;

%% UAV-T 飞行路径
x=0:path_dis*df;
y=zeros(1,length(x));
plot(x,y,'b')

%% 地面站位置
y=zeros(1,length(Station_site));
w=plot(Station_site,y,'k^');
set(w,'MarkerFaceColor',get(w,'color'));
%% 伴飞路径
cnt=size(acco_index,1);
x_tick=zeros(1,2*cnt);          % 坐标标识
for i=1:cnt
    x_tick(2*i-1)=acco_index(i,1)*df;
    x_tick(2*i)=acco_index(i,2)*df;
    x=(acco_index(i,1):acco_index(i,2))*df;
    y=zeros(1,length(x));
    plot(x,y,'r','linewidth',4)
end
x_tick=[0 x_tick path_dis*df];
set(gca,'Xtick',x_tick,'YLim',[-0.1 1],'Ytick',[ ])
xtickangle(45)
legend('UAV-T','Ground Station','UAV-T + UAV-R')

hold off
end