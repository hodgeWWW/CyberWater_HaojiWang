clc; clear;


ha = tightfig.tight_subplot(1,2);%,[.01 .03],[.1 .01],[.01 .01])
for ii = 1:2; 
    axes(ha(ii)); 
    plot(randn(10,ii)); 
end

set(ha(1:2),'XTickLabel',''); 
set(ha,'YTickLabel','')