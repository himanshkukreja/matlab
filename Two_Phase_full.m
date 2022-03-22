clear all
clc
Variables= {'x_1','x_2','s_1','s_2','A_1','A_2','sol'};
OVariables={'x_1','x_2','s_1','s_2','sol'};
OrigC = [-3 -5 0 0 -1 -1 0];

Info = [1 3 -1 0 1 0 3;1 1 0 -1 0 1 2]

BV=[5 6];

%PHASE-1
fprintf('********** PHASE-1 ********** \n')
Cost=[0 0 0 0 -1 -1 0]
A=Info;
StartBV=find(Cost<0); %define the artificial variables

% compute zj-cj
ZjCj=Cost(BV)*A-Cost;

RUN= true;
while RUN
    ZC=ZjCj(:,1:end-1);
     if any(ZC<0)
         fprintf(' The current BFS is not optimal\n')
         [ent_col,pvt_col]=min(ZC);
         fprintf('Entering Col =%d \n' , pvt_col);
         sol=A(:,end);
         Column=A(:,pvt_col);
         if Column<=0
         error('LPP is unbounded');
         else
             for i=1:size(A,1)
                 if Column(i)>0
                 ratio(i)=sol(i)./Column(i);
                 else
                 ratio(i)=inf;
                 end
             end
         [MinRatio,pvt_row]=min(ratio);
         fprintf('leaving Row=%d \n', pvt_row);
         end
             BV(pvt_row)=pvt_col;
             pvt_key=A(pvt_row,pvt_col);
             A(pvt_row,:)=A(pvt_row,:)./ pvt_key;
             for i=1:size(A,1)
                 if i~=pvt_row
                 A(i,:)=A(i,:)- A(i,pvt_col).*A(pvt_row,:);
                 end
             end
         ZjCj=ZjCj-ZjCj(pvt_col).*A(pvt_row,:)
         ZCj=[ZjCj;A]
         TABLE=array2table(ZCj);
         TABLE.Properties.VariableNames(1:size(ZCj,2))=Variables
         BFS(BV)=A(:,end)
     else
     RUN=false;
     fprintf(' Current BFS is Optimal \n');
     fprintf('Phase 1 End \n')
     BFS=BV;
     end
end

%PHASE-2
fprintf('********** PHASE-2 ********** \n')
A(:,StartBV)=[]; %Removing Artificial var by giving them empty value
OrigC(:,StartBV)=[]; %Removing Artificial var cost by giving them empty value
ZjCj=OrigC(BV)*A-OrigC;
RUN= true;
while RUN
 ZC=ZjCj(:,1:end-1);
 if any(ZC<0)
 fprintf(' The current BFS is not optimal\n')
 [ent_col,pvt_col]=min(ZC);
 fprintf('Entering Col =%d \n' , pvt_col);
 sol=A(:,end);
 Column=A(:,pvt_col);
 if Column<=0
 error('LPP is unbounded');
 else
 for i=1:size(A,1)
 if Column(i)>0
 ratio(i)=sol(i)./Column(i);
 else
 ratio(i)=inf;
 end
 end
 [MinRatio,pvt_row]=min(ratio);
 fprintf('leaving Row=%d \n', pvt_row);
 end
 BV(pvt_row)=pvt_col;
 pvt_key=A(pvt_row,pvt_col);
 A(pvt_row,:)=A(pvt_row,:)./ pvt_key;
 for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)- A(i,pvt_col).*A(pvt_row,:);
 end
 end
 ZjCj=ZjCj-ZjCj(pvt_col).*A(pvt_row,:)
 ZCj=[ZjCj;A]
 TABLE=array2table(ZCj);
TABLE.Properties.VariableNames(1:size(ZCj,2))=OVariables
 BFS(BV)=A(:,end)
 else
 RUN=false;
 fprintf(' Current BFS is Optimal \n');
 fprintf('Phase End \n')
 BFS=BV;
 end
end

FINAL_BFS=zeros(1,size(A,2));
FINAL_BFS(BFS)=A(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*OrigC);
OptimalBFS= array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))= OVariables