clc;  clear all; close all;
load('iddata-04.mat'); uid=id.u;
yid=id.y; uval=val.u; yval=val.y; na=3;
nb=3; PSI=[]; m=3; L=[];
min=9999;
MSEid=[];
MSEval=[];
MSEidentificareEXCEL=[]; MSEvalidareEXCEL=[];

% ==================PREDICTIE================
% ==================IDENTIFICARE=============
for x=1:na
    for j=1:nb
        for k=1:m
            PSI=[];
            PSIval=[];
            for i=1:length(yid) 
                L=part2_GetLine(yid,uid,x,j,i,k); 
                PSI=[PSI;L];
            end
            theta=PSI\yid; 
            y_est=PSI*theta; 
            e=(yid-y_est).^2;
            MSEid=1/length(e)*sum(e); 
            MSEidentificareEXCEL=[MSEidentificareEXCEL, MSEid];
            
            
            % ==================VALIDARE================= 
            PSIval=[];
            Lval=[];
            for i=1:length(yval)
                Lval=part2_GetLine(yval,uval,x,j,i,k);
                PSIval=[PSIval;Lval];
            end
            y_estval=PSIval*theta; eval=(yval-y_estval).^2;
            
            MSEval=1/length(eval)*sum(eval); 
            MSEvalidareEXCEL=[MSEvalidareEXCEL,MSEval];
            
                if MSEval<min
                na_optim=x; nb_optim=j; m_optim=k; min=MSEval; theta_optim=theta; yid_estimat=y_est;
                yval_estimat=y_estval; MSEvalidare=MSEval; MSEidentificare=MSEid;     
                end
        end
    
    end  
  end

plot([yid_estimat,yid])
title(['=PREDICTIE= MSE Identificare =',num2str(MSEidentificare)]); figure;
plot([yval_estimat,yval]);
title(['=PREDICTIE= MSE Validare =',num2str(MSEvalidare)]);

%=================SIMULARE====================
% ==================IDENTIFICARE============= 
PSI=[];
y_est_simulare=zeros(length(yid),1); for i=1:length(yid)
    L=part2_GetLine(y_est_simulare,uid,na_optim,nb_optim,i,m_optim); y_est_simulare(i)=L*theta_optim;
    PSI=[PSI;L];
end


e=(yid-y_est_simulare).^2; MSE=1/length(e)*sum(e);

figure;
plot([y_est_simulare,yid]); 
legend('y estimat','y normal');
title(['=SIMULARE= MSE IDENTIFICARE =',num2str(MSE)]);

% ===================VALIDARE===================== 
PSI=[];
y_est_simulare=zeros(length(yval),1); for i=1:length(yval)
    L=part2_GetLine(y_est_simulare,uval,na_optim,nb_optim,i,m_optim);
    y_est_simulare(i)=L*theta_optim;
    PSI=[PSI;L];
end
eval=(yval-y_est_simulare).^2; MSEval=1/length(eval)*sum(eval);
figure; plot([y_est_simulare,yval]); legend('y estimat','y normal');
title(['=SIMULARE= MSE VALIDARE =',num2str(MSEval)]);
