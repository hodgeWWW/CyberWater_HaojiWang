clear all

fID = fopen('Data_file_mmperday.txt','r');
Array = fscanf(fID, '%e', [24, Inf]); % 24: year, month, day then 21 models
models=[ "美国1" ; "美国2";"加拿大"; ...
  "美国3";"韩国";"德国1"; ...
  "印度";"意大利";"法国1"; ...
  "俄罗斯";"英国1";"日本"; ...
  "德国2";"澳大利亚";"台湾"; ...
  "中国1";"法国2";"挪威"; ...
  "欧洲联合";"英国2";"中国2"]
% k day sum
% data starts from col 4 to col24
%========================
% if want to use a big matrix


days=[1, 10, 20,30 ];
num_cases=length(days);
edges = [-3:0.2:3]; % for plot normal pdf
for m=1:num_cases
    Bigz=[]; % store z1 to z21];
    figure(m)
    if m>1
        s1=num2str(days(m));
        s2="-day sum";
        
        ss=strcat(s1,s2);
    else 
        ss="original data";
    end
    
   for mN=1:21  % 21 models  from 4;24
  
        data=Array(mN+3,:);
        
        k=days(m);
        n=length(data);
        i=k:k:n;
        nk=length(i);
        datak=zeros(nk,1);
        j=0;
        for i=k:k:n
            j=j+1;
            datak(j)=sum(data(i-k+1:i));
        end
        
        datak=datak+0.001;
        log_data = log(datak);
    clear h;
    % Perform the Shapiro-Wilk test
    [h,p] = adtest(log_data);
    %[h,p] = kstest(log_data);
    % h==1 or ==0
      % h=0 lognormal
      % h=1, failed
   
    subplot(7,3,mN);
    
    z=(log_data-mean(log_data))/std(log_data);
    % save Bigz=[z1..z21]============

    Bigz=[Bigz z];
    %=====================
    %histogram(x, edges,'Normalization','probability'); hold on
    h=histogram(z, edges,'Normalization', 'pdf'); hold on;
    
    norm=normpdf(edges, 0,1);
    plot(edges,norm,'LineWidth',3 ); hold off;
  
    
   
    % new
   % left=re
     if rem(mN,3)==1
        ylabel('pdf');
     end
     
     if mN>=19
       xlabel('norm. log(data)');
     end
     ylim([0 0.5]);
     xlim([-3 3]);
     if(h==0)
          s="likely";
     else
          s="unlikely";
     end
     title(models(mN));
    
     end %mN 
     % save sample covariance
     
     sgtitle(ss);
     sss=".fig";
     ss=strcat(ss,sss);
     savefig(ss);
     % Bigz is a matrix [z1...z21]
     S=cov(Bigz); % sample covariance
     % I print out the matrix with two decimal points using
     %num2str(S,'%.2f  ')
   end %m
   clear z; 
   clear Bigz;
   
    clear datak;

%==========================

