% mistake1xxx= mistake_C1x;
% mistake1yyy= mistake_C1y;
% mistake2xxx= mistake_C1x;
% mistake2yyy= mistake_C1y;
% mistake3xxx= mistake_C1x;
% mistake3yyy= mistake_C1y;
% mistake4xxx= mistake_C1x;
% mistake4yyy= mistake_C1y;
mistake5xxx= mistake_C1x;
mistake5yyy= mistake_C1y;

%%
ZU1 = 1:1:9;
ZU2 = 1:1:9;
ZU3 = 1:1:9;
ZU4 = 1:1:9;
ZU5 = 1:1:9;
ZU6 = 1:1:9;
ZU7 = 1:1:9;
ZU8 = 1:1:9;
ZU9 = 1:1:9;
ZU10 = 1:1:9;
% [ZU1,mistake1xx] = fun(ZU1,mistake1xxx);
% [ZU2,mistake2xx] = fun(ZU2,mistake2xxx);
% [ZU3,mistake3xx] = fun(ZU3,mistake3xxx);
% [ZU4,mistake4xx] = fun(ZU4,mistake4xxx);
% [ZU5,mistake5xx] = fun(ZU5,mistake5xxx);
% 
% [ZU6,mistake1yy] = fun(ZU6,mistake1yyy);
% [ZU7,mistake2yy] = fun(ZU7,mistake2yyy);
% [ZU8,mistake3yy] = fun(ZU8,mistake3yyy);
% [ZU9,mistake4yy] = fun(ZU9,mistake4yyy);
% [ZU10,mistake5yy] = fun(ZU10,mistake5yyy);

ZU = 1:1:9;

%subplot(2,1,1)
plot(ZU,mistake1xxx,'k-h','linewidth',5,'DisplayName','Initial position offset distance:0-5');
hold on
plot(ZU,mistake2xxx,'k--','linewidth',6,'DisplayName','Initial position offset distance:0-10');
hold on
plot(ZU,mistake3xxx,'k-+','linewidth',6,'DisplayName','Initial position offset distance:0-15');
hold on
plot(ZU,mistake4xxx,'k-^','linewidth',6,'DisplayName','Initial position offset distance:0-20');
hold on
plot(ZU,mistake5xxx,'k-o','linewidth',4,'DisplayName','Initial position offset distance:0-25');
hold on
% plot(ZU1,mistake1xx,'k','linewidth',1);
% hold on
% plot(ZU2,mistake2xx,'b','linewidth',1);
% hold on
% plot(ZU3,mistake3xx,'g','linewidth',1);
% hold on
% plot(ZU4,mistake4xx,'r','linewidth',1);
% hold on
% plot(ZU5,mistake5xx,'m','linewidth',1);
% hold on

xlabel('Number of transmissions');
ylabel('Adjusted average offset distance');
grid minor
legend
%%
% ZU = 1:1:9;
% % subplot(2,1,2)
% plot(ZU,mistake1yyy,'k-h','linewidth',6,'DisplayName','Initial position offset distance:0-5');
% hold on
% plot(ZU,mistake2yyy,'k--','linewidth',6,'DisplayName','Initial position offset distance:0-10');
% hold on
% plot(ZU,mistake3yyy,'k-+','linewidth',6,'DisplayName','Initial position offset distance:0-15');
% hold on
% plot(ZU,mistake4yyy,'k-^','linewidth',6,'DisplayName','Initial position offset distance:0-20');
% hold on
% plot(ZU,mistake5yyy,'k-o','linewidth',6,'DisplayName','Initial position offset distance:0-25');
% hold on
% % plot(ZU6,mistake1yy,'k','linewidth',1);
% % hold on
% % plot(ZU7,mistake2yy,'b','linewidth',1);
% % hold on
% % plot(ZU8,mistake3yy,'g','linewidth',1);
% % hold on
% % plot(ZU9,mistake4yy,'r','linewidth',1);
% % hold on
% % plot(ZU10,mistake5yy,'mh','linewidth',1);
% % hold on
% % Adjusted average offset diatance
% % Percentage of relative error
% xlabel('Number of transmissions');
% ylabel('Percentage of relative error');
% grid minor
% legend


% 
% ZU = 1:1:9;

% plot(ZU,mistake_C1y,'b','DisplayName','与原位置相比剩余偏移距离百分比');
% hold on
% legend
function [x1,y1] = fun(x,y)
x1=linspace(min(x),max(x));
y1=interp1(x,y,x1,'cubic');
end