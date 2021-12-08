%% 绘制边境线图
close all
clear,clc
% 爱尔兰边境线
load Data/Ireland.mat
data1=Ireland;

% 挪威边境线
load Data/Norway.mat
data2=Norway;

% 巴西边境线
load Data/Brazil.mat
data3=Brazil;

figure 
subplot(221)
plot(data1(:,1),data1(:,2))
title('Ireland')
set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')

subplot(222)
plot(data2(:,1),data2(:,2))
title('Norway')
set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')

subplot(223)
plot(data3(:,1),data3(:,2))
title('Brazil')

set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')