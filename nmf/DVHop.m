%~~~~~~~~~~~~~~~~~~~~~~~~~~���ڼ�Ȩ˫���߶�λ��DV-Hop��λ�㷨�㷨  ~~~~~~~~~
%���ʽܣ��ལ����꣬��. ���ڼ�Ȩ˫���߶�λ��DV-Hop�Ľ��㷨[J]. ������ָ�ӿ���.
% 2016, 41(12): 96-100.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% BorderLength-----����������ı߳�����λ��m
% NodeAmount-------����ڵ�ĸ���
% BeaconAmount---�ű�ڵ���
% Sxy--------------���ڴ洢�ڵ����ţ������꣬������ľ���
%Beacon----------�ű�ڵ��������;BeaconAmount*BeaconAmount
%UN-------------δ֪�ڵ��������;2*UNAmount
% Distance------δ֪�ڵ㵽�ű�ڵ�������;2*BeaconAmount
%h---------------�ڵ���ʼ��������
%X---------------�ڵ���������ʼ����,X=[x,y]'
% R------------------�ڵ��ͨ�ž��룬һ��Ϊ10-100m

clear,close all;
BorderLength=100;
NodeAmount=100;
BeaconAmount=20;
% for pp=1:8
%     R=15+10*pp;
%     BeaconAmount=NodeAmount*0.2;
UNAmount=NodeAmount-BeaconAmount;
R=25;
shortest_Path=zeros(NodeAmount,NodeAmount);%��ʼ����Ϊ0��NodeAmount��NodeAmount��
UN_Coordinates_Estimate=zeros(2,UNAmount);%�ڵ���������ʼ����
times=100;

figure('Name','�ڵ�ֲ�ͼ');
for num=1:times
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~�������������ڲ������ȷֲ����������~~~~~~~~~~~~~~~~~~~~
C=BorderLength.*rand(2,NodeAmount);
% %���߼��ŵĽڵ�����
Sxy=[[1:NodeAmount];C];
Anchor_Coordinates=[Sxy(2,1:BeaconAmount);Sxy(3,1:BeaconAmount)];%�ű�ڵ��������2*BeaconAmount
UN_Coordinates_True=[Sxy(2,(BeaconAmount+1):NodeAmount);Sxy(3,(BeaconAmount+1):NodeAmount)];%δ֪�ڵ�����
%�����ڵ�ֲ�ͼ
% plot(Sxy(2,1:BeaconAmount),Sxy(3,1:BeaconAmount),'r+',Sxy(2,(BeaconAmount+1):NodeAmount),Sxy(3,(BeaconAmount+1):NodeAmount),'k.')
% xlim([0,BorderLength]);
% ylim([0,BorderLength]);
% title('+ ��ɫ�ű�ڵ� . ��ɫδ֪�ڵ�','FontSize',14)
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~��ʼ���ڵ����롢��������~~~~~~~~~~~~~~~~~~~~~~
for i=1:NodeAmount
    for j=1:NodeAmount
        Distance(i,j)=((Sxy(2,i)-Sxy(2,j))^2+(Sxy(3,i)-Sxy(3,j))^2)^0.5;%���нڵ���໥����
        if (Distance(i,j)<=R)&(Distance(i,j)>0)
            shortest_Path(i,j)=1;%�������󣬽������ݽڵ�֮���ʵ�ʾ����ж�����������ʵ�ʾ���С��ͨ�Ű뾶������Ϊ�ڵ�֮���ܹ�ֱ��ͨ�ţ�����Ϊ1
%             shortest_Path(i,j)=Distance(i,j)/R;
        elseif i==j
            shortest_Path(i,j)=0;
        else shortest_Path(i,j)=inf;
        end
    end
end
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~���·���㷨����ڵ������~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
        disp('���粻��ͨ...��Ҫ������ͨ��ͼ...����û�п����������');
        continue;
    end
%~~~~~~~~~~~~~~~~~~~~~~~~~��ÿ���ű�ڵ��У��ֵ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hop_In_Anchors=shortest_Path(1:BeaconAmount,1:BeaconAmount);   % hop_In_Anchors Ϊê�ڵ�֮�����������
Distance_In_Anchors=Distance(1:BeaconAmount,1:BeaconAmount);   % Distance_In_Anchors Ϊê�ڵ�֮��ľ������

for i=1:BeaconAmount
    hopsize(i)=sum(Distance_In_Anchors(i,:))/sum(hop_In_Anchors(i,:));  %ÿ���ű�ڵ��ƽ��ÿ������
end

for i=1:UNAmount    
%  %�����������������㷨��δ֪�ڵ��ƽ��ÿ������Ϊ���������ê�ڵ��ƽ��ÿ�����룬һ������¾��������ê�ڵ����ź����ȱ����գ���˿����ж��ĸ�ê�ڵ���������
%     for j=1:BeaconAmount
%         if min(Distance(BeaconAmount+i,1:BeaconAmount))==Distance(BeaconAmount+i,j)
%             UNhopsize(i)=hopsize(j);
%         end
%     end 
    
%��������������һ�ֻ��ڼ�Ȩ��������ߴ���������ƽ������������㷨������ �ź� ��������������Ϣѧ����2008��
    UNhopsize(i)=sum(((1./shortest_Path(i+BeaconAmount,1:BeaconAmount))./sum(1./shortest_Path(i+BeaconAmount,1:BeaconAmount))).*hopsize(1:BeaconAmount));

% %����������������������ȥ��ǰê�ڵ����������������Խ�����Խ����ռȨ��ԽС��ԭ��
%     UNhopsize(i)=sum(((sum(shortest_Path(i+BeaconAmount,1:BeaconAmount))-shortest_Path(i+BeaconAmount,1:BeaconAmount))/((BeaconAmount-1)*sum(shortest_Path(i+BeaconAmount,1:BeaconAmount)))).*hopsize(1:BeaconAmount));

% %��������������̬��Ȩģ��
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
%~~~~~~~~~~~~~~~~~~~~~~~~~~~���������ƾ���~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for i=1:BeaconAmount
%     Distance_to_Anchors(i,:)=hopsize(i)*shortest_Path(i,(BeaconAmount+1):NodeAmount);%%Beacon��UN�У� %��i��ê�ڵ�����ξ���*��i��ê�ڵ㵽����δ֪�ڵ������
    Distance_to_Anchors(i,1:NodeAmount-BeaconAmount)=UNhopsize(i)*shortest_Path(i,(BeaconAmount+1):NodeAmount);
end
d=Distance_to_Anchors;
%%
% %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~��С���˷���δ֪������~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
%          W(i,i)=1./shortest_Path(i,m+BeaconAmount).^3;        % W Ϊ��Ȩ��С�����㷨�е�Ȩֵ�������������Ȩֵ֮��λ���ʹ�Լ0.025
% 
% %          W(i,i)=(sum(shortest_Path(i+BeaconAmount,1:BeaconAmount))-shortest_Path(i,m+BeaconAmount))/((BeaconAmount-1)*sum(shortest_Path(i+BeaconAmount,1:BeaconAmount)));
% 
% %          M=max(shortest_Path(m,1:BeaconAmount));
% %          W(i,i)=exp(-(shortest_Path(m,i)/M).^2);
%      end
% %      X(m,:)=(A\B)';         %X(m,:)Ϊ1*2����
% %      X(m,:)=(inv(A'*A)*A'*B)';
%      X(m,:)=(inv(A'*W*A)*A'*W*B)';
%      UN_Coordinates_Estimate(1,m)=X(m,1);
%      UN_Coordinates_Estimate(2,m)=X(m,2);
%      error(m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
%  end
% %  figure;plot(error,'-o')
% %  title('ÿ��δ֪�ڵ�����')
%  error=sum(error)/UNAmount;
%  Accuracy(num)=error/R;
%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~�������߷���δ֪������~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
%            W(i,i)=1./shortest_Path(i,m+BeaconAmount).^1;        % W Ϊ��Ȩ���������㷨�е�Ȩֵ�������������Ȩֵ֮��λ���ʹ�Լ0.04
% %            W(i,i)=(sum(shortest_Path(i+BeaconAmount,1:BeaconAmount))-shortest_Path(i,m+BeaconAmount))/((BeaconAmount-1)*sum(shortest_Path(i+BeaconAmount,1:BeaconAmount)));
% %            W(i,i)=1-d(i,m)/R.^2;
% %            a=max(shortest_Path(m,1:BeaconAmount));
% %            W(i,i)=exp(-(shortest_Path(m,i)/a).^2);
%        end

     X(m,:)=(A\B)';         %X(m,:)Ϊ 1*3 ����
%      X(m,:)=(inv(A'*A)*A'*B)';

%      X(m,:)=(inv(A'*W*A)*A'*W*B)';
     UN_Coordinates_Estimate(1,m)=X(m,2);
     UN_Coordinates_Estimate(2,m)=X(m,3);
%      error(m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
     error1(num,m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
 end
%  figure;plot(error,'-o')
%  title('ÿ��δ֪�ڵ�����')
%  error=sum(error)/UNAmount;
%  Accuracy(num)=error/R;  

%% ����[10]
for m=1:UNAmount 
     A=[ones(BeaconAmount,1) a];  %size(A)=BeaconAmount*3
     for i=1:BeaconAmount
         B(i,1)=d(i,m)^2-Anchor_Coordinates(1,i)^2-Anchor_Coordinates(2,i)^2;
     end
     
     for i=1:BeaconAmount
         W(i,i)=1./shortest_Path(i,m+BeaconAmount).^1;        % W Ϊ��Ȩ���������㷨�е�Ȩֵ�������������Ȩֵ֮��λ���ʹ�Լ0.04
     end

     X(m,:)=(inv(A'*W*A)*A'*W*B)';
     UN_Coordinates_Estimate(1,m)=X(m,2);
     UN_Coordinates_Estimate(2,m)=X(m,3);
     error2(num,m)=(((UN_Coordinates_Estimate(1,m)-UN_Coordinates_True(1,m))^2+(UN_Coordinates_Estimate(2,m)-UN_Coordinates_True(2,m))^2)^0.5);
end
 %% �Ľ�
for m=1:UNAmount 
     A=[ones(BeaconAmount,1) a];  %size(A)=BeaconAmount*3
     for i=1:BeaconAmount
         B(i,1)=d(i,m)^2-Anchor_Coordinates(1,i)^2-Anchor_Coordinates(2,i)^2;
     end
     
     for i=1:BeaconAmount
         W(i,i)=1./shortest_Path(i,m+BeaconAmount).^3;        % W Ϊ��Ȩ���������㷨�е�Ȩֵ�������������Ȩֵ֮��λ���ʹ�Լ0.04
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
%figure('Name','δ֪�ڵ㶨λ���Ա�ͼ');
box on
hold on
plot(x,E1,'k-p','MarkerFaceColor','k')
plot(x,E2,'k-+','MarkerFaceColor','k')
plot(x,E3,'k-o','MarkerFaceColor','k'),axis([1,80,0.18,0.4])
legend('DV-Hop algorithm based on hyperbolic positioning','An improved DV-Hop positioning algorithm based on the optimal node communication radius','An improved DV-Hop localization algorithm')
xlabel('Node to be located') 
ylabel('Positioning error')
grid minor
%���жԱ��㷨
%1 ����ɣ����. �������Žڵ�ͨ�Ű뾶�ĸĽ�DV-Hop��λ�㷨[J]. ��������ѧѧ��(��Ȼ��ѧ��). 2012, 40(06): 36-42.
%2 CHEN H��SEZAKI K��DENG P��et al. An improved DV-Hop localization algorithm for wireless sensor networks��C��//Industrial Electronics and Applications��2008. ICIEA 2008. 3rd IEEE Conference on. IEEE��2008��1557-1561.