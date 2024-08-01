function [ CorrMat ] = getCorrMatrix( X )
    CorrMat = corr(X);
    p = size(CorrMat,1);
    for i = 1:p
        CorrMat(i,i) = 0;
    end
end

