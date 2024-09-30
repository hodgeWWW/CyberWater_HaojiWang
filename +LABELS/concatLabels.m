function [ cLabels ] = concatLabels( labels )

    n = size(labels,1);
    cLabels = labels(1,:);
    for i=2:n
      cLabels = [ cLabels ', ' labels(i,:)] 
    end    

end

