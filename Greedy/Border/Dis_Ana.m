% 相邻两点间距离分析
function Dis_Ana(data)
m=size(data,1);
Distance=zeros(m-1,1);
for i=1:m-1
    s1=data(i,:);
    s2=data(i+1,:);
    Distance(i)=Euclidean_Dis(s1,s2);
end
figure
plot(1:length(Distance),Distance)
set(gca,'yLim',[0 1])

% 检查是否有超过1的距离
check=find(Distance>1);
if(size(check,1)>0)
    error('Input Error !')
end
end

