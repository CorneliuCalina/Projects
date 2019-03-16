function [out]= part1_fforpsi(m,x)
out=1;
for i=1:m
    out=[out, x(1,1)^i, x(2,1)^i]; for j=1:m
        if i+j<=m
            out=[out , (x(1,1)^j)*(x(2,1)^i)];
            
            
            
        end
        
        
    end
    
end


end
