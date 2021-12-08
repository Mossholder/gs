far_dis=14;
acco_dis=4;
df=5;
m=50:10:450;
len=length(m);
out1=zeros(1,len);
out2=zeros(1,len);
for i=1:len
    out1(i)=floor((m(i)-1)/far_dis);
    [acco_index,Station_site] = Linear_Greedy(far_dis,acco_dis,m(i),df);
    out2(i)=size(Station_site,1);
end
figure 
hold on
h1=plot(m,out1,'bo-','MarkerSize',5);
set(h1,'MarkerFaceColor',get(h1,'color'));
h2=plot(m,out2,'r^-','MarkerSize',5);
set(h2,'MarkerFaceColor',get(h2,'color'));
legend('Without UAV-R','Greedy')

xlabel('\it m')
ylabel('\it n')
hold off 