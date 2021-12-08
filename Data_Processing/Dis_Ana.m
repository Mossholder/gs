% 相邻两点间距离分析
function Distance=Dis_Ana(data)
m=size(data,1);
Distance=zeros(m-1,1);
for i=1:m-1
    s1=data(i,:);
    s2=data(i+1,:);
    Distance(i)=Euclidean_Dis(s1,s2);
end
end

