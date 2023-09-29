








A = 25;
B = -25*sqrt(3);
C = 20*0.42435;
PAx = {[0],[B+C],[B],[2*B+C],[2*B+C],[2*B+C],[3*B-C],[3*B],[3*B+C],[3*B+C]};
PAy = {[0+C],[A],[-1*A],[2*A+C],[0],[-2*A+C],[3*A-C],[A+C],[-1*A+C],[-3*A]};
PAz = {[0+C],[A],[-1*A],[2*A+C],[0],[-2*A+C],[3*A-C],[A+C],[-1*A+C],[-3*A]};
for i=1:1:9
   plane_h = plane_C1T{i};
   print_h = picture(plane_h);
   print_hx = print_h{1};
   print_hy = print_h{2};
   print_hz = print_h{3};
   for j=1:1:10
       pax = PAx{j};
       pay = PAy{j};
       paz = PAz{j};
       pax(end+1) = print_hx(j);
       pay(end+1) = print_hy(j);
       paz(end+1) = print_hz(j);
       PAx{j} = pax;
       PAy{j} = pay;
       PAz{j} = paz;
   end
end
for i=1:1:10
    Px = PAx{i};
    Py = PAy{i};
    Pz = PAz{i};
    plot3(Px,Py,Pz,'m-.')
    hold on
    scatter3(Px,Py,Pz,'k')
    hold on
    scatter3(Px(1),Py(1),Pz(1),100,'r','.')
    hold on
end
% scatter3(print_C1x,print_C1y,print_C1z,200,'r','.','DisplayName','position before iteration');
% hold on
scatter3(print_prx,print_pry,print_prz,100,'b','.','DisplayName','正确位置');
hold on
plot3(print_prx,print_pry,print_prz,'b');
hold on
plot3([print_prx(1),print_prx(10)],[print_pry(1),print_pry(10)],[print_prz(1),print_prz(10)],'b');
hold on
plot3([print_prx(1),print_prx(7)],[print_pry(1),print_pry(7)],[print_prz(1),print_prz(7)],'b');
hold on
plot3([print_prx(2),print_prx(6)],[print_pry(2),print_pry(6)],[print_prz(2),print_prz(6)],'b');
hold on
plot3([print_prx(4),print_prx(10)],[print_pry(4),print_pry(10)],[print_prz(4),print_prz(10)],'b');
hold on
grid minor
xlabel('x');
ylabel('y');
zlabel('z');
% plane_C12 = plane_C1T{3};
% print_C12 = picture(plane_C12);
% print_C12x = print_C12{1};
% print_C12y = print_C12{2};
% print_C12z = print_C12{3};
% scatter3(print_C11x,print_C11y,print_C11z,200,'r','DisplayName','迭代前位置');
% hold on 
% scatter3(print_prx,print_pry,print_prz,200,'k','+','DisplayName','正确位置');
% hold on
% scatter3(print_C12x,print_C12y,print_C12z,100,'b','filled','DisplayName','迭代后位置');
% grid minor
% hold on
% xlabel('x/m');
% ylabel('y/m');
% zlabel('z/m');
% title('第三次迭代')
% legend
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