%{
 *********************局部最优，尽可能让T-UAV在一个地面站的补给下飞最远距离*********************
 input     start_LastSupply    上次补给的开始点
           end_iteration       迭代过程中的结束点
           built_station       已经建好的地面站
           area                在start_LastSupply补给时地面站位置的可行域(默认非空)
           map_site            边境线数据
           single_dis          UAV单独飞行距离
           acco_dis            伴飞距离
           df                  一个飞行单位的实际距离
 output    farthest            地面站设置在area可行域内时T-UAV可飞行的最远地点
           Station             可使UAV-T飞最远的地面站设计位置
           supply_index        补给点的序号
%}
function [farthest,Station,supply_index]= Local_Optimize(start_LastSupply,end_iteration,built_station,area,map_site,single_dis,acco_dis,df)
farthest=start_LastSupply+single_dis+acco_dis;
m=size(map_site,1);
n=size(area,1);
Station=area;
supply_index=[];

%% 终止条件
% 完成飞行任务
if farthest+acco_dis>=m
    farthest=m;
    return;
end

global judge;           % 用于优化程序，减小程序的计算复杂度
for i=start_LastSupply+acco_dis+single_dis:-1:end_iteration
%% 若已经建立的地面站可以对第i个点进行补给,不对可行区域进行缩小
    flag=false;             % 标记是否需要对可行域进行缩小（false时需要，true时不需要）
    if judge(i)
        flag=true;
    else
        for j=size(built_station,1):-1:1
            if Euclidean_Dis(map_site(i,:),built_station(j,:))+Euclidean_Dis(map_site(i+acco_dis,:),built_station(j,:))<=single_dis*df
                flag=true;
                judge(i)=1;
                break;
            end
        end
    end
    
    if flag
%% 在第i个点处开始进行下一次补给时地面站的可行域不变 
        [next_farthest,next_Station,next_supply_site] = Local_Optimize(i,max(start_LastSupply+acco_dis+single_dis,i+acco_dis),built_station,area,map_site,single_dis,acco_dis,df);
        if(next_farthest>farthest)
            supply_index=[i,i+acco_dis;next_supply_site];
            farthest=next_farthest;
            Station=next_Station;
            % 寻找到一种到达终点的方案即可
            if farthest==m 
                return;
            end
        end

    else
%% 在第i个点处开始进行下一次补给时地面站的可行域缩小      
        feasible_area=zeros(n,size(area,2));
        cnt=0;
        for j=1:n
            if Euclidean_Dis(map_site(i,:),area(j,:))+Euclidean_Dis(map_site(i+acco_dis,:),area(j,:))<=single_dis*df
                cnt=cnt+1;
                feasible_area(cnt,:)=area(j,:);
            end
        end
        feasible_area=feasible_area(1:cnt,:);
        
        if(size(feasible_area,1)>0)
            [next_farthest,next_Station,next_supply_site] = Local_Optimize(i,max(start_LastSupply+acco_dis+single_dis,i+acco_dis),built_station,feasible_area,map_site,single_dis,acco_dis,df);
            if(next_farthest>farthest)
                supply_index=[i,i+acco_dis;next_supply_site];
                farthest=next_farthest;
                Station=next_Station;
                % 寻找到一种到达终点的方案即可
                if farthest==m 
                    return;
                end
            end        
        end   
    end
end
end