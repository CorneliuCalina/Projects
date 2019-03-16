function [ output] = part2_getValues( values,grad,clones_check) 
output_=[];
for i=1:2^length(values)-1
    %reprezentarea pe biti a fiecarui numar de la 1 la 2^length
    %functia returneaza reprezentarea si suma bitilor de "1" 
    [sum,matrix]=part2_getBits(i,length(values));
    %nu are rost sa inmultim termenii cu suma mai mica decat 1
    %sau suma mai mare decat gradul maxim (=m) 
    if sum > 1 && sum <= grad(end)+1
    produs=part2_multiplu(values,matrix,grad,clones_check);
    %conditie din part2_multip (vezi functia) 
    if produs ~= 10^40
    output_=[output_, produs];
    
     end

    end
end
output=output_;
end

