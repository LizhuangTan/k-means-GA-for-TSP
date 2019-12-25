clear all;
close all;
clc;
%for zeros=1:10


%�������ݺϳ�һ��������ŵ�������
%data=xlsread('dataset\berlin52.xlsx', 'B1:C52');   %�����data�ǲ�����ŵ�
%data=xlsread('dataset/d657.xlsx', 'B1:C657'); 
%data=xlsread('dataset/att532.xlsx', 'B1:C532');
%data=xlsread('dataset/d198.xlsx', 'B1:C198'); 
data=xlsread('dataset/bier127.xlsx', 'B1:C127'); 
%data=xlsread('dataset/berlin52.xlsx', 'B1:C52'); 
%data=xlsread('dataset/eil101.xlsx', 'B1:C101'); 
%data=xlsread('dataset/kroA200.xlsx', 'B1:C200'); 
%data=xlsread('dataset/rat783_1.xlsx', 'B1:C783');
%data=xlsread('dataset/pcb442_1.xlsx', 'B1:C442');

%k-means����
[u re]=KMeans(data,3);  %����������ŵ����ݣ�������������ݵ������˼���������ټ�һά��
[m n]=size(re);

%�����ʾ����������
figure;
for i=1:m 
    if re(i,3)==1   
         plot(re(i,1),re(i,2),'ro'); hold on;

    elseif re(i,3)==2
         plot(re(i,1),re(i,2),'go'); 
    else 
         plot(re(i,1),re(i,2),'bo'); 
    end
end
plot(u(:,1),u(:,2),'kx','MarkerSize',14,'LineWidth',4)
grid on;
%���������

re=sortrows(re,3);
jishu=0;
 jishu1=0;
 for i=1:m 
    if re(i,3)==1   
         date1(i,:)= re(i,:);
         jishu=jishu+1;
         jishu1=jishu1+1;
    elseif re(i,3)==2
         date2(i-jishu,:)= re(i,:);
         jishu1=jishu1+1;
    else 
         date3(i-jishu1,:)= re(i,:); 
    end
 end
date1(:,3)=[]; 
date2(:,3)=[]; 
date3(:,3)=[]; 
date1(find(date1(:,2)==0),:)=[];
date2(find(date2(:,2)==0),:)=[];
date3(find(date3(:,2)==0),:)=[];



%n = 80;%���е�����
%xy = 10*rand(n,2);%���е�λ������

% %----------�������� �������ѡһ���в���-------------------------%%
%n=657;xy=xlsread('dataset/d657.xlsx', 'B1:C657'); popSize=2000;numIter=60000;
%n=532;xy=xlsread('dataset/att532.xlsx', 'B1:C532'); popSize=1500;numIter=50000;
%n=198;xy=xlsread('dataset/d198.xlsx', 'B1:C198'); popSize=500;numIter=25000;
%n=127;xy=xlsread('dataset/bier127.xlsx', 'B1:C127'); popSize=300;numIter=15000;
%n=52;xy=xlsread('dataset/berlin52.xlsx', 'B1:C52'); popSize=200;numIter=5000;
%n=101;xy=xlsread('dataset/eil101.xlsx', 'B1:C101'); popSize=300;numIter=10000;
%n=200;xy=xlsread('dataset/kroA200.xlsx', 'B1:C200'); 
%n=200;xy=xlsread('dataset/Jinan200.xls', 'C2:D201');xy=xy*1000;popSize=500;numIter=20000;
%n=51;xy=xlsread('dataset/eil51.xlsx', 'B1:C51');popSize=200;numIter=5000;
%n=225;xy=xlsread('dataset/tsp225.xlsx', 'B1:C225');popSize=500;numIter=30000;
% %----------�������� �������ѡһ���в���-------------------------%%
popSize=500;numIter=200;
n1=jishu;
n2=jishu1-jishu;
n3=m-jishu1;
showProg = 1;%�������������ִ���Ŵ��㷨�Ĳ���
showResult = 1;%�������������ִ���Ŵ��㷨�Ľ��
a = meshgrid(1:n1);
dmat1 = reshape(sqrt(sum((date1(a,:)-date1(a',:)).^2,2)),n1,n1);    %����֮��ľ���/�ɱ�
a = meshgrid(1:n2);
dmat2 = reshape(sqrt(sum((date2(a,:)-date2(a',:)).^2,2)),n2,n2);  
a = meshgrid(1:n3);
dmat3 = reshape(sqrt(sum((date3(a,:)-date3(a',:)).^2,2)),n3,n3);  
[d] = tsp_ga(u,re,m,n1,n2,n3,date1,date2,date3,dmat1,dmat2,dmat3,popSize,numIter,showProg,showResult);
%% Output:
% optRoute �Ŵ��㷨�ó�������·��
% minDist ����·���µĳɱ�ֵ�����ֵ
%%
% switch zeros
%     case 1
%           % xlswrite('1.xls',distHistory,sheet1);
%            xlswrite('1.xls',d,'sheet1','E3');
%        case 2
%          %  xlswrite('1.xls',distHistory,sheet2);
%            xlswrite('1.xls',d,'sheet1','E4');
%             case 3
%           % xlswrite('1.xls',distHistory,sheet3);
%            xlswrite('1.xls',d,'sheet1','E5');
%             case 4
%           % xlswrite('1.xls',distHistory,sheet4);
%            xlswrite('1.xls',d,'sheet1','E6');
%             case 5
%            %xlswrite('1.xls',distHistory,sheet5);
%            xlswrite('1.xls',d,'sheet1','E7');
%             case 6
%            %xlswrite('1.xls',distHistory,sheet6);
%            xlswrite('1.xls',d,'sheet1','E8');
%             case 7
%            %xlswrite('1.xls',distHistory,sheet7);
%            xlswrite('1.xls',d,'sheet1','E9');
%             case 8
%           % xlswrite('1.xls',distHistory,sheet8);
%            xlswrite('1.xls',d,'sheet1','E10');
%             case 9
%           % xlswrite('1.xls',distHistory,sheet9);
%            xlswrite('1.xls',d,'sheet1','E11');
%             case 10
%           % xlswrite('1.xls',distHistory,sheet10);
%            xlswrite('1.xls',d,'sheet1','E12');
% end   
% end