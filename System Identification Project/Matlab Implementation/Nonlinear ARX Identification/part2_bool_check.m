function [ output_bool ] = part2_bool_check( vector , clone) 
output_=0;
for i=1:length(vector)
    for j=1:length(vector)
        if mod(vector(i)-vector(j),clone)==0 && i~=j 
            output_=1;
           
        end
           
    end
  
end

output_bool=output_;
end
