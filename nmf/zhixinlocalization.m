
for n=6:2:30
x=100*rand(1,100);      %����10m*10m����������           
y=100*rand(1,100);
w=100*rand(1,n);
z=100*rand(1,n);
% plot(x,y,'b*',w,z,'rO')
% axis([0 100 0 100])
% grid on;
% xlabel('x'),ylabel('y')
% title('ԭʼ��ֲ�')
C=0;
X=zeros(1,100);
Y=zeros(1,100);
for  i=1:100  
       m=0; a=0; b=0;
       for k=1:n          
               dist=distance(x(i),y(i),w(k),z(k));        %�ڵ���ê�ڵ�����
               if dist<=10                                %ͨ�Ű뾶ֵ=2             
                   a=a+w(k);
                   b=b+z(k);
                   m=m+1;
               end         
       end
       if m>=2
             X(i)=a/m;          
             Y(i)=b/m; 
             %plot([x(i),X(i)],[y(i),Y(i)]);
             %hold on;         
       else  X(i)=0;
             Y(i)=0;
             C=C+1;                                        %�������ĵ���          
       end
                                    
end

% plot(x,y,'b*',w,z,'rO',X,Y,'bO')
% axis([0 100 0 100])
% grid on;
% xlabel('x'),ylabel('y')
% title('��λ���ֲ�')

ALE=0;
for  i=1:100          
%      if     X(i)~=0&Y(i)~=0
          ALE=ALE+sqrt((X(i)-x(i))^2+(Y(i)-y(i))^2);
%        end
  
end
ALE=ALE/100;                                    %��λ���ֵ
ALE=ALE/4;
c1(n/2-2)=(100-C)/100;
ale1(n/2-2)=ALE;

     bili(n/2-2)=n/(100+n);                         %ê�ڵ����
end


% plot(bili,c1,'k-p');
% grid minor;
% xlabel('ê�ڵ����'),ylabel('�ɶ�λ�ڵ����')
% title('ê�ڵ������ɶ�λ�ڵ����ͼ');


plot(bili,ale1./40,'k-*')
xlabel('Anchor node ratio')
ylabel('Positioning error')
legend('Chan algorithm (TDOA)')
grid minor;
%title('ê�ڵ�����붨λ���')
hold on


