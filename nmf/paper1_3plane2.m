A = 25;
B = -25*sqrt(3);
C = 10*0.82435;
plane_C1 = {[0,0+C],[B+C,A],[B,-1*A],[2*B+C,2*A+C],[2*B+C,0],[2*B+C,-2*A+C],[3*B-C,3*A-C],[3*B,A+C],[3*B+C,-1*A+C],[3*B+C,-3*A]};
plane_C2 = {[0,0+C],[B+C,A],[B,-1*A],[2*B+C,2*A+C],[2*B+C,0],[2*B+C,-2*A+C],[3*B-C,3*A-C],[3*B,A+C],[3*B+C,-1*A+C],[3*B+C,-3*A]};

for i = 1:1:10
    plane_C2{i} = plane_C2{i}.*1.5;
end
planepr = {[0,0],[B,A],[B,-1*A],[2*B,2*A],[2*B,0],[2*B,-2*A],[3*B,3*A],[3*B,A],[3*B,-1*A],[3*B,-3*A]};
test1 = {[1,2,3],[2,4,5],[3,5,6]};
train1 = {[4,5,6],[7,8,9],[8,9,10]};
test2 = {[7,8,4],[8,9,5],[4,5,2]};
train2 = {[9,5,2],[10,6,3],[6,3,1]};
test3 = {[10,6,9],[6,3,5],[9,5,8]};
train3 = {[3,5,8],[1,2,4],[2,4,7]};
print_C1 = picture(plane_C1);
print_pr = picture(planepr);

print_C1x = print_C1{1};
print_C1y = print_C1{2};
print_prx = print_pr{1};
print_pry = print_pr{2};

plane = plane_C1;
cishu = 1;
number = 1;
mistake_C1 = {};
plane_C1T = {};
for u=1:1:cishu
    for i = 1:1:3
        plane = trian(test1(i),train1(i),plane,planepr);
        mistake_C1{number} = findmistake(plane,planepr,plane_C1);
        plane_C1T{number} = plane;
        number = number+1;
    end
end
for u=1:1:cishu
    for i = 1:1:3
        plane = trian(test2(i),train2(i),plane,planepr);
        mistake_C1{number} = findmistake(plane,planepr,plane_C1);
        plane_C1T{number} = plane;
        number = number+1;
    end
end
for u=1:1:cishu
    for i = 1:1:3
        plane = trian(test3(i),train3(i),plane,planepr);
        mistake_C1{number} = findmistake(plane,planepr,plane_C1);
        plane_C1T{number} = plane;
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
%%
%%偏移距离及百分比示意图
ZU = 1:1:9;
plot(ZU,mistake_C1x,'r','DisplayName','平均偏移距离');
hold on
plot(ZU,mistake_C1y,'b','DisplayName','与原位置相比剩余偏移距离百分比');
hold on
legend
%%
%%位置示意图
subplot(2,2,1)
plane_C11 = plane_C1T{1};
print_C11 = picture(plane_C11);
print_C11x = print_C11{1};
print_C11y = print_C11{2};
scatter(print_C1x,print_C1y,200,'r','DisplayName','迭代前位置');
hold on 
scatter(print_prx,print_pry,200,'k','+','DisplayName','正确位置');
hold on
scatter(print_C11x,print_C11y,100,'b','filled','DisplayName','迭代后位置');
grid minor
hold on
xlabel('x/m');
ylabel('y/m');
title('第一次迭代')
legend
subplot(2,2,2)
plane_C12 = plane_C1T{3};
print_C12 = picture(plane_C12);
print_C12x = print_C12{1};
print_C12y = print_C12{2};
scatter(print_C11x,print_C11y,200,'r','DisplayName','迭代前位置');
hold on 
scatter(print_prx,print_pry,200,'k','+','DisplayName','正确位置');
hold on
scatter(print_C12x,print_C12y,100,'b','filled','DisplayName','迭代后位置');
grid minor
hold on
xlabel('x/m');
ylabel('y/m');
title('第三次迭代')
legend
subplot(2,2,3)
plane_C13 = plane_C1T{5};
print_C13 = picture(plane_C13);
print_C13x = print_C13{1};
print_C13y = print_C13{2};
scatter(print_C12x,print_C12y,200,'r','DisplayName','迭代前位置');
hold on 
scatter(print_prx,print_pry,200,'k','+','DisplayName','正确位置');
hold on
scatter(print_C13x,print_C13y,100,'b','filled','DisplayName','迭代后位置');
grid minor
hold on
xlabel('x/m');
ylabel('y/m');
title('第五次迭代')
legend
subplot(2,2,4)
plane_C14 = plane_C1T{7};
print_C14 = picture(plane_C14);
print_C14x = print_C14{1};
print_C14y = print_C14{2};
scatter(print_C13x,print_C13y,200,'r','DisplayName','迭代前位置');
hold on 
scatter(print_prx,print_pry,200,'k','+','DisplayName','正确位置');
hold on
scatter(print_C14x,print_C14y,100,'b','filled','DisplayName','迭代后位置');
grid minor
hold on
xlabel('x/m');
ylabel('y/m');
title('第七次迭代')
legend
%%


function plotp = picture(plane)
print_x = [];
print_y = [];
len = length(plane);
for i = 1:1:len
   pr = plane{i};
   print_x(end+1) = pr(1);
   print_y(end+1) = pr(2);
end
plotp{1} = print_x;
plotp{2} = print_y;
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
    de12 = abs(degree(p1,b)-degree(p2,b));
    de13 = abs(degree(p1,b)-degree(p3,b));
    de23 = abs(degree(p3,b)-degree(p2,b));
    sc13 = findsc(pr1,pr3,b);
    sc23 = findsc(pr2,pr3,b);
    r13 = findr(de13);
    r23 = findr(de23);
    kb = find_kb(pr1,pr2);
    dot = [0,0];
    dot1 = finddot(r13,sc13,r23,sc23);
    dot2 = finddotdd(kb,r13,sc13);
    dot3 = finddotdd(kb,r23,sc23);
    dot_end = findenddot(dot1,dot2,dot3);
    if length(dot_end)==3
        dot_zz = (pr1+pr2+pr3)./3;
        b_end = findbend(prbb,dot_zz);
    else
        for i = 1:1:length(dot_end)
            dot = dot_end{i}+dot;
        end
        dot_zz = [dot(1)-pr1(1)-pr2(1)-pr3(1),dot(2)-pr1(2)-pr2(2)-pr3(2)]./(length(dot_end)-3);
        b_end = findbend(prbb,dot_zz);
    end
elseif j==3
    de12 = abs(degree(p1,b)-degree(p2,b));
    de13 = abs(degree(p1,b)-degree(p3,b));
    de23 = abs(degree(p3,b)-degree(p2,b));
    sc12 = findsc(pr1,pr2,b);
    sc23 = findsc(pr2,pr3,b);
    r12 = findr(de12);
    r23 = findr(de23);
    kb = find_kb(pr1,pr3);
    dot = [0,0];
    dot1 = finddot(r12,sc12,r23,sc23);
    dot2 = finddotdd(kb,r12,sc12);
    dot3 = finddotdd(kb,r23,sc23);
    dot_end = findenddot(dot1,dot2,dot3);
    if length(dot_end)==3
        dot_zz = (pr1+pr2+pr3)./3;
        b_end = findbend(prbb,dot_zz);
    else
        for i = 1:1:length(dot_end)
            dot = dot_end{i}+dot;
        end
        dot_zz = [dot(1)-pr1(1)-pr2(1)-pr3(1),dot(2)-pr1(2)-pr2(2)-pr3(2)]./(length(dot_end)-3);
        b_end = findbend(prbb,dot_zz);
    end
else
    de12 = abs(degree(p1,b)-degree(p2,b));
    de13 = abs(degree(p1,b)-degree(p3,b));
    de23 = abs(degree(p3,b)-degree(p2,b));
    sc12 = findsc(pr1,pr2,b);
    sc13 = findsc(pr1,pr3,b);
    sc23 = findsc(pr2,pr3,b);
    r12 = findr(de12);
    r13 = findr(de13);
    r23 = findr(de23);
    dot1 = finddot(r12,sc12,r13,sc13);
    dot2 = finddot(r12,sc12,r23,sc23);
    dot3 = finddot(r13,sc13,r23,sc23);  
    dot = dot1+dot2+dot3;
    dot_z = [dot(1)+dot(3),dot(2)+dot(4)];
    dot_zz = [dot_z(1)-pr1(1)-pr2(1)-pr3(1),dot_z(2)-pr1(2)-pr2(2)-pr3(2)]./3;
    b_end = findbend(prbb,dot_zz);
end
end
function dot_end = findenddot(dot1,dot2,dot3)
    dot_end = {};
    dot = dot1;
    if (dot(1)-dot(3))==0&&(dot(2)-dot(4))==0
        dot_end{end+1} = [dot(1),dot(2)];
    else
        dot_end{end+1} = [dot(1),dot(2)];
        dot_end{end+1} = [dot(3),dot(4)];
    end
    dot = dot2;
    if (dot(1)-dot(3))==0&&(dot(2)-dot(4))==0
        dot_end{end+1} = [dot(1),dot(2)];
    else
        dot_end{end+1} = [dot(1),dot(2)];
        dot_end{end+1} = [dot(3),dot(4)];
    end
    dot = dot3;
    if (dot(1)-dot(3))==0&&(dot(2)-dot(4))==0
        dot_end{end+1} = [dot(1),dot(2)];
    else
        dot_end{end+1} = [dot(1),dot(2)];
        dot_end{end+1} = [dot(3),dot(4)];
    end
    
end
function kb = find_kb(a,b)
A = a(2)-b(2);
B = -1*(a(1)-b(1));
C = a(2)*(a(1)-b(1))-a(1)*(a(2)-b(2));
kb = [A,B,C];
end
function dot = finddotdd(kb,r,sc)
    a1 = sc(1);
    a2 = sc(2);
    a3 = r;
    A = kb(1);
    B = kb(2);
    C = kb(3);
    if B==0
        x1 = -1*A/C;
        y1 = a2+sqrt(a3^2-(x1-a1)^2);
        x2 = -1*A/C;
        y2 = a2-sqrt(a3^2-(x1-a1)^2);
        dot = [x1,y1,x2,y2];
    else
        k = -1*A/B;
        Bb = -1*C/B;
        a = k^2+1;
        b = 2*(Bb-a2)*k-2*a1;
        c = (Bb-a2)^2+a1^2-a3^2;
        x1 = (-b+sqrt(b^2-4*a*c))/(2*a);
        y1 = k*x1+Bb;
        x2 = (-b-sqrt(b^2-4*a*c))/(2*a);
        y2 = k*x2+Bb;
        dot = [x1,y1,x2,y2];
    end
end
function b_end = findbend(b,a)
if a(1)==b(1)
    b_end(1) = b(1);
    if b(2)>a(2)
        b_end(2) = b(2)+0.15;
    else 
        b_end(2) = b(2)-0.15;
    end
else
k = (a(2)-b(2))/(a(1)-b(1));
x = sqrt(1.5^2/(k^2+1));
y = k*x;
if b(1)>a(1)
    b_end(1) = b(1)+x;
    b_end(2) = b(2)+y;
else
    b_end(1) = b(1)-x;
    b_end(2) = b(2)-y;
end
end
end
function r = findr(de)
len = 25;
r = len/sin(de);
end
function dot = finddot(r1,sc1,r2,sc2)
if sc1(2)==sc2(2)
    dot = finddoty(r1,sc1,r2,sc2);
else
    dot = finddotx(r1,sc1,r2,sc2);
end
end
function dot = finddotx(r1,sc1,r2,sc2)
a1 = sc1(1);
a2 = sc1(2);
a3 = r1;
b1 = sc2(1);
b2 = sc2(2);
b3 = r2;
A = (-b1+a1)/(-b2+a2);
B = ((b3^2-b2^2-b1^2)-(a3^2-a2^2-a1^2))/(2*(-b2+a2));
a = A^2+1;
b = 2*(a2-B)*A-2*a1;
c = (a2-B)^2+a1^2-a3^2;
x1 = (-b+sqrt(b^2-4*a*c))/(2*a);
y1 = B-A*x1;
x2 = (-b-sqrt(b^2-4*a*c))/(2*a);
y2 = B-A*x2;
dot = [x1,y1,x2,y2];
end
function dot = finddoty(r1,sc1,r2,sc2)
a1 = sc1(1);
a2 = sc1(2);
a3 = r1;
b1 = sc2(1);
b2 = sc2(2);
b3 = r2;
A = (-b2+a2)/(-b1+a1);
B = ((b3^2-b2^2-b1^2)-(a3^2-a2^2-a1^2))/(2*(-b1+a1));
a = A^2+1;
b = 2*(a1-B)*A-2*a2;
c = (a1-B)^2+a2^2-a3^2;
y1 = (-b+sqrt(b^2-4*a*c))/(2*a);
x1 = B-A*y1;
y2 = (-b-sqrt(b^2-4*a*c))/(2*a);
x2 = B-A*y2;
dot = [x1,y1,x2,y2];
end
function dis = distance(a,b)
diss = (a(1)-b(1))^2+(a(2)-b(2)).^2;
dis = sqrt(diss);
end
function sc = findsc(pr1,pr2,b)
x1 = pr1(1);
y1 = pr1(2);
x2 = pr2(1);
y2 = pr2(2);
x3 = b(1);
y3 = b(2);
d1 = (x2^2+y2^2)-(x1^2+y1^2);
d2 = (x3^2+y3^2)-(x2^2+y2^2);
fm = 2*((y3-y2)*(x2-x1)-(y2-y1)*(x3-x2));
sc(1) = ((y3-y2)*d1-(y2-y1)*d2)/fm;
sc(2) = ((x2-x1)*d2-(x3-x2)*d1)/fm;
end
function de = degree(a,b)
de = atan((a(2)-b(2))./(a(1)-b(1)));
end