close all
clc,clear
df=10;
far_dis=14;


data=load('Ireland.dat');

d_data=1; 
ds=df/d_data;
map_site=data(1:ds:end,:);
data=data(1:(size(map_site,1)-1)*ds+1,:);
m=size(map_site,1)-1;

if m<=far_dis
    Station_site=[]
else
    n=floor((m-1)/far_dis);
    Station_site=zeros(n,2);
    for i=1:n
        index=i*far_dis+1;
        Station_site(i,:)=map_site(index,:);
    end
    Station_site
end

figure
hold on
title('Ireland Border Patrol')
xlabel('x')
ylabel('y')
plot(data(:,1),data(:,2),'g-');
h1=plot(map_site(:,1),map_site(:,2),'bo','MarkerSize',3);
set(h1,'MarkerFaceColor',get(h1,'color'));
h=plot(Station_site(:,1),Station_site(:,2),'k^','MarkerSize',7);
set(h,'MarkerFaceColor',get(h,'color'));
legend('Border','Flight Point','Ground Station')
hold off

    