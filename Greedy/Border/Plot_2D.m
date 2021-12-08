%{
 input     data            原始数据
           map_site        飞行点数据
           Station_site    地面站位置
           Supply_index    补给点序号
           ds              map_site相对于data的采样间隔
%}
function Plot_2D (data,map_site,Station_site,Supply_index,ds)
figure
hold on

title('Border Patrol')
xlabel('x')
ylabel('y')
xmin=min(data(:,1));
ymin=min(data(:,2));
xmax=max(data(:,1));
ymax=max(data(:,2));
x=xmax-xmin;
y=ymax-ymin;
cnt=8;
if y>x
    temp=floor(y/x);
    axis([xmin-temp*x/cnt xmax+temp*x/cnt ymin ymax])
else
    temp=floor(x/y);
    axis([xmin xmax ymin-y*temp/cnt ymax+y*temp/cnt])
end

%% 边境线绘制
plot(data(:,1),data(:,2),'g-')
%% UAV-T 飞行点
h1=plot(map_site(:,1),map_site(:,2),'bo','MarkerSize',3);
set(h1,'MarkerFaceColor',get(h1,'color'));
%% 地面站位置
h=plot(Station_site(:,1),Station_site(:,2),'k^','MarkerSize',7);
set(h,'MarkerFaceColor',get(h,'color'));
%% 伴飞路径
cnt=size(Supply_index,1);
for i=1:cnt
    % plot(map_site(Supply_index(i,1):Supply_index(i,2),1),map_site(Supply_index(i,1):Supply_index(i,2),2),'r','linewidth',2);
    start=(Supply_index(i,1)-1)*ds+1;
    fini=(Supply_index(i,2)-1)*ds+1;
    plot(data(start:fini,1),data(start:fini,2),'r-','linewidth',3)
end

legend('Border','UAV-T','Ground Station','UAV-T + UAV-R')
hold off
end

