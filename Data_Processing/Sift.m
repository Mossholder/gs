% 筛选出与均值相差较大的点的索引
function [index,average] = Sift(Distance)
fprintf('处理前Distance有 %d 个数据 \n',length(Distance));
error=1;            % 误差--主要参数
temp=Distance;

index=[];
flag=true;
while flag
    average=mean(temp);
    [maxx,in]=max(temp);
    if(abs(maxx-average)<=error)
        flag=false;
    else
        temp(in)=[];
        index=[index find(Distance==maxx)];
    end
end

figure
num=length(temp);
average=mean(temp);
plot(1:num,temp)
title('删除不合理点之后的距离分布')

fprintf('处理后Distance有 %d 个数据 \n',num)
fprintf('处理后Distance的均值为 %d \n',average)
fprintf('处理后index数组应该有 %d 个数据 \n',length(Distance)-num)
end

