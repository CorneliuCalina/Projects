function [L] = part2_GetLine(yid,uid,na,nb,k,m)
yid=[zeros(1,na),yid'];
uid=[zeros(1,nb),uid'];
values=[];

%Matricea valorilor de tipul:
%[y u y^2 u^2 ... y^m u^m]
%unde y=[y(k-1)..y(k-na)]
%si u=[u(k-1)..u(k-nb)]

values=[yid(k+na-1:-1:k),uid(k+nb-1:-1:k)]; 
auxmatrix=values;
for i=2:m
    values=[values, auxmatrix.^i];
end

%Matricea gradelor de tipul:
%[1 1 1 2 2 2 ... m m m] -> exemplu pentru na+nb=3;
%-> 1 corespunde elementelor y,u
%-> 2 corespunde elementelor y^2, u^2 s.a.m.d 
gr=ones(1,(na+nb)*m);
for i=1:m-1
    gr((i*(na+nb)+1):(i+1)*(na+nb))=i+1;
end

%vom lua doar valorile (m-1)*(na+nb) deoarece ultimele (na+nb) valori
%vor avea deja gradul m si inmultite cu alti termeni vor avea gradul >m 
L=[1,values,part2_getValues(values(1:(m-1)*(na+nb)),gr(1:(m-1)*(na+nb)),na+nb)]; 
end
