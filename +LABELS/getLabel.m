function [ label ] = getLabel( idx, formatted )

    if nargin==1
        formatted  = false;
    end
        
    labels = LABELS.getLabels();
    label = labels(idx,:);
    
    if formatted
        [ label ] = LABELS.concatLabels( label );
    end    


end

