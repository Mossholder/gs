function [station,num] = Scenario_1_Fun(far_dis,m,df)
num=floor((m-1)/far_dis);
station=zeros(1,num);
for i=1:num
    station(i)=i*far_dis*df;
end

end

