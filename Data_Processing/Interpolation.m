% 插值
function newData = Interpolation(Data,insert)
newData=Data(1,:);
N=length(insert);
if size(Data,1)~=N+1 || size(Data,2)~=2
    error('Input Error !')
end
for i=1:N
    if insert(i)
        x=linspace(Data(i,1),Data(i+1,1),insert(i)+2);
        x=x(2:end);
        y=linspace(Data(i,2),Data(i+1,2),insert(i)+2);
        y=y(2:end);
        newData=[newData;x',y'];
    else
        newData=[newData;Data(i+1,:)];
    end
end

figure
plot(newData(:,1),newData(:,2))
title('插值之后的边境线')
end

