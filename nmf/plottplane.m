%%
% len = length(plane);
% x = [];
% y = [];
% z = [];
% xx = [];
% yy = [];
% zz = [];
% xxx = [];
% yyy = [];
% zzz = [];
% for i = 1:1:len
%      temp = plane{i};
%      x(end+1) = temp(1);
%      y(end+1) = temp(2);
%      z(end+1) = temp(3);
% end
% for i = 1:1:len
%      temp = planepr{i};
%      xx(end+1) = temp(1);
%      yy(end+1) = temp(2);
%      zz(end+1) = temp(3);
% end
% for i = 1:1:len
%      temp = plane_C1{i};
%      xxx(end+1) = temp(1);
%      yyy(end+1) = temp(2);
%      zzz(end+1) = temp(3);
% end
% scatter3(x,y,z,100,'r');
% hold on
% scatter3(xxx,yyy,zzz,'k','filled');
% hold on
% scatter3(xx,yy,zz,'b');
% hold on
%%
% mistake1xx= mistake_C1x;
% mistake1yy= mistake_C1y;
% mistake2xx= mistake_C1x;
% mistake2yy= mistake_C1y;
% mistake3xx= mistake_C1x;
% mistake3yy= mistake_C1y;
% mistake4xx= mistake_C1x;
% mistake4yy= mistake_C1y;
% mistake5xx= mistake_C1x;
% mistake5yy= mistake_C1y;

% ZU = 1:1:9;
% plot(ZU,mistake1xx,'k','linewidth',3,'DisplayName','平均偏移距离0-5m');
% hold on
% plot(ZU,mistake2xx,'b','linewidth',3,'DisplayName','平均偏移距离0-10m');
% hold on
% plot(ZU,mistake3xx,'g','linewidth',3,'DisplayName','平均偏移距离0-15m');
% hold on
% plot(ZU,mistake4xx,'r','linewidth',3,'DisplayName','平均偏移距离0-20m');
% hold on
% plot(ZU,mistake5xx,'m','linewidth',3,'DisplayName','平均偏移距离0-25m');
% hold on
% xlabel('迭代次数');
% ylabel('调整后平均偏移距离');
% legend

% ZU = 1:1:9;
% plot(ZU,mistake1yy,'k','linewidth',3,'DisplayName','平均偏移距离0-5m');
% hold on
% plot(ZU,mistake2yy,'b','linewidth',3,'DisplayName','平均偏移距离0-10m');
% hold on
% plot(ZU,mistake3yy,'g','linewidth',3,'DisplayName','平均偏移距离0-15m');
% hold on
% plot(ZU,mistake4yy,'r','linewidth',3,'DisplayName','平均偏移距离0-20m');
% hold on
% plot(ZU,mistake5yy,'m','linewidth',3,'DisplayName','平均偏移距离0-25m');
% hold on
% xlabel('迭代次数');
% ylabel('与原位置相比剩余偏移距离百分比');
% legend