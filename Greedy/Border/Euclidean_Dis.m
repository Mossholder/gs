%{
 function 求两点间欧式距离
 input    s1,s2       两点坐标
 output   distance    欧式距离
%}

function distance = Euclidean_Dis(s1,s2)
if length(s1)~=2 || length(s2)~=2
    error('Input Error !');
end 
distance=sqrt((s1(1)-s2(1))^2+(s1(2)-s2(2))^2);
% % 截取小数点后四位
% distance=roundn(distance,-4);
end