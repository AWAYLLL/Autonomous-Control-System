%clear all
dis = 25;
A = 25;
B = -5*sqrt(3);
C = dis*0.42435;
plane_C1 = {[0,0+C,1],[B+C,A,2],[B,-1*A,-3],[2*B+C,2*A+C,-1],[2*B+C,0,1.5],[2*B+C,-2*A+C,0.2],[3*B-C,3*A-C,0],[3*B,A+C,1],[3*B+C,-1*A+C,1.5],[3*B+C,-3*A,-2]};
planepr = {[0,0,0],[B,A,0],[B,-1*A,0],[2*B,2*A,0],[2*B,0,0],[2*B,-2*A,0],[3*B,3*A,0],[3*B,A,0],[3*B,-1*A,0],[3*B,-3*A,0]};
test1 = {[1,2,3],[2,4,5],[3,5,6]};
train1 = {[4,5,6],[7,8,9],[8,9,10]};
test2 = {[7,8,4],[8,9,5],[4,5,2]};
train2 = {[9,5,2],[10,6,3],[6,3,1]};
test3 = {[10,6,9],[6,3,5],[9,5,8]};
train3 = {[3,5,8],[1,2,4],[2,4,7]};
num = 3;
print_C1 = picture(plane_C1);
print_pr = picture(planepr);

print_C1x = print_C1{1};
print_C1y = print_C1{2};
print_C1z = print_C1{3};
print_prx = print_pr{1};
print_pry = print_pr{2};
print_prz = print_pr{3};

% for i = 1:1:num
% plane = trian(test1,train1,plane_C1,planepr);
% plane = trian(test2,train2,plane,planepr);
% plane = trian(test3,train3,plane,planepr);
% end

plane = plane_C1;
cishu = 1;
number = 1;
mistake_C1 = {};
plane_C111T = {};
for u=1:1:cishu
    for i = 1:1:3
        plane = trian(test1(i),train1(i),plane,planepr);
        mistake_C1{number} = findmistake(plane,planepr,plane_C1);
        plane_C111T{number} = plane;
        number = number+1;
    end
end
for u=1:1:cishu
    for i = 1:1:3
        plane = trian(test2(i),train2(i),plane,planepr);
        mistake_C1{number} = findmistake(plane,planepr,plane_C1);
        plane_C111T{number} = plane;
        number = number+1;
    end
end
for u=1:1:cishu
    for i = 1:1:3
        plane = trian(test3(i),train3(i),plane,planepr);
        mistake_C1{number} = findmistake(plane,planepr,plane_C1);
        plane_C111T{number} = plane;
        number = number+1;
    end
end
mistake_C1x = [];
mistake_C1y = [];
for i = 1:1:length(mistake_C1)
    temp = mistake_C1{i};
    mistake_C1x(end+1) = temp(1);
    mistake_C1y(end+1) = temp(2);
end
% m1 = [];
% m2 = [];
% m3 = [];
% m4 = [];
% n1 = [];
% n2 = [];
% n3 = [];
% n4 = [];

%%
%%Œª÷√ æ“‚Õº
%subplot(1,4,1)
% plane_C11 = plane_C111T{1};
% print_C11 = picture(plane_C11);
% print_C11x = print_C11{1};
% print_C11y = print_C11{2};
% print_C11z = print_C11{3};
% 
% scatter3(print_C11x,print_C11y,print_C11z,800,'b','filled','DisplayName','position after iteration');
% hold on
% scatter3(print_C1x,print_C1y,print_C1z,1600,'r','DisplayName','position before iteration');
% hold on 
% scatter3(print_prx,print_pry,print_prz,1600,'k','+','DisplayName','correct position');
% hold on
% grid minor
% hold on
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Change of position after the first set of transmissions')
% legend

%subplot(1,4,2)
% plane_C12 = plane_C111T{3};
% print_C12 = picture(plane_C12);
% print_C12x = print_C12{1};
% print_C12y = print_C12{2};
% print_C12z = print_C12{3};

% scatter3(print_C11x,print_C11y,print_C11z,1600,'r','DisplayName','position before iteration');
% hold on 
% scatter3(print_prx,print_pry,print_prz,1600,'k','+','DisplayName','correct position');
% hold on
% scatter3(print_C12x,print_C12y,print_C12z,800,'b','filled','DisplayName','position after iteration');
% grid minor
% hold on
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Change of position after the third group transmits the signal')
% legend

%subplot(1,4,3)
% plane_C13 = plane_C111T{5};
% print_C13 = picture(plane_C13);
% print_C13x = print_C13{1};
% print_C13y = print_C13{2};
% print_C13z = print_C13{3};

% scatter3(print_C12x,print_C12y,print_C13z,1600,'r','DisplayName','position before iteration');
% hold on 
% scatter3(print_prx,print_pry,print_prz,1600,'k','+','DisplayName','correct position');
% hold on
% scatter3(print_C13x,print_C13y,print_C13z,800,'b','filled','DisplayName','position after iteration');
% grid minor
% hold on
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Change of position after the fifth group transmits the signal')
% legend

%subplot(1,4,4)
% plane_C14 = plane_C111T{9};
% print_C14 = picture(plane_C14);
% print_C14x = print_C14{1};
% print_C14y = print_C14{2};
% print_C14z = print_C14{3};

% scatter3(print_C13x,print_C13y,print_C13z,1600,'r','DisplayName','position before iteration');
% hold on 
% scatter3(print_prx,print_pry,print_prz,1600,'k','+','DisplayName','correct position');
% hold on
% scatter3(print_C14x,print_C14y,print_C14z,800,'b','filled','DisplayName','position after iteration');
% grid minor
% hold on
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Change of position after the ninth group transmits the signal')
% legend
%%
function plotp = picture(plane)
print_x = [];
print_y = [];
print_z = [];
len = length(plane);
for i = 1:1:len
   pr = plane{i};
   print_x(end+1) = pr(1);
   print_y(end+1) = pr(2);
   print_z(end+1) = pr(3);
end
plotp{1} = print_x;
plotp{2} = print_y;
plotp{3} = print_z;
end
function mistake = findmistake(plane,planepr,plane_C)
dis1 = 0;
dis2 = 0;
for i = 1:1:10
    a = plane{i};
    b = planepr{i};
    c = plane_C{i};
    dis1 = distance(a,b)+dis1;
    dis2 = distance(b,c)+dis2;
end
mistake_a = dis1/10;
mistake_b = dis1/dis2;
mistake = [mistake_a,mistake_b];
end
function plane_end = trian(t,tr,plane,planepr)
len = length(t);
i = 1;
planee = plane;
while i<=len
    tt = t{i};
    trr = tr{i};
    j=1;
    while j<=3
        b_end = move(tt,planee{trr(j)},planee,planepr,j,trr(j));
        planee{trr(j)} = b_end;
       j = j+1;   
    end
    i = i+1;
end
plane_end = planee;
end
function b_end = move(a,b,plane,planepr,j,bb)
p1 = plane{a(1)};
p2 = plane{a(2)};
p3 = plane{a(3)};
pr1 = planepr{a(1)};
pr2 = planepr{a(2)};
pr3 = planepr{a(3)};
prbb = planepr{bb};
if j==1
%     de12 = abs(degree(p1,b)-degree(p2,b));
%     de13 = abs(degree(p1,b)-degree(p3,b));
%     de23 = abs(degree(p3,b)-degree(p2,b));
    
    
    cy13 = findcy(pr1,pr3,b);
    cy23 = findcy(pr2,pr3,b);
    
    sc13 = cy13{1};
    sc23 = cy23{1};
    
    r13 = cy13{2};
    r23 = cy23{2};
    
    %kb = find_kb(pr1,pr2);
    %dot = [0,0];
    dot1 = finddot(r13,sc13,r23,sc23);
    %dot2 = finddotdd(kb,r13,sc13);
    %dot3 = finddotdd(kb,r23,sc23);
    %dot_end = findenddot(dot1,dot2,dot3);
    if dot1{2}==1
        dot_zz = dot1{1};
        b_end = findbend(prbb,dot_zz);
    else
        b_end = b;
    end
%     if length(dot_end)==3
%         dot_zz = (pr1+pr2+pr3)./3;
%         b_end = findbend(prbb,dot_zz);
%     else
%         for i = 1:1:length(dot_end)
%             dot = dot_end{i}+dot;
%         end
%         dot_zz = [dot(1)-pr1(1)-pr2(1)-pr3(1),dot(2)-pr1(2)-pr2(2)-pr3(2)]./(length(dot_end)-3);
%         b_end = findbend(prbb,dot_zz);
%     end
elseif j==3
%     de12 = abs(degree(p1,b)-degree(p2,b));
%     de13 = abs(degree(p1,b)-degree(p3,b));
%     de23 = abs(degree(p3,b)-degree(p2,b));
    cy12 = findcy(pr1,pr2,b);
    cy23 = findcy(pr2,pr3,b);
    
    sc12 = cy12{1};
    sc23 = cy23{1};
    r12 = cy12{2};
    r23 = cy23{2};
    
    dot1 = finddot(r12,sc12,r23,sc23);
    if dot1{2}==1
        dot_zz = dot1{1};
        b_end = findbend(prbb,dot_zz);
    else
        b_end = b;
    end
%     kb = find_kb(pr1,pr3);
%     dot = [0,0];
%     dot1 = finddot(r12,sc12,r23,sc23);
%     dot2 = finddotdd(kb,r12,sc12);
%     dot3 = finddotdd(kb,r23,sc23);
%     dot_end = findenddot(dot1,dot2,dot3);
%     if length(dot_end)==3
%         dot_zz = (pr1+pr2+pr3)./3;
%         b_end = findbend(prbb,dot_zz);
%     else
%         for i = 1:1:length(dot_end)
%             dot = dot_end{i}+dot;
%         end
%         dot_zz = [dot(1)-pr1(1)-pr2(1)-pr3(1),dot(2)-pr1(2)-pr2(2)-pr3(2)]./(length(dot_end)-3);
%         b_end = findbend(prbb,dot_zz);
%     end
else
%     de12 = abs(degree(p1,b)-degree(p2,b));
%     de13 = abs(degree(p1,b)-degree(p3,b));
%     de23 = abs(degree(p3,b)-degree(p2,b));
    
    cy12 = findcy(pr1,pr2,b);
    cy23 = findcy(pr2,pr3,b);
    cy13 = findcy(pr1,pr3,b);
    
    sc12 = cy12{1};
    sc23 = cy23{1};
    sc13 = cy13{1};
    r12 = cy12{2};
    r23 = cy23{2};
    r13 = cy13{2};
    
%     sc12 = findsc(pr1,pr2,b);
%     sc13 = findsc(pr1,pr3,b);
%     sc23 = findsc(pr2,pr3,b);
%     r12 = findr(de12);
%     r13 = findr(de13);
%     r23 = findr(de23);
    dot = [0,0,0];
    number = 0;
    dot1 = finddot(r12,sc12,r13,sc13);
    dot2 = finddot(r12,sc12,r23,sc23);
    dot3 = finddot(r13,sc13,r23,sc23);  
    if dot1{2}==1
        dot = dot1{1}+dot;
        number = number+1;
    end
    if dot2{2}==1
        dot = dot2{1}+dot;
    end
    if dot3{2}==3
        dot = dot3{1}+dot;
    end
    dot_z = dot./number;
%     dot_z = [dot(1)+dot(3),dot(2)+dot(4)];
%     dot_zz = [dot_z(1)-pr1(1)-pr2(1)-pr3(1),dot_z(2)-pr1(2)-pr2(2)-pr3(2)]./3;
    b_end = findbend(prbb,dot_z);
end
end
function dot = finddot(r1,sc1,r2,sc2)
dis = distance(sc1,sc2);
key = 0;
dot1 = [0,0,0];
if dis <= r1+r2 && dis>=abs(r2-r1)
    de1 = acos((dis^2+r1^2-r2^2)/(2*dis*r1));
    de2 = acos((dis^2+r2^2-r1^2)/(2*dis*r2));
    r = r1*sin(de1);
    s = sc2-sc1;
    s = s./(s(1)^2+s(2)^2+s(3)^2);
    s = s*r1*cos(de1);
    dot1 = sc1+s;
    key = 1;
end
dot{1} = dot1;
dot{2} = key;
end
function b_end = findbend(b,a)
% if a(1)==b(1)
%     b_end(1) = b(1);
%     if b(2)>a(2)
%         b_end(2) = b(2)+0.15;
%     else 
%         b_end(2) = b(2)-0.15;
%     end
% else
% k = (a(2)-b(2))/(a(1)-b(1));
% x = sqrt(1.5^2/(k^2+1));
% y = k*x;
% if b(1)>a(1)
%     b_end(1) = b(1)+x;
%     b_end(2) = b(2)+y;
% else
%     b_end(1) = b(1)-x;
%     b_end(2) = b(2)-y;
% end
%end
s = b-a;
s = s./(s(1)^2+s(2)^2+s(3)^2);
s = s*1.5;
b_end = b+s;
end
function cy = findcy(a,b,c)
x1 = a(1);
y1 = a(2);
z1 = a(3);
x2 = b(1);
y2 = b(2);
z2 = b(3);
x3 = c(1);
y3 = c(2);
z3 = c(3);
A1 = y1*z2-y1*z3-z1*y2+z1*y3+y2*z3-y3*z2;
B1 = -1*x1*z2+x1*z3+z1*x2-z1*x3-x2*z3+x3*z2;
C1 = x1*y2-x1*y3-y1*x2+y1*x3+x2*y3-x3*y2;
D1 = -1*x1*y2*z3+x1*y3*z2+x2*y1*z3-x3*y1*z2-x2*y3*z1+x3*y2*z1;
A2 = 2*(x2-x1);
B2 = 2*(y2-y1);
C2 = 2*(z2-z1);
D2 = x1^2+y1^2+z1^2-x2^2-y2^2-z2^2;
A3 = 2*(x3-x1);
B3 = 2*(y3-y1);
C3 = 2*(z3-z1);
D3 = x1^2+y1^2+z1^2-x3^2-y3^2-z3^2; 
TD0 = [D1;D2;D3];
T0 = [A1,B1,C1;A2,B2,C2;A3,B3,C3];
T1 = inv(T0);
T2 = T1*TD0;
R = sqrt((x1-T2(1))^2+(y1-T2(2))^2+(z1-T2(3))^2);
cy{1} = T2';
cy{2} = R;
end
function de = degree(a,b,p)
disab = distance(a,b);
disap = distance(a,p);
disbp = distance(b,p);
de = acos((disap^2+disbp^2-disab^2)/(2*disap*disbp));
end
function dis = distance(a,b)
dis = sqrt((a(1)-b(1))^2+(a(2)-b(2))^2+(a(3)-b(3))^2);
end