function [ Gfull ] = getFullGraph(p, list, donorGroup, targetGroup)
    Gfull = zeros(p,p);
    Gfull(list,list) = 1;
    
    %Gfull = PAPER_ALGORITHMS.UTIL.editGraphEdge(Gfull,4,22,0);    %改
    %Gfull = PAPER_ALGORITHMS.UTIL.editGraphEdge(Gfull,16,23,0);

    n = size(donorGroup,2);    
    for i=1:n
        for j=i+1:n
            gi = donorGroup(i);
            gj = donorGroup(j);
            Gfull(gi,gj) = 0;
            Gfull(gj,gi) = 0;  
        end    
    end    
    
    n = size(targetGroup,2);    
    for i=1:n
        for j=i+1:n
            gi = targetGroup(i);
            gj = targetGroup(j);
            Gfull(gi,gj) = 0;
            Gfull(gj,gi) = 0;  
        end    
    end 
    
end

