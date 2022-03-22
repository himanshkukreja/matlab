format short
clear all
clc
Cost =[0 0 0 0 0 -1 -1 0];
A =[3 -1 -1 -1 0 1 0 3; 1 -1 1 0 -1 0 1 2];
N=3;
BV = [6 7];
zjcj = Cost(BV)*A-Cost
zc = [zjcj;A]

run=true;
while(run)
if any(zjcj(1:end-1)<0)
    [EnterCol,pvt_col]=min(zjcj(1:end-1));
    sol=A(:,end);
    column=A(:,pvt_col);
    for i=1:size(column,1)
        if column(i)>=0
            ratio(i)=sol(i)/column(i);
        else
            ratio(i)=inf;
        end
    end
    [LeavRow,pvt_row]=min(ratio);
    BV(pvt_row)=pvt_col;
    pvt_key= A(pvt_row,pvt_col);
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:);
        end
    end
    zjcj = zjcj-zjcj(pvt_col)*A(pvt_row,:);
    zc = [zjcj;A]
    
else
    disp("OPTIMAL SOLUTION REACHED")
    run=false;
end
end

OptVal = zjcj(end)
BFS = zeros(1,size(A,2))
BFS(BV)=A(:,end)
BFS(end)=OptVal
    
    