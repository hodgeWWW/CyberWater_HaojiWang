function [ Gk_edited ] = editGraphEdge( Gk, i, j, val )
    Gk_edited = Gk;
    Gk_edited(i,j) = val;
    Gk_edited(j,i) = val;    
end

