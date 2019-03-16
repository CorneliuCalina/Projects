function [ output ] = part2_multiplu( values,matrix,grad,clones)
sum=0;
produs=1; aux=[]; check=0;

%matricea returnata anterior in part2_getvalues
%verificam bitii de "1" si pentru fiecare pozitie
%in care gasim acesti biti, vom inmulti valorile si adunam gradul
%corespunzator acestor pozitii 

for i=1:length(values)
if matrix(i) == 1 sum=sum+grad(i);
    
end

   

produs=produs*values(i); aux=[aux, i];

%verificare sa nu existe dubluri
% exemplu matricea pe biti:
%[1 0 1 1 0 0] corespunde la
%[y(k-1) y(k-2) u(k-1) y^2(k-1) y^2(k-2) u^2(k-1)]
%algoritmul nostru va inmulti si y(k-1) cu y^2(k-1) dar noi avem
%deja un y^3(k-1) 

check=part2_bool_check(aux,clones);

if (sum <= (grad(end)+1) && check==0 )
    output=produs;
else
    output=10^40;
    end

end
