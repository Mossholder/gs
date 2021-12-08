clc,clear
close all
r=0.5;
N=100;
data=zeros(N,2);
rand('state',sum(clock))
% delta=pi*rand(N-1,1);
delta=pi*linspace(0,1,N-1);
for i=1:N-1
    % delta=8/9*pi*rand(1);
    data(i+1,1)=data(i,1)+r*cos(delta(i));
    data(i+1,2)=data(i,2)+r*sin(delta(i));
end
figure
plot(data(:,1),data(:,2))
save('sim_data1','data')
Distance=Dis_Ana(data);
figure
plot(1:length(Distance),Distance)