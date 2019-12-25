function varargout =tsp_ga(u,re,m,n1,n2,n3,date1,date2,date3,dmat1,dmat2,dmat3,popSize,numIter,showProg,showResult);





% Sanity Checks
popSize = 4*ceil(popSize/4);
numIter = max(1,round(real(numIter(1))));
showProg = logical(showProg(1));
showResult = logical(showResult(1));
dims=2;
% Initialize the Population ��ʼ����Ⱥ
pop1 = zeros(popSize,n1); %popΪ500*200�ľ���
pop2 = zeros(popSize,n2); %popΪ500*200�ľ���
pop3 = zeros(popSize,n3); %popΪ500*200�ľ���
pop1(1,:) = (1:n1);%pop��һ����䡰1��2��3��4.....499��500��
for k = 2:popSize
    pop1(k,:) = randperm(n1);%pop��������������1����500֮�������
end
pop2(1,:) = (1:n2);%pop��һ����䡰1��2��3��4.....499��500��
for k = 2:popSize
    pop2(k,:) = randperm(n2);%pop��������������1����500֮�������
end
pop3(1,:) = (1:n3);%pop��һ����䡰1��2��3��4.....499��500��
for k = 2:popSize
    pop3(k,:) = randperm(n3);%pop��������������1����500֮�������
end
% Run the GA
globalMin1 = Inf;  %globalMinΪ�м��������¼ȫ������·�����ȣ���ʼ��Ϊ�����
globalMin2 = Inf; 
globalMin3 = Inf; 
totalDist1 = zeros(1,popSize); %totalDistΪ�м��������¼��Ⱥ��500��������Ե�·���ܳ��ȡ�
globalMin2 = Inf; 
globalMin3 = Inf; 
distHistory1 = zeros(1,numIter);%distHistoryΪ�м��������¼������ʷ������globalMin��
distHistory2 = zeros(1,numIter);%distHistoryΪ�м��������¼������ʷ������globalMin��
distHistory3 = zeros(1,numIter);%distHistoryΪ�м��������¼������ʷ������globalMin��
tmpPop1 = zeros(4,n1);%tmpPop�ڱ�������м�¼��ѡ��4�鸸ĸ�ľ���·����
newPop1 = zeros(popSize,n1);%newPop�ڱ�������м�¼������Ӵ��ľ���·����Ϊ500*200����
tmpPop2 = zeros(4,n2);%tmpPop�ڱ�������м�¼��ѡ��4�鸸ĸ�ľ���·����
newPop2 = zeros(popSize,n2);%newPop�ڱ�������м�¼������Ӵ��ľ���·����Ϊ500*200����
tmpPop3 = zeros(4,n3);%tmpPop�ڱ�������м�¼��ѡ��4�鸸ĸ�ľ���·����
newPop3 = zeros(popSize,n3);%newPop�ڱ�������м�¼������Ӵ��ľ���·����Ϊ500*200����
if showProg
    pfig = figure('Name','TSP_GA | Current Best Solution','Numbertitle','off');
end
for iter = 1:numIter %��������
    % Evaluate Each Population Member (Calculate Total Distance)
    for p = 1:popSize
        d = dmat1(pop1(p,n1),pop1(p,1)); % Closed Path ѡ������
        for k = 2:n1
            d = d + dmat1(pop1(p,k-1),pop1(p,k));  %�������ӡ���������
        end
        totalDist1(p) = d;  % ������Ӧ�� 
    end
        for p = 1:popSize
        d = dmat3(pop3(p,n3),pop3(p,1)); % Closed Path ѡ������
        for k = 2:n3
            d = d + dmat3(pop3(p,k-1),pop3(p,k));  %�������ӡ���������
        end
        totalDist3(p) = d;  % ������Ӧ�� 
        end
        for p = 1:popSize
        d = dmat2(pop2(p,n2),pop2(p,1)); % Closed Path ѡ������
        for k = 2:n2
            d = d + dmat2(pop2(p,k-1),pop2(p,k));  %�������ӡ���������
        end
        totalDist2(p) = d;  % ������Ӧ�� 
    end
    
    %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    % Find the Best Route in the Population
    [minDist1,index] = min(totalDist1);
    distHistory1(iter) = minDist1;
     % ������һ�ν�������õ�Ⱦɫ��
    if minDist1 < globalMin1
        globalMin1 = minDist1;
        optRoute1 = pop1(index,:);
        if showProg
            % Plot the Best Route
            figure(pfig);
            rte1 = optRoute1([1:n1 1]);
            if dims > 2, 
                plot3(date1(rte1,1),date1(rte1,2),date1(rte1,3),'r.-');
            else
                plot(date1(rte1,1),date1(rte1,2),'r.-');
            end
            title(sprintf('Total Distance = %1.4f, Iteration = %d',minDist1,iter));
        end
    end
    [minDist2,index] = min(totalDist2);
    distHistory2(iter) = minDist2;
     % ������һ�ν�������õ�Ⱦɫ��
    if minDist2 < globalMin2
        globalMin2 = minDist2;
        optRoute2 = pop2(index,:);
        if showProg
            % Plot the Best Route
            figure(pfig);
            rte2 = optRoute2([1:n2 1]);
            if dims > 2, 
                plot3(date2(rte2,1),date2(rte2,2),date2(rte2,3),'r.-');
            else
                plot(date2(rte2,1),date2(rte2,2),'r.-');
            end
            title(sprintf('Total Distance = %1.4f, Iteration = %d',minDist2,iter));
        end
    end
        [minDist3,index] = min(totalDist3);
    distHistory3(iter) = minDist3;
     % ������һ�ν�������õ�Ⱦɫ��
    if minDist3 < globalMin3
        globalMin3 = minDist3;
        optRoute3 = pop3(index,:);
   %     if showProg
    %        % Plot the Best Route
   %         figure(pfig);
   %         rte3 = optRoute3([1:n3 1]);
   %         if dims > 2, 
   %             plot3(date3(rte3,1),date3(rte3,2),date3(rte3,3),'r.-');
   %         else
  %              plot(date3(rte3,1),date3(rte3,2),'r.-');
    %        end
   %         title(sprintf('Total Distance = %1.4f, Iteration = %d',minDist3,iter));
  %  end
        
    end
    
    % Genetic Algorithm Operators
    randomOrder = randperm(popSize);%randperm��matlab�������������������һ���������С������������ܣ��������һ���������С������﷨��ʽ������y = randperm(n)����y�ǰ�1��n��Щ��������ҵõ���һ���������С�
    %randomOrderΪ����˳�����Ⱥ����������0-500����˳��
    for p = 4:4:popSize    %ÿ����ĸ���һ������0-500���ꡣ
        rtes1 = pop1(randomOrder(p-3:p),:);%rtes��¼ȡ�������鸸ĸ��Ϊ4*200����
        dists1 = totalDist1(randomOrder(p-3:p));  %dists��¼���鸸ĸ��·���ܾ��룬Ϊ4��ֵ��
        [ignore,idx] = min(dists1); %#ok %[ignore,idx]����min(dists)
        bestOf4Route1 = rtes1(idx,:);%bestOf4Route���浱ǰ���鸸ĸ�����ž���·��
        routeInsertionPoints1 = sort(ceil(n1*rand(1,2)));%rand(1,2)���������0-1����������0.0754��0.2734��ceil����ȡ����sort��ȡ���ĳ�������С��������Ȼ���routeInsertionPoints��
        I = routeInsertionPoints1(1);
        J = routeInsertionPoints1(2);%��routeInsertionPoints�е��������ֱ��I��J
        for k = 1:4 % Mutate the Best to get Three New Routes  ��������µĸ���  ���鸸ĸ��ȡ���Ÿ�����в�ͬ����������������ԭ�ϲ����顣
            tmpPop1(k,:) = bestOf4Route1;
            switch k
                case 2 % Flip I-J�н���
                    tmpPop1(k,I:J) = tmpPop1(k,J:-1:I);
                case 3 % Swap ֻI��J���н���
                    tmpPop1(k,[I J]) = tmpPop1(k,[J I]);
                case 4 % Slide
                    tmpPop1(k,I:J) = tmpPop1(k,[I+1:J I]);
                otherwise % Do Nothing
            end
        end
        newPop1(p-3:p,:) = tmpPop1;%��ǰ��������Ӵ�
    end
    pop1 = newPop1;


% Genetic Algorithm Operators
    randomOrder = randperm(popSize);%randperm��matlab�������������������һ���������С������������ܣ��������һ���������С������﷨��ʽ������y = randperm(n)����y�ǰ�1��n��Щ��������ҵõ���һ���������С�
    %randomOrderΪ����˳�����Ⱥ����������0-500����˳��
    for p = 4:4:popSize    %ÿ����ĸ���һ������0-500���ꡣ
        rtes2 = pop2(randomOrder(p-3:p),:);%rtes��¼ȡ�������鸸ĸ��Ϊ4*200����
        dists2 = totalDist2(randomOrder(p-3:p));  %dists��¼���鸸ĸ��·���ܾ��룬Ϊ4��ֵ��
        [ignore,idx] = min(dists2); %#ok %[ignore,idx]����min(dists)
        bestOf4Route2 = rtes2(idx,:);%bestOf4Route���浱ǰ���鸸ĸ�����ž���·��
        routeInsertionPoints2 = sort(ceil(n2*rand(1,2)));%rand(1,2)���������0-1����������0.0754��0.2734��ceil����ȡ����sort��ȡ���ĳ�������С��������Ȼ���routeInsertionPoints��
        I = routeInsertionPoints2(1);
        J = routeInsertionPoints2(2);%��routeInsertionPoints�е��������ֱ��I��J
        for k = 1:4 % Mutate the Best to get Three New Routes  ��������µĸ���  ���鸸ĸ��ȡ���Ÿ�����в�ͬ����������������ԭ�ϲ����顣
            tmpPop2(k,:) = bestOf4Route2;
            switch k
                case 2 % Flip I-J�н���
                    tmpPop2(k,I:J) = tmpPop2(k,J:-1:I);
                case 3 % Swap ֻI��J���н���
                    tmpPop2(k,[I J]) = tmpPop2(k,[J I]);
                case 4 % Slide
                    tmpPop2(k,I:J) = tmpPop2(k,[I+1:J I]);
                otherwise % Do Nothing
            end
        end
        newPop2(p-3:p,:) = tmpPop2;%��ǰ��������Ӵ�
    end
    pop2 = newPop2;


% Genetic Algorithm Operators
    randomOrder = randperm(popSize);%randperm��matlab�������������������һ���������С������������ܣ��������һ���������С������﷨��ʽ������y = randperm(n)����y�ǰ�1��n��Щ��������ҵõ���һ���������С�
    %randomOrderΪ����˳�����Ⱥ����������0-500����˳��
    for p = 4:4:popSize    %ÿ����ĸ���һ������0-500���ꡣ
        rtes3 = pop3(randomOrder(p-3:p),:);%rtes��¼ȡ�������鸸ĸ��Ϊ4*200����
        dists3 = totalDist3(randomOrder(p-3:p));  %dists��¼���鸸ĸ��·���ܾ��룬Ϊ4��ֵ��
        [ignore,idx] = min(dists3); %#ok %[ignore,idx]����min(dists)
        bestOf4Route3 = rtes3(idx,:);%bestOf4Route���浱ǰ���鸸ĸ�����ž���·��
        routeInsertionPoints3 = sort(ceil(n3*rand(1,2)));%rand(1,2)���������0-1����������0.0754��0.2734��ceil����ȡ����sort��ȡ���ĳ�������С��������Ȼ���routeInsertionPoints��
        I = routeInsertionPoints3(1);
        J = routeInsertionPoints3(2);%��routeInsertionPoints�е��������ֱ��I��J
        for k = 1:4 % Mutate the Best to get Three New Routes  ��������µĸ���  ���鸸ĸ��ȡ���Ÿ�����в�ͬ����������������ԭ�ϲ����顣
            tmpPop3(k,:) = bestOf4Route3;
            switch k
                case 2 % Flip I-J�н���
                    tmpPop3(k,I:J) = tmpPop3(k,J:-1:I);
                case 3 % Swap ֻI��J���н���
                    tmpPop3(k,[I J]) = tmpPop3(k,[J I]);
                case 4 % Slide
                    tmpPop3(k,I:J) = tmpPop3(k,[I+1:J I]);
                otherwise 
                     % Do Nothing
            end
        end
        newPop3(p-3:p,:) = tmpPop3;%��ǰ��������Ӵ�
    end
    pop3 = newPop3;
end



%if (u(1,1)<u(2,1)&&u(2,1)<u(3,1))
d = zeros(8); 
bijiao=Inf;
for k = 2:(n1-1)
    for kk = 2:(n2-1)
    d(1)=sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk-1),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk-1),2))^2)+sqrt((date1(optRoute1(k-1),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k-1),2)-date2(optRoute2(kk),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k-1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k-1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2);
    if d(1)< bijiao
       bijiao=d(1);
       jiaochadian1 = k;jiaochadian2 = k-1,jiaochadian3=kk-1,jiaochadian4=kk;
   end
    d(2)=sqrt((date1(optRoute1(k-1),1)-date2(optRoute2(kk-1),1))^2+(date1(optRoute1(k-1),2)-date2(optRoute2(kk-1),2))^2)+sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k-1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k-1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2);
   if d(2)< bijiao
       bijiao=d(2);
       jiaochadian1=k-1,jiaochadian2=k,jiaochadian3=kk-1,jiaochadian4=kk;
   end
   d(3)=sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk-1),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk-1),2))^2)+sqrt((date1(optRoute1(k+1),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k+1),2)-date2(optRoute2(kk),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k+1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k+1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2);
     if d(3)< bijiao
        bijiao=d(3);
       jiaochadian1=k,jiaochadian2=k+1,jiaochadian3=kk-1,jiaochadian4=kk;
     end
     d(4)=sqrt((date1(optRoute1(k+1),1)-date2(optRoute2(kk-1),1))^2+(date1(optRoute1(k+1),2)-date2(optRoute2(kk-1),2))^2)+sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k+1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k+1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk-1),1))^2);
     if d(4)< bijiao
       bijiao=d(4);
       jiaochadian1=k+1,jiaochadian2=k,jiaochadian3=kk-1,jiaochadian4=kk;
     end
   d(5)=sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk),2))^2)+sqrt((date1(optRoute1(k-1),1)-date2(optRoute2(kk+1),1))^2+(date1(optRoute1(k-1),2)-date2(optRoute2(kk+1),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k-1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k-1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2);
   if d(5)< bijiao
        bijiao=d(5);
       jiaochadian1=k,jiaochadian2=k-1,jiaochadian3=kk,jiaochadian4=kk+1;
   end
   d(6)=sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk+1),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk+1),2))^2)+sqrt((date1(optRoute1(k-1),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k-1),2)-date2(optRoute2(kk),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k-1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k-1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2);
      if d(6)< bijiao
        bijiao=d(6);
       jiaochadian1=k,jiaochadian2=k-1,jiaochadian3=kk+1,jiaochadian4=kk;
    end
   d(7)=sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk+1),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk+1),2))^2)+sqrt((date1(optRoute1(k+1),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k+1),2)-date2(optRoute2(kk),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k+1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k+1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2);
     if d(7)< bijiao
       bijiao=d(7);
       jiaochadian1=k,jiaochadian2=k+1,jiaochadian3=kk+1,jiaochadian4=kk;
     end
     d(8)=sqrt((date1(optRoute1(k),1)-date2(optRoute2(kk),1))^2+(date1(optRoute1(k),2)-date2(optRoute2(kk),2))^2)+sqrt((date1(optRoute1(k+1),1)-date2(optRoute2(kk+1),1))^2+(date1(optRoute1(k+1),2)-date2(optRoute2(kk+1),2))^2)-sqrt((date1(optRoute1(k),1)-date1(optRoute1(k+1),1))^2+(date1(optRoute1(k),2)-date1(optRoute1(k+1),2))^2)-sqrt((date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2+(date2(optRoute2(kk),1)-date2(optRoute2(kk+1),1))^2);
    if d(8)< bijiao
          bijiao=d(8);
       jiaochadian1=k,jiaochadian2=k+1,jiaochadian3=kk,jiaochadian4=kk+1;
   end
    end
end
jiaochadian1
jiaochadian2
jiaochadian3
jiaochadian4

if jiaochadian1<jiaochadian2
for k = 1:jiaochadian1
    optRoutee(k,:)=date1(optRoute1(k),:);
end
 if jiaochadian3 < jiaochadian4%û����
    for kk = jiaochadian3:-1:1
    optRoutee((jiaochadian1+jiaochadian3-kk+1),:)=date2(optRoute2(kk),:);
    end
    for  kkk = n2:-1:jiaochadian4
    optRoutee((jiaochadian1+jiaochadian3+n2-kkk+1),:)=date2(optRoute2(kkk),:);
    end
    for  kkkkk = jiaochadian2 : n1
    optRoutee((n2+kkkkk),:)=date1(optRoute1(kkkkk),:);
    end
 else     %û����
    for k = jiaochadian3 : n2
    optRoutee((jiaochadian1+k-jiaochadian3+1),:)=date2(optRoute2(k),:);
    end
     for k = 1 : jiaochadian4
    optRoutee((jiaochadian1+n2-jiaochadian4+k),:)=date2(optRoute2(k),:);
     end
    for k = jiaochadian2 : n1
    optRoutee((n2+k),:)=date1(optRoute1(k),:);
    end
 end
end


if jiaochadian1>jiaochadian2
for k = 1:jiaochadian2
    optRoutee(k,:)=date1(optRoute1(k),:);
end
 if jiaochadian3 < jiaochadian4
    for k = jiaochadian4 : n2
    optRoutee((jiaochadian2+k-jiaochadian4+1),:)=date2(optRoute2(k),:);
    end
     for  k = 1 : jiaochadian3
    optRoutee((jiaochadian2+n2+k-jiaochadian2),:)=date2(optRoute2(k),:);
     end
     for  k = jiaochadian1 :-1: 1
    optRoutee((jiaochadian1+n2+jiaochadian1-k+1),:)=date1(optRoute1(k),:);
    end
  else
    for k = jiaochadian4:-1 : 1
        optRoutee((jiaochadian2+jiaochadian4-k+1),:)=date2(optRoute2(k),:);
    end
     for k = n2 : -1 :jiaochadian3
        optRoutee((jiaochadian2+jiaochadian4+n2-k+1),:)=date2(optRoute2(k),:);
     end
    for k = jiaochadian1 : n1
    optRoutee((n2+k),:)=date1(optRoute1(k),:);
    end
 end
end
%end




%if (u(1,1)<u(2,1)&&u(2,1)<u(3,1))
d = zeros(8); 
bijiao=Inf;
for k = 2:(n1+n2-1)
    for kk = 2:(n3-1)
    d(1)=sqrt((optRoutee((k),1)-date3(optRoute3(kk-1),1))^2+(optRoutee((k),2)-date3(optRoute3(kk-1),2))^2)+sqrt((optRoutee((k-1),1)-date3(optRoute3(kk),1))^2+(optRoutee((k-1),2)-date3(optRoute3(kk),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k-1),1))^2+(optRoutee(k,2)-optRoutee((k-1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2);
    if d(1)< bijiao
       bijiao=d(1);
       jiaochadian1 = k;jiaochadian2 = k-1,jiaochadian3=kk-1,jiaochadian4=kk;
   end
    d(2)=sqrt((optRoutee((k-1),1)-date3(optRoute3(kk-1),1))^2+(optRoutee((k-1),2)-date3(optRoute3(kk-1),2))^2)+sqrt((optRoutee((k),1)-date3(optRoute3(kk),1))^2+(optRoutee((k),2)-date3(optRoute3(kk),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k-1),1))^2+(optRoutee(k,2)-optRoutee((k-1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2);
    if d(2)< bijiao
       bijiao=d(2);
       jiaochadian1=k-1,jiaochadian2=k,jiaochadian3=kk-1,jiaochadian4=kk;
    end
    d(3)=sqrt((optRoutee((k),1)-date3(optRoute3(kk-1),1))^2+(optRoutee((k),2)-date3(optRoute3(kk-1),2))^2)+sqrt((optRoutee((k+1),1)-date3(optRoute3(kk),1))^2+(optRoutee((k+1),2)-date3(optRoute3(kk),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k+1),1))^2+(optRoutee(k,2)-optRoutee((k+1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2);
     if d(3)< bijiao
        bijiao=d(3);
       jiaochadian1=k,jiaochadian2=k+1,jiaochadian3=kk-1,jiaochadian4=kk;
     end
    d(4)=sqrt((optRoutee((k+1),1)-date3(optRoute3(kk-1),1))^2+(optRoutee((k+1),2)-date3(optRoute3(kk-1),2))^2)+sqrt((optRoutee((k),1)-date3(optRoute3(kk),1))^2+(optRoutee((k),2)-date3(optRoute3(kk),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k+1),1))^2+(optRoutee(k,2)-optRoutee((k+1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk-1),1))^2);
     if d(4)< bijiao
       bijiao=d(4);
       jiaochadian1=k+1,jiaochadian2=k,jiaochadian3=kk-1,jiaochadian4=kk;
     end
    d(5)=sqrt((optRoutee((k),1)-date3(optRoute3(kk),1))^2+(optRoutee((k),2)-date3(optRoute3(kk),2))^2)+sqrt((optRoutee((k-1),1)-date3(optRoute3(kk+1),1))^2+(optRoutee((k-1),2)-date3(optRoute3(kk+1),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k-1),1))^2+(optRoutee(k,2)-optRoutee((k-1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2);
     if d(5)< bijiao
        bijiao=d(5);
       jiaochadian1=k,jiaochadian2=k-1,jiaochadian3=kk,jiaochadian4=kk+1;
     end
    d(6)=sqrt((optRoutee((k),1)-date3(optRoute3(kk+1),1))^2+(optRoutee((k),2)-date3(optRoute3(kk+1),2))^2)+sqrt((optRoutee((k-1),1)-date3(optRoute3(kk),1))^2+(optRoutee((k-1),2)-date3(optRoute3(kk),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k-1),1))^2+(optRoutee(k,2)-optRoutee((k-1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2);
     if d(6)< bijiao
        bijiao=d(6);
       jiaochadian1=k,jiaochadian2=k-1,jiaochadian3=kk+1,jiaochadian4=kk;
     end
    d(7)=sqrt((optRoutee((k),1)-date3(optRoute3(kk+1),1))^2+(optRoutee((k),2)-date3(optRoute3(kk+1),2))^2)+sqrt((optRoutee((k+1),1)-date3(optRoute3(kk),1))^2+(optRoutee((k+1),2)-date3(optRoute3(kk),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k+1),1))^2+(optRoutee(k,2)-optRoutee((k+1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2);
   
      if d(7)< bijiao
       bijiao=d(7);
       jiaochadian1=k,jiaochadian2=k+1,jiaochadian3=kk+1,jiaochadian4=kk;
      end
    d(8)=sqrt((optRoutee((k),1)-date3(optRoute3(kk),1))^2+(optRoutee((k),2)-date3(optRoute3(kk),2))^2)+sqrt((optRoutee((k+1),1)-date3(optRoute3(kk+1),1))^2+(optRoutee((k+1),2)-date3(optRoute3(kk+1),2))^2)-sqrt((optRoutee((k),1)-optRoutee((k+1),1))^2+(optRoutee(k,2)-optRoutee((k+1),2))^2)-sqrt((date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2+(date3(optRoute3(kk),1)-date3(optRoute3(kk+1),1))^2);
     if d(8)< bijiao
          bijiao=d(8);
       jiaochadian1=k,jiaochadian2=k+1,jiaochadian3=kk,jiaochadian4=kk+1;
   end
    end
end


if jiaochadian1<jiaochadian2
for k = 1:jiaochadian1
    optRouteee(k,:)=optRoutee(k,:);
end
 if jiaochadian3 < jiaochadian4%û����
    for kk = jiaochadian3:-1:1
    optRouteee((jiaochadian1+jiaochadian3-kk+1),:)=date3(optRoute3(kk),:);
    end
    for  kkk = n3:-1:jiaochadian4
    optRouteee((jiaochadian1+jiaochadian3+n3-kkk+1),:)=date3(optRoute3(kkk),:);
    end
    for  kkkkk = jiaochadian2 : (n1+n2)
    optRouteee((n3+kkkkk),:)=optRoutee(kkkkk,:);
    end
 else     %û����
    for k = jiaochadian3 : n3
    optRouteee((jiaochadian1+k-jiaochadian3+1),:)=date3(optRoute3(k),:);
    end
     for k = 1 : jiaochadian4
    optRouteee((jiaochadian1+n3-jiaochadian4+k),:)=date3(optRoute3(k),:);
     end
    for k = jiaochadian2 : n1+n2
    optRouteee((n3+k),:)=optRoutee(k,:);
    end
 end
end


if jiaochadian1>jiaochadian2
for k = 1:jiaochadian2
    optRouteee(k,:)=optRoutee(k,:);
end
 if jiaochadian3 < jiaochadian4
    for k = jiaochadian4 : n3
    optRouteee((jiaochadian2+k-jiaochadian4+1),:)=date3(optRoute3(k),:);
    end
     for  k = 1 : jiaochadian3
    optRouteee((jiaochadian2+n3+k-jiaochadian3-jiaochadian4+1),:)=date3(optRoute3(k),:);
     end
     for  k = jiaochadian1 :(n1+n2)
    optRouteee((n3+k),:)=date1(optRoute1(k),:);
    end
  else
    for k = jiaochadian4:-1 : 1
        optRouteee((jiaochadian2+jiaochadian4-k+1),:)=date3(optRoute3(k),:);
    end
     for k = n3 : -1 :jiaochadian3
        optRouteee((jiaochadian2+jiaochadian4+n3-k+1),:)=date3(optRoute3(k),:);
     end
    for k = jiaochadian1 : n1+n2
    optRouteee((n3+k),:)=optRouteee(k,:);
    end
 end
end

d = sqrt((optRouteee(1,1)-(optRouteee(m,1)))^2+(optRouteee(1,2)-(optRouteee(m,2)))^2);
        for k = 2:m
            d = d + sqrt((optRouteee(k-1,1)-(optRouteee(k,1)))^2+(optRouteee(k-1,2)-(optRouteee(k,2)))^2);  %�������ӡ���������
        end

          figure(pfig);
          rte = 1:m;
          rte(m+1)=1;
          plot(optRouteee(rte,1),optRouteee(rte,2),'r.-');
          title(sprintf('Total Distance = %1.4f, Iteration = %d',d,iter));
   
% ��ͼ
if showResult
    % Plots the GA Results
    figure('Name','TSP_GA | Results','Numbertitle','off');
    % subplot(2,2,1);
    figure(1),
    pclr = ~get(0,'DefaultAxesColor');
    if dims > 2, 
        plot3(date1(:,1),date1(:,2),date1(:,3),'.','Color',pclr);
    else
        plot(date1(:,1),date1(:,2),'.','Color',pclr)
        hold on
        plot(date3(:,1),date3(:,2),'.','Color',pclr)
        hold on
        plot(date3(:,1),date3(:,2),'.','Color',pclr)
    end
    title('����λ��');
    grid on
%     subplot(2,2,2);
    figure(3),
    rte1 = optRoute1([1:n1 1]);
    rte2 = optRoute2([1:n2 1]);
    rte3 = optRoute3([1:n3 1]);
    if dims > 2, plot3(date1(rte,1),date1(rte,2),date1(rte,3),'r.-');
    else
        plot(date1(rte1,1),date1(rte1,2),'r.-')
        hold on
        plot(date2(rte2,1),date2(rte2,2),'g.-')
        hold on
        plot(date3(rte3,1),date3(rte3,2),'b.-')
        hold on
    for i=1:m 
    if re(i,3)==1   
         plot(re(i,1),re(i,2),'ro'); 
    elseif re(i,3)==2
         plot(re(i,1),re(i,2),'go'); 
    else 
         plot(re(i,1),re(i,2),'bo'); 
    end
    end
    end
    title(sprintf('��̾��� = %1.4f',minDist1,minDist2,minDist3));
    grid on
%     subplot(2,2,4);
    for k=1:numIter
        distHistory(k)=distHistory1(k)+distHistory2(k)+distHistory3(k);
    end
    figure(4),
    plot(distHistory,'b','LineWidth',2);
    hold on
    title('Best fitness curve');
    grid on
    set(gca,'XLim',[0 numIter+1],'YLim',[0 1.1*max([1 distHistory])]);
end

% Return Outputs
if nargout
    varargout{1} = d;
    
end
