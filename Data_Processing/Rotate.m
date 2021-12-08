function ret = Rotate(data,angle)
ret=zeros(size(data,1),2);
center=mean(data);
for i=1:size(data,1)
    ret(i,1)=(data(i,1)-center(1))*cos(angle)-(data(i,2)-center(2))*sin(angle)+center(1);
    ret(i,2)=(data(i,1)-center(1))*sin(angle)+(data(i,2)-center(2))*cos(angle)+center(2);
end
end

