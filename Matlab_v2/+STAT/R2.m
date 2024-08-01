function [ r2 ] = R2( x, y )
    
    r = corr(x,y);
    if isnan(r)
        r = 0;
    end    
    r2 = r.^2;
       
end

