
function [ mean_error_summary] = getErrorSummary( p, count, ActualDistReg, ActualCorrReg, ActualGlassoKReg, Expected, list )
    discardFrac = (p - count) / p;
    useNse = false; % false %(Default)
    [ error_dist_reg_nn ] = PAPER_ALGORITHMS.HELPER.calcError( ActualDistReg, Expected, list, discardFrac, useNse );
    [ error_corr_reg_nn ] = PAPER_ALGORITHMS.HELPER.calcError( ActualCorrReg, Expected, list, discardFrac, useNse );
    [ error_glasso_reg_nn ]   = PAPER_ALGORITHMS.HELPER.calcError( ActualGlassoKReg, Expected, list, discardFrac, useNse );

    mean_error_summary = [error_dist_reg_nn error_corr_reg_nn  error_glasso_reg_nn];
end

