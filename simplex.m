format short 
clear all
clc

N=3
C =[-1 3 -2];
info =[3 -1 2; -2 4 0; -4 3 8];
b =[7; 12; 10]

s= eye(size(info,1));
A= [info s b]

Cost = zeros(1,size(A,2));
Cost(1:size(C,2))=C;

BV= (N+1:size(A,2)-1);
zjcj = Cost(BV)*A-Cost;

zcj=[zjcj;A];
simpTable = array2table(zcj);
simpTable.Properties.VariableNames(1:size(zcj,2)) = {'X_1','x_2','x_3','S_1','S_2','S_3','Sol'}

run=1

while run
if any(zjcj<0)
    [EnterCol,pvt_col]=min(zjcj(1:end-1));
    sol=A(:,end);
    column= A(:,pvt_col);
    for i=1:size(column,1)
        if column(i)>0
            ratio(i)=sol(i)/column(i);
        else
            ratio(i) = inf;
        end
    end
    [Leaverow,pvt_row]=min(ratio);
    BV(pvt_row)=pvt_col;
    pvt_key=A(pvt_row,pvt_col);
    
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:);
        end
    end
    zjcj=zjcj-zjcj(pvt_col)*A(pvt_row,:);


zcj=[zjcj;A];
simpTable = array2table(zcj);
simpTable.Properties.VariableNames(1:size(zcj,2)) = {'X_1','x_2','x_3','S_1','S_2','S_3','Sol'}

BFS = zeros(1,size(A,2));
BFS(BV)=A(:,end);
BFS(end)=zjcj(end)
else
    disp('Optimal Solution Reached')
    run=0;
end
end


    




