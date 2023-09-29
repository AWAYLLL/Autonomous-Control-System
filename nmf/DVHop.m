%~~~~~~~~~~~~~~~~~~~~~~~~~~基于加权双曲线定位的DV-Hop定位算法算法  ~~~~~~~~~
%易仁杰，余剑，吴标，等. 基于加权双曲线定位的DV-Hop改进算法[J]. 火力与指挥控制.
% 2016, 41(12): 96-100.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% BorderLength-----正方形区域的边长，单位：m
% NodeAmount-------网络节点的个数
% BeaconAmount---信标节点数
% Sxy--------------用于存储节点的序号，横坐标，纵坐标的矩阵
%Beacon----------信标节点坐标矩阵;BeaconAmount*BeaconAmount
%UN-------------未知节点坐标矩阵;2*UNAmount
% Distance------未知节点到信标节点距离矩阵;2*BeaconAmount
%h---------------节点间初始跳数矩阵
%X---------------节点估计坐标初始矩阵,X=[x,y]'
% R------------------节点的通信距离，一般为10-100m

clear,close all;
BorderLength=100;
NodeAmount=100;
BeaconAmount=20;
% for pp=1:8
%     R=15+10*pp;
%     BeaconAmount=NodeAmount*0.2;
UNAmount=NodeAmount-BeaconAmount;
R=25;
shortest_Path=zeros(NodeAmount,NodeAmount);%初始跳数为0；NodeAmount行NodeAmount列
UN_Coordinates_Estimate=zeros(2,UNAmount);%节点估计坐标初始矩阵
times=100;

figure('Name','节点分布图');
for num=1:times
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~在正方形区域内产生均匀分布的随机拓扑~~~~~~~~~~~~~~~~~~~~
C=BorderLength.*rand(2,NodeAmount);
% %带逻辑号的节点坐标
Sxy=[[1:NodeAmount];C];
Anchor_Coordinates=[Sxy(2,1:BeaconAmount);Sxy(3,1:BeaconAmount)];%信标节点坐标矩阵，2*BeaconAmount
UN_Coordinates_True=[Sxy(2,(BeaconAmount+1):NodeAmount);Sxy(3,(BeaconAmount+1):NodeAmount)];%未知节点坐标
%画出节点分布图
% plot(Sxy(2,1:BeaconAmount),Sxy(3,1:BeaconAmount),'r+',Sxy(2,(BeaconAmount+1):NodeAmount),Sxy(3,(BeaconAmount+1):NodeAmount),'k.')
% xlim([0,BorderLength]);
% ylim([0,BorderLength]);
% title('+ 红色信标节点 . 黑色未知节点','FontSize',14)
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~初始化节点间距离、跳数矩阵~~~~~~~~~~~~~~~~~~~~~~
for i=1:NodeAmount
    for j=1:NodeAmount
        Distance(i,j)=((Sxy(2,i)-Sxy(2,j))^2+(Sxy(3,i)-Sxy(3,j))^2)^0.5;%所有节点间相互距离
        if (Distance(i,j)<=R)&(Distance(i,j)>0)
            shortest_Path(i,j)=1;%跳数矩阵，仅仅根据节点之间的实际距离判断跳数：假如实际距离小于通信半径，则认为节点之间能够直接通信，跳数为1
%             shortest_Path(i,j)=Distance(i,j)/R;
        elseif i==j
            shortest_Path(i,j)=0;
        else shortest_Path(i,j)=inf;
        end
    end
end
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~最短路径算法计算节点间跳数~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for k=1:NodeAmount
    for i=1:NodeAmount
        for j=1:NodeAmount
            if shortest_Path(i,k)+shortest_Path(k,j)<shortest_Path(i,j)%min(h(i,j),h(i,k)+h(k,j))
                shortest_Path(i,j)=shortest_Path(i,k)+shortest_Path(k,j);
            end
        end
    end
end
if length(find(shortest_Path==inf))~=0
        disp('网络不连通...需要划分连通子图...这里没有考虑这种情况');
        continue;
    end
%~~~~~~~~~~~~~~~~~~~~~~~~~求每个信标节点的校正值~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hop_In_Anchors=shortest_Path(1:BeaconAmount,1:BeaconAmount);   % hop_In_Anchors 为锚节点之间的跳数矩阵
Distance_In_Anchors=Distance(1:BeaconAmount,1:BeaconAmount);   % Distance_In_Anchors 为锚节点之间的距离矩阵

for i=1:BeaconAmount
    hopsize(i)=sum(Distance_In_Anchors(i,:))/sum(hop_In_Anchors(i,:));  %每个信标节点的平均每跳距离
end

for i=1:UNAmount    
%  %………………经典算法：未知节点的平均每跳距离为离它最近的锚节点的平均每跳距离，一般情况下距离最近的锚节点其信号最先被接收，因此可以判断哪个锚节点距离其最近
%     for j=1:BeaconAmount
%         if min(Distance(BeaconAmount+i,1:BeaconAmount))==Distance(BeaconAmount+i,j)
%             UNhopsize(i)=hopsize(j);
%         end
%     end 
    
%………………【一种基于加权处理的无线传感器网络平均跳距离估计算法，刘锋 张翰 杨骥，电子与信息学报，2008】
    UNhopsize(i)=sum(((1./shortest_Path(i+BeaconAmount,1:BeaconAmount))./sum(1./shortest_Path(i+BeaconAmount,1:BeaconAmount))).*hopsize(1:BeaconAmount));

% %………………【总跳数减去当前锚节点的跳数：符合跳数越大，误差越大，所占权重越小的原则】
%     UNhopsize(i)=sum(((sum(shortest_Path(i+BeaconAmount,1:BeaconAmount))-shortest_Path(i+BeaconAmount,1:BeaconAmount))/((BeaconAmount-1)*sum(shortest_Path(i+BeaconAmount,1:BeaconAmount)))).*hopsize(1:BeaconAmount));

% %………………动态加权模型
%     UNhopsize1(i)=sum(((1./shortest_Path(i+BeaconAmount,1:BeaconAmount))./sum(1./shortest_Path(i+BeaconAmount,1:BeaconAmount))).*hopsize(1:BeaconAmount));
end
% ave=mean(UNhopsize1);
% for i=1:BeaconAmount
%     adj(i)=sum(Distance_In_Anchors(i,:))/sum(hop_In_Anchors(i,:).*ave);
% end
% for i=1:UNAmount 
%     UNhopsize(i)=sum(hopsize(1:BeaconAmount).*(adj(1:BeaconAmount).^shortest_Path(i+BeaconAmount,1:BeaconAmount).^2).*(1./shortest_Path(i+BeaconAmount,1:BeaconAmount))./sum(1./shortest_Path(i+BeaconAmount,1:BeaconAmount)));
% end
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~用跳数估计距离~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for i=1:BeaconAmount
%     Distance_to_Anchors(i,:)=hopsize(i)*shortest_Path(i,(BeaconAmount+1):NodeAmount);%%Beacon行UN列； %第i个锚节点的跳段距离*第i个锚节点到各个未知节点的跳数
    Distance_to_Anchors(i,1:NodeAmount-BeaconAmount)=UNhopsize(i)*shortest_Path(i,(BeaconAmount+1):NodeAmount);
end
d=Distance_to_Anchors;
%%
% %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~最小二乘法求未知点坐标~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% for i=1:2
%     for j=1:(BeaconAmount-1)
%       M(i,j)=Anchor_Coordinates(i,j)-Anchor_Coordinates(i,BeaconAmount);
%     end
% end
% W=zeros(BeaconAmount-1);
% A=-2*(M');
%  for m=1:UNAmount 
%      for i=1:(BeaconAmount-1)
%          B(i,1)=d(i,m)^2-d(BeaconAmount,m)^2-Anchor_Coordinates(1,i)^2+Anchor_Coordinates(1,BeaconAmount)^2-Anchor_Coordinates(2,i)^2+Anchor_Coordinates(2,BeaconAmount)^2;
%      end
%      for i=1:BeaconAmount-1
%          W(i,i)=1./shortest_Path(i,m+BeaconAmount).^3;        % W 为加权最小二乘算法中的权值，结果表明引入权值之后定位误差降低大约0.025
% 
% %          W(i,i)=(sum(shortest_Path(i+BeaconAmount,1:BeaconAmount))-shortest_Path(i,m+BeaconAmount))/((BeaconAmount-1)*sum(shortest_Path(i+BeaconAmount,1:BeaconAmount)));
% 
% %          M=max(shortest_Path(m,1:BeaconAmount));
% %          W(i,i)=exp(-(shortest_Path(m,i)/M).^2);
%      end
% %      X(m,:)=(A\B)';         %X(m,:)为1*2矩阵
% %      X(m,:)=(inv(A'*A)*A'*B)';
%      X(m,:)=(inv(A'*W*A)*A'*W*B)';
%      UN_Coordinates_Estimate(1,m)=X(m,1);
%      UN_Coordinates_Estimate(2,m)=X(m,2);
%      error(m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
%  end
% %  figure;plot(error,'-o')
% %  title('每个未知节点的误差')
%  error=sum(error)/UNAmount;
%  Accuracy(num)=error/R;
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~二次曲线法求未知点坐标~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a=-2*Anchor_Coordinates';
% A=[ones(BeaconAmount,1) a];  %size(A)=BeaconAmount*3
% mm=inv(A'*A)*A'

W=zeros(BeaconAmount);
 for m=1:UNAmount 
     A=[ones(BeaconAmount,1) a];  %size(A)=BeaconAmount*3
     for i=1:BeaconAmount
         B(i,1)=d(i,m)^2-Anchor_Coordinates(1,i)^2-Anchor_Coordinates(2,i)^2;
%          B(i,1)=(d(i,m)^2-Anchor_Coordinates(1,i)^2-Anchor_Coordinates(2,i)^2)./shortest_Path(i,BeaconAmount+m).^2;
%          A(i,:)=A(i,:)./shortest_Path(i,BeaconAmount+m).^2;
     end

%        for i=1:BeaconAmount
%            W(i,i)=1./shortest_Path(i,m+BeaconAmount).^1;        % W 为加权二次曲线算法中的权值，结果表明引入权值之后定位误差降低大约0.04
% %            W(i,i)=(sum(shortest_Path(i+BeaconAmount,1:BeaconAmount))-shortest_Path(i,m+BeaconAmount))/((BeaconAmount-1)*sum(shortest_Path(i+BeaconAmount,1:BeaconAmount)));
% %            W(i,i)=1-d(i,m)/R.^2;
% %            a=max(shortest_Path(m,1:BeaconAmount));
% %            W(i,i)=exp(-(shortest_Path(m,i)/a).^2);
%        end

     X(m,:)=(A\B)';         %X(m,:)为 1*3 矩阵
%      X(m,:)=(inv(A'*A)*A'*B)';

%      X(m,:)=(inv(A'*W*A)*A'*W*B)';
     UN_Coordinates_Estimate(1,m)=X(m,2);
     UN_Coordinates_Estimate(2,m)=X(m,3);
%      error(m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
     error1(num,m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
 end
%  figure;plot(error,'-o')
%  title('每个未知节点的误差')
%  error=sum(error)/UNAmount;
%  Accuracy(num)=error/R;  

%% 文献[10]
for m=1:UNAmount 
     A=[ones(BeaconAmount,1) a];  %size(A)=BeaconAmount*3
     for i=1:BeaconAmount
         B(i,1)=d(i,m)^2-Anchor_Coordinates(1,i)^2-Anchor_Coordinates(2,i)^2;
     end
     
     for i=1:BeaconAmount
         W(i,i)=1./shortest_Path(i,m+BeaconAmount).^1;        % W 为加权二次曲线算法中的权值，结果表明引入权值之后定位误差降低大约0.04
     end

     X(m,:)=(inv(A'*W*A)*A'*W*B)';
     UN_Coordinates_Estimate(1,m)=X(m,2);
     UN_Coordinates_Estimate(2,m)=X(m,3);
     error2(num,m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
end
 %% 改进
for m=1:UNAmount 
     A=[ones(BeaconAmount,1) a];  %size(A)=BeaconAmount*3
     for i=1:BeaconAmount
         B(i,1)=d(i,m)^2-Anchor_Coordinates(1,i)^2-Anchor_Coordinates(2,i)^2;
     end
     
     for i=1:BeaconAmount
         W(i,i)=1./shortest_Path(i,m+BeaconAmount).^3;        % W 为加权二次曲线算法中的权值，结果表明引入权值之后定位误差降低大约0.04
     end

     X(m,:)=(inv(A'*W*A)*A'*W*B)';
     UN_Coordinates_Estimate(1,m)=X(m,2);
     UN_Coordinates_Estimate(2,m)=X(m,3);
     error3(num,m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
 end
end
% xx=mean(Accuracy);
for i=1:UNAmount
    E1(i)=mean(error1(:,i))/R;
    E2(i)=mean(error2(:,i))/R;
    E3(i)=mean(error3(:,i))/R;
end
mean(E1)
mean(E2)
mean(E3)
x=(1:UNAmount);
%figure('Name','未知节点定位误差对比图');
box on
hold on
plot(x,E1,'k-p','MarkerFaceColor','k')
plot(x,E2,'k-+','MarkerFaceColor','k')
plot(x,E3,'k-o','MarkerFaceColor','k'),axis([1,80,0.18,0.4])
legend('DV-Hop algorithm based on hyperbolic positioning','An improved DV-Hop positioning algorithm based on the optimal node communication radius','An improved DV-Hop localization algorithm')
xlabel('Node to be located') 
ylabel('Positioning error')
grid minor
%文中对比算法
%1 吴玉成，李江雯. 基于最优节点通信半径的改进DV-Hop定位算法[J]. 华南理工大学学报(自然科学版). 2012, 40(06): 36-42.
%2 CHEN H，SEZAKI K，DENG P，et al. An improved DV-Hop localization algorithm for wireless sensor networks［C］//Industrial Electronics and Applications，2008. ICIEA 2008. 3rd IEEE Conference on. IEEE，2008：1557-1561.