%{
 function 以s1和s2为焦点的椭圆区域
 input        s1,s2        椭圆焦点
              a            长轴的一半
              N            取样点数
 output       area         可行区域中的点
%}

function area = Feasible_Region(s1,s2,a,N)

if length(s1)~=2 || length(s2)~=2
    error('Input Error !');
end
center=(s1+s2)/2;           % 中心点
c=Euclidean_Dis(s1,s2)/2;   % 焦距的一半
if c>=a
    error('Parameter Error!');
end
b=sqrt(a^2-c^2);            % 短轴的一半
area=zeros(N,2);

% 椭圆内随机取点
rand('state',sum(clock))
t=2*pi * rand(N-2,1);
d = sqrt(rand(N-2,1));
x = center(1) + a * d .* cos(t);
y = center(2) + b * d .* sin(t);

% 保证每次可以取到长轴上的两个顶点
x=[x;center(1)+a;center(1)-a];
y=[y;center(2);center(2)];

% 旋转
tan_value=(s2(2)-s1(2))/(s2(1)-s1(1));
angle=atan(tan_value);
for i=1:N
    area(i,1)=(x(i)-center(1))*cos(angle)-(y(i)-center(2))*sin(angle)+center(1);
    area(i,2)=(x(i)-center(1))*sin(angle)+(y(i)-center(2))*cos(angle)+center(2);
end
end

