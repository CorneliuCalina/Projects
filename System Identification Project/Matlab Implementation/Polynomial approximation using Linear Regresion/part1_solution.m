clc;
clear all; close all;
warning('off','all'); load('proj_fit_08.mat');     x1=id.X{1,1};
x2=id.X{2,1};
y=id.Y; x1v=val.X{1,1};
x2v=val.X{2,1}; yv=val.Y; M=length(x1); mesh(x1,x2,y);
mesh(x1v,x2v,yv);
Nv=length(yv);
% =============IDENTIFICARE VALORI ===========
X1flat=[]; 
for i=1:M
x1linie=part1_fctforflat(M,x1(i)); 
X1flat=[X1flat,x1linie];
 
end
X2flat=[];
for i=1:M
for j=1:M
X2flat=[X2flat,x2(j)];
end
end
Xflat=[X1flat;X2flat];
Yflat=reshape(y,1,M*M);

%==============VALIDARE VALORI=============
X1val=[]; for i=1:Nv
x1vallinie=part1_fctforflat(Nv,x1v(i)); X1val=[X1val,x1vallinie];
end
X2val=[]; for i=1:Nv
for j=1:Nv
X2val=[X2val,x2v(j)];
end
end
Xvalflat=[X1val;X2val];

%========== variabile pentru a salva informatiile la gradul optim========== 
errid_minim=9999;
errval_minim=0; grad_optim=1; yidentificare_optim=[]; yvalidare_optim=[]; m_max=5;
for m=1:m_max
%====================IDENTIFICARE ============ 
PSI=[];
for i=1:M*M
L=part1_fforpsi(m,Xflat(:,i)); PSI=[PSI;L];
end
A=PSI\Yflat'; y_sim=PSI*A;
y_est=reshape(y_sim,M,M); e=sum((y-y_est).^2); MSE(m)=1/length(e)^2*sum(e);


%=============== VALIDARE =============  
PSIv=[];
for i=1:Nv*Nv
L=part1_fforpsi(m,Xvalflat(:,i)); PSIv=[PSIv;L];
end

y_simVAL=PSIv*A; y_estVAL=reshape(y_simVAL,Nv,Nv); eVAL = sum((yv-y_estVAL).^2);
MSEval(m)= 1/(length(eVAL)^2)*sum(eVAL);
 

%Determinare grad optim (cea mai mica eroare) 
if MSE(m) < errid_minim
errid_minim=MSE(m); errval_minim=MSEval(m); grad_optim=m; yidentificare_optim=y_est; yvalidare_optim=y_estVAL;
end

end

mesh(x1,x2,y);
figure;
mesh(x1,x2,yidentificare_optim);
title(['MSE identificare =',num2str(errid_minim)]); figure;
mesh(x1v,x2v,yvalidare_optim);
title(['MSE validare =',num2str(errval_minim)]); figure;
plot(1:m_max,MSE,'r',1:m_max,MSEval,grad_optim,MSE(grad_optim),'*g'); legend('identificare','validare');
