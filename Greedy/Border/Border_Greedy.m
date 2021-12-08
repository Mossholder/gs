%{
 贪心算法对地面站进行优化设计
 input     far_dis         最远飞行距离
           acco_dis        伴飞距离
           map_site        边境点(第一个点的数据作为起点，最后一个点作为终点)
           df              一个飞行单位的实际距离
           N               初始化地面站的数量
 output    Station_site    地面站位置
           supply_index    补给点序号 -> 每行数据是补给开始点和结束点的序号
%}
function [Station_site,supply_index]= Border_Greedy(far_dis,acco_dis,map_site,df,N)
%% 基本参数
% 计算值
single_dis=far_dis-acco_dis;        % 单独飞行距离
m=size(map_site,1);                 % 飞行路径上的点数                
n=size(map_site,2);
start_num=single_dis+1;             % 当前地面站补给开始点的序号
finish_num=start_num+far_dis;       % 当前地面站最远补给点的序号

% 初始化
init_num=floor((m-1)/far_dis);      % 地面站的初始化数量
Station_site=zeros(init_num,2);     % 初始化地面站位置
station_cnt=0;                      % 地面站数量
supply_index=zeros(floor((m-1)/acco_dis),2);
supply_cnt=0;                       % 补给次数
global judge;                       % 用于判断每个飞行点是否可以被之前设计好的地面站补给
judge=zeros(m,1);

%% 先决判别
% 补给无人机约束
if single_dis<0
    error('Input Error !')
elseif single_dis<acco_dis
    error('Unable to complete supply !')
% 数据约束
elseif n~=2
    error('Data Error !')
elseif m-1<=far_dis
    disp('Do not need ground station to complete the flight mission !')
    return;
elseif finish_num>=m
    Station_site=map_site(start_num,:);
    supply_index=[start_num,start_num+acco_dis];
    return;
end

%% 寻找一个地面站可实现飞行任务的最远距离
while(true)
    % 焦点坐标
    s1=map_site(start_num,:);
    s2=map_site(start_num+acco_dis,:);
    
    area=Feasible_Region(s1,s2,single_dis*df/2,N);
    [finish_num,Station,update_supply_index]= Local_Optimize(start_num,start_num+acco_dis,Station_site(1:station_cnt,:),area,map_site,single_dis,acco_dis,df);
    
    scnt=size(update_supply_index,1);
    supply_index(supply_cnt+1:supply_cnt+scnt+1,:)=[start_num,start_num+acco_dis;update_supply_index];
    supply_cnt=supply_cnt+scnt+1;
    
%     supply_index(supply_cnt,:)=[start_num,start_num+acco_dis];
%     
%     supply_index(supply_cnt+1:supply_cnt+scnt,:)=update_supply_index;
%     supply_cnt=supply_cnt+scnt;
%     for i=1:scnt
%         supply_cnt=supply_cnt+1;
%         supply_index(supply_cnt,:)=update_supply_index(i,:);
%     end
    
    start_num=finish_num;
    % 随机取Station的一个位置作为最终地面站设计位置
    station_cnt=station_cnt+1;
    rand('state',sum(clock))
    rnd=randi(size(Station,1));
    Station_site(station_cnt,:)=Station(rnd,:);
    
    if finish_num+acco_dis>=m
        break;
    end
end
Station_site=Station_site(1:station_cnt,:);
supply_index=supply_index(1:supply_cnt,:);
end

