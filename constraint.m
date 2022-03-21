function hh = constraint(X)
    X1=X(:,1);
    X2=X(:,2);
    cons1 = X1+2.*X2-2000;
    h1=find(cons1>0);
    X(h1,:)=[];
    
    X1=X(:,1);
    X2=X(:,2);
    cons2 = X1+X2-1500;
    h2=find(cons2>0);
    X(h2,:)=[];
    
    X1=X(:,1);
    X2=X(:,2);
    cons3 = X2-600;
    h3=find(cons3>0);
    X(h3,:)=[];
    
hh=X;
end