function [ iter ] = printStatus( iter, sims, error, min_error )
    elapsed = toc;
    iter = iter + 1;
    eta = sims/iter*elapsed;
    remaining = eta-elapsed;

    display([num2str(iter) ' out of ' num2str(sims) ', elapsed=' num2str(elapsed) 'secs' , ', ETA=' num2str(eta) ', remaining=' num2str(remaining) ', error=' num2str(error) ', min.error=' num2str(min_error)]);
    
end

