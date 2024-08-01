function r=rmse(data,estimate)

    tmp = data-estimate;
    tmp2 = tmp.^2;
    meanval = mean(tmp2);
    r = meanval^0.5;
    
end