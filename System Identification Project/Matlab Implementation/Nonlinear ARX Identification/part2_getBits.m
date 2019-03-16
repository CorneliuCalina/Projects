function [sum,output] = part2_getBits( number,bitsnumber) 
A=zeros(1,bitsnumber);
sum_=0; A(1)=mod(number,2); 
if A(1)==1
    sum_=sum_+1;
end
k=1;
while floor(number/2) ~= 0 
    number=floor(number/2); 
    A(k+1)=mod(number,2); 
    if A(k+1)==1
        sum_=sum_+1;
        
    end
    
end
k=k+1;
output=A; sum=sum_;
end
