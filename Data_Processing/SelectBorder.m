%{
                 start           end
中俄边境线        799            6837
中蒙边境线        6837           10260 
中缅边境线        21701          24200  
%}
close all
clear,clc
load Data.mat

figure
hold on
plot(Data(:,1),Data(:,2))
start=21701;
endp=24200;
plot(Data(start,1),Data(start,2),'bo')
plot(Data(endp,1),Data(endp,2),'ko')
hold off

figure
data=Data(start:endp,:);
plot(data(:,1),data(:,2))