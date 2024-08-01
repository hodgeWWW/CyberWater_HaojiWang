function [ name ] = getGaugeName( index )
%{
gauges = {
1	'ALDW2'
2	'ALPI3'
3	'ATHO1'
4	'BAKI3'
5	'BELW2'
6	'BOOK2'
7	'BSNK2'
8	'BUCW2'
9	'CLAI2'
10	'CLBK2'
11	'CRWI3'
12	'CYCK2'
13	'CYNK2'
14	'DBVO1'
15	'ELRP1'
16	'FDYO1'
17	'GAXV2'
18	'GRYV2'
19	'KINT1'
20	'MROI3'
21	'NHSO1'
22	'NWBI3'
23	'PRGO1'
24	'PSNW2'
25	'SERI3'
26	'SLMN6'
27	'SNCP1'
28	'STMI2'
29	'STRO1'
30	'UPPO1'
31	'VERO1'
32	'WTVO1'
33	'WUNO1'
34	'WYNI2'
};
%}
gauges = LABELS.getLabels();
name = gauges(index,:);
%name = name{1};
end

