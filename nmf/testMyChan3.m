% myChan3 ��λ���ı仯����
xxMC = [];
yyMC = [];
for i = 1:1:50
MS = [20, 20*sqrt(3), 0]+rand*3;
dis = MC3(MS);
xxMC(end+1) = i;
yyMC(end+1) = dis;
end
%[xxxMC,yyyMC]=fun(xxMC,yyMC);
plot(xxMC,yyMC./10,'k-o')
legend('Chan algorithm (TDOA)')
xlabel('Number of experiments') 
ylabel('Positioning error')
grid minor
function dis = MC3(a)
% ��վ��Ŀ
BSN = 7;

% ������վ��λ��
BS = [0, sqrt(3), 0.5*sqrt(3), -0.5*sqrt(3), -sqrt(3), -0.5*sqrt(3), 0.5*sqrt(3); 
      0,      0,         1.5,          1.5,        0,         -1.5,        -1.5;
      0,      0,           0,            0,        0,            0,           0]; 
BS = BS(:,1:BSN);
BS = BS .* 50;

% MS��ʵ��λ��
MS = a;
%MS = [20, 20*sqrt(3), 0];

% R0i�Ǹ���BS��MS��ʵ�ʾ��룬������
for i = 1: BSN
    R0(i) = sqrt((BS(1,i) - MS(1))^2 + (BS(2,i) - MS(2))^2 + (BS(3,i) - MS(3))^2); 
end

% ��������
Noise = 0.1;

% R=R_{i,1},�Ǽ�����������BSi��BS1��MS�ľ�����ʵ��ʹ����Ӧ���� TDOA * c���
for i = 1: BSN-1
    R(i) = R0(i+1) - R0(1) + Noise * randn(1); 
end

X = myChan3(BSN, BS, R);
aa = MS-X;
dis = sqrt(aa(1,1)^2+aa(2,2)^2+aa(3,3)^2);
end
function [x1,y1] = fun(x,y)
x1=linspace(min(x),max(x));
y1=interp1(x,y,x1,'cubic');
end
