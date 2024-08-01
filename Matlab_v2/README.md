----------------------------------------------------------------------------------------------
Copyright (c) 2021, German A. Villalba, Xu Liang, and Yao Liang
All rights reserved.

This is our research open source codes for (1) selecting donor gauges and
(2) removing gauges with minimum loss of information based on Graphical Model
under the Open Source License GPL.

If you use our codes, please cite our work below. Thanks.

Villalba, G. A., Liang, X., & Liang, Y. (2021). 
Selection of multiple donor gauges via graphical lasso for estimation of daily streamflow time series.
Water Resources Research, 57, e2020WR028936.
https://doi.org/10.1029/2020WR028936

----------------------------------------------------------------------------------------------

# daily-streamflow-glasso

# The main algorithms from the paper are:
1. Selection of Graphical Model (SGM) & 2. Removal of Gauge (RG)

# The Matlab source code for these algorithms is in the following path: 
1. daily-streamflow-glasso/+PAPER_ALGORITHMS/+MAIN/SelectionGraphicalModel.m
2. daily-streamflow-glasso/+PAPER_ALGORITHMS/+MAIN/RemovalOfGauges.m


# In order to run the algorithm with the datasets used in the paper execute the following Matlab scripts:

For a Single sample using the entire dataset:
daily-streamflow-glasso/+PAPER_ALGORITHMS/RUN/runPaperAlgorithmsMainSingle.m

