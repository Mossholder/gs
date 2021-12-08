clc,clear
close all
xCenter = 15;
yCenter = 10;
xRadius = 5;
yRadius = 1;
N = 1000000;

% Generate points in the ellipse
figure
t = 2*pi * rand(N,1);
d = sqrt(rand(N,1));
x = xCenter + xRadius * d .* cos(t);
y = yCenter + yRadius * d .* sin(t);
plot(x,y,'o')
axis([11,19,6,14])

figure
angle=pi/4;
rx=xCenter;
ry=yCenter;
rotate_x=zeros(1,length(x));
rotate_y=zeros(1,length(y));
for i=1:length(y)
    rotate_x(i)=(x(i)-rx)*cos(angle)-(y(i)-ry)*sin(angle)+rx;
    rotate_y(i)=(x(i)-rx)*sin(angle)+(y(i)-ry)*cos(angle)+ry;
end
plot(rotate_x,rotate_y)