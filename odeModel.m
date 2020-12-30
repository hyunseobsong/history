function [dydt,murho1,murho2] = odeModel(t,y,para)
n=length(y);
dydt=zeros(n,1);
x1=y(1);
x2=y(2);
s=y(3);

xmax=para.xmax;
sf=para.sf;
alpha=para.alpha; 

D = para.D;
kd2 = para.kd;
kd1 = para.kd;

Ys1=para.Ys1;
Ys2=para.Ys2;


% density dependent term
spaceLimit=(1-(x1+x2)/xmax);

rho1 = exp(-alpha*x1)*spaceLimit;
rho2 = spaceLimit;

k1_fs=para.k1_fs;
k2_fs=para.k2_fs;
K1_fs=para.K1_fs;
K2_fs=para.K2_fs;
mu1=k1_fs*s/(K1_fs+s);
mu2=k2_fs*s/(K2_fs+s);

murho1=mu1*rho1;
murho2=mu2*rho2;

dydt(1) = mu1*rho1*x1-kd1*x1;
dydt(2) = mu2*rho2*x2-kd2*x2;
dydt(3) = D*(sf-s)-(1/Ys1)*mu1*rho1*x1-(1/Ys2)*mu2*rho2*x2;