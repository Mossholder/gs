%{
 input     far_dis         最远飞行距离
           acco_dis        伴飞距离
           path_dis        路径距离
           df              采样间隔
 output    Station_site    地面站位置
           acco_index      伴飞索引矩阵
%}
function [acco_index,Station_site] = Linear_Greedy(far_dis,acco_dis,path_dis,df)
single_dis=far_dis-acco_dis;        % 单独飞行距离
%% 补给无人机约束
if single_dis<0
    error('Input Error !')
elseif single_dis<acco_dis
    error('Unable to complete supply !')
else
    if path_dis<=far_dis
        Station_site=[];
        acco_index=[];
        return;
    end
    total_dis=single_dis+far_dis;
    n=ceil((path_dis-far_dis)/total_dis);
    Station_site=zeros(n,1);
    acco_index=zeros(n*2,2);
    for i=1:n
        Station_site(i)=i*total_dis-1/2*far_dis;
        acco_index((i-1)*2+1,1)=Station_site(i)-1/2*far_dis;
        acco_index((i-1)*2+1,2)=acco_index((i-1)*2+1,1)+acco_dis;
        acco_index((i-1)*2+2,2)=Station_site(i)+1/2*far_dis;
        acco_index((i-1)*2+2,1)=acco_index((i-1)*2+2,2)-acco_dis;
        Station_site(i)=Station_site(i)*df;
    end
    if path_dis-acco_index(2*n-1,2)<=far_dis
        acco_index=acco_index(1:2*n-1,:);
    end
    fprintf('需要 %d 个地面站',n)

end
end