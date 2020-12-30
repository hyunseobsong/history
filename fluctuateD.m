function [TT,YY,RR]=fluctuateD(tauLow,para,tauHigh,D_base,D_alpha,y0,t1,t2,TT,YY,RR,options) 

interval=tauHigh+tauLow;
D_up=D_base+D_alpha;
tspanAll=t1:interval:t2;

for it=1:length(tspanAll)-1
    t1=tspanAll(it);t2_=t1+tauLow;
    tspan_=[t1,t2_];
    para.D=D_base; 
    [T_,Y_]=ode15s(@odeModel,tspan_,y0,options,para);

    R_=zeros(length(T_),3);
    for ii=1:length(T_)
        y=Y_(ii,:);
        [dydt,murho1,murho2] = odeModel([],y,para);
        R_(ii,:)=[murho1*y(1),murho2*y(2),murho1*y(1)+murho2*y(2)];
    end
    
    y0=Y_(end,:);
    
    t1=t2_;t2=tspanAll(it+1);
    tspan=[t1,t2];
    para.D=D_up;
    [T,Y]=ode15s(@odeModel,tspan,y0,options,para);
    
    R=zeros(length(T),3);
    for ii=1:length(T)
        y=Y(ii,:);
        [dydt,murho1,murho2] = odeModel([],y,para);
        R(ii,:)=[murho1*y(1),murho2*y(2),murho1*y(1)+murho2*y(2)];
    end
    
    y0=Y(end,:);
    TT=[TT;T_;T];
    YY=[YY;Y_;Y];
    RR=[RR;R_;R];
end
