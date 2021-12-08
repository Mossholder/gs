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
tmp=s2-s1;
theta=atan(tmp(2)/tmp(1));
% 旋转矩阵
R=[cos(theta),-sin(theta);...
   sin(theta),cos(theta)];

% 单位圆内采样
rand('state',sum(clock));
circle_rnd=rand(N,2);
small=min(circle_rnd,[],2);
large=max(circle_rnd,[],2);
angle=2*pi*(small./large);
circle_rnd=large.*[cos(angle),sin(angle)];

% 单位圆 -> 椭圆
L=diag([a,b]);
area=circle_rnd*L*R'+center;

end

