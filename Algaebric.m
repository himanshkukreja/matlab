format short 
clear all
clc

C=[2 3 4 7];
A=[2 3 -1 4; 1 -2 6 -7];
b= [8;-3];

n=size(A,2) %variables
m=size(A,1) %constraints

nv= nchoosek(n,m);
t=nchoosek(1:n,m);

sol=[];
if n>=m
for i=1:nv
    y=zeros(n,1);
    x=A(:,t(i,:))\b;
    if all(x>=0 & x~=inf &x~=-inf)
        y(t(i,:))=x;   
        sol=[sol y];
    end
end
else
    error('Equations larger than Constraints')
end

Z=C*sol;
[Zmax,Zind] = max(Z);
BFS = sol(:,Zind)'

optval=[BFS,Zmax];
optimal_BFS = array2table(optval);
optimal_BFS.Properties.VariableNames(1:size(optimal_BFS,2)) = {'X_1','x_2','x_3','x_4','Value_of_Zmax'}


