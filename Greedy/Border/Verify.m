%{
 验证算法的正确性
 input    map_site      UAV-T的飞行点
          Station_site  地面站位置
          Supply_index  补给点索引
          far_dis       最远飞行距离
          acco_dis      伴飞距离
          df            一个飞行单位的实际距离
 output   res           验证结果
%}
function res = Verify(map_site,Station_site,Supply_index,far_dis,acco_dis,df)
res=false;
m=size(map_site,1);
n=size(Station_site,1);
k=size(Supply_index,1);
single_dis=far_dis-acco_dis;

%% 不需要地面站即可完成巡逻任务
if m-1<=far_dis
    res=(n==0);
    return;
end
error=0.01;          % 允许误差
%% 补给点验证
for i=1:k
    if Supply_index(i,2)-Supply_index(i,1)~=acco_dis
        return;
    end
    
    flag=false;
    s1=map_site(Supply_index(i,1),:);
    s2=map_site(Supply_index(i,2),:);
    MIN_VALUE=[i,0,inf];
    for j=1:n
        GS=Station_site(j,:);
        d=Euclidean_Dis(s1,GS)+Euclidean_Dis(s2,GS);
        if d<=single_dis*df+error
            flag=true;
            break;
        elseif d<MIN_VALUE(3)
            MIN_VALUE=[i,j,d];
        end          
    end
    if ~flag
        fprintf('第 %d 次补给区间无法补给，与其最近的地面站位置是第 %d 个地面站，两个距离为 %f \n',MIN_VALUE(1),MIN_VALUE(2),MIN_VALUE(3));
        return;
    end
end

%% UAV-T 飞行验证
if Supply_index(1,1)~=single_dis+1
    return;
end
for i=2:k
    if Supply_index(i,1)-Supply_index(i-1,2)>single_dis
        return;
    end
end
if m-Supply_index(k,2)>far_dis
    return;
end

res=true;
fprintf('算法执行正确\n')
end

