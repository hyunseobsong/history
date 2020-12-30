function goSimulation(task)

%-- options for ode solver
options=odeset('NonNegative',1:3);

%-- collection of variables to plot  
DD=[]; % dilution rate
YYend=[]; % variables at the final time [x,y,z]
RR=[]; % reaction rates [rp,rq,rz]

%-- set parameter values 
[para,y0,D_alpha,tauHigh]=getPara;


switch task
    case 'x_vs_D'
        tspan=[0,10000]; % long time horizon for steady state
        D_end=0.4; % for plot
        
        %-- get the relationships between steady-state x,y, and z as a function of D
        for D_base=0.005:(D_end-0.01)/200:D_end
            para.interval=5; para.tauHigh = 0.5/para.interval;
            para.D=D_base;
            [T,Y]=ode15s(@odeModel,tspan,y0,options,para);
            DD=[DD;D_base];
            YYend=[YYend;Y(end,:)];
            
            t=[];y=Y(end,:);
            [dydt,murho1,murho2] = odeModel(t,y,para);
            rr=[murho1*y(1),murho2*y(2),murho1*y(1)+murho2*y(2)];
            RR=[RR;rr];
        end
        
        %-- plot the results
        plotXvsD(DD,YYend,RR)

        
	%-----------------------------------------------------
    case 'resilience'
        %-- fix operational parameters 
        D_base = 0.09; % base dilution rate 
        tend_ss=200; % time to attain steady state
        tend_oscil=1000; % sduration perturbed with period oscillation
                
        %-- attain steady state
        para.D=D_base;
        tspan=[0,tend_ss];
        [T,Y]=ode15s(@odeModel,tspan,y0,options,para);

        %-- take the end-time values as base     
        y0_base=Y(end,:); 
        t=[];y=Y(end,:);
        [dydt,murho1,murho2] = odeModel(t,y,para);
        r0_base=[murho1*y(1),murho2*y(2),murho1*y(1)+murho2*y(2)];

        %-- define variables to plot (2% band; 5% band) 
        inunInterval=[];
        
        %--- x1=species 1(=x), x2=species 2(=y), x12=nutrient(=z) 
        x1=[];x2=[];x12=[];
        timeRecovery2_X1=[]; 
        timeRecovery2_X2=[];
        timeRecovery2_X12=[];
        timeRecovery5_X1=[];
        timeRecovery5_X2=[];
        timeRecovery5_X12=[];

        %--- r1=production of p(=rp), r2=productio of q(=rq), r12=consumption of z(=rz) 
        r1=[];r2=[];r12=[];
        timeRecovery2_R1=[];
        timeRecovery2_R2=[];
        timeRecovery2_R12=[];
        timeRecovery5_R1=[];
        timeRecovery5_R2=[];
        timeRecovery5_R12=[];        
        
        %-- fluctuate D (dilution rate)
        for tauLow=[0.1,1:10]
            y0=y0_base;
            interval=tauHigh+tauLow;
            D_up=D_base+D_alpha;

            tspanAll=0:interval:tend_oscil;
            TT=[];YY=[];
            RR=[];
            for it=1:length(tspanAll)-1                
                %--- maintain the base dilution rate 
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

                %--- increase the dilution rate 
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
                
                %--- collect the variables to plot
                TT=[TT;T_;T]; % time 
                YY=[YY;Y_;Y]; % x,y,z
                RR=[RR;R_;R]; % rp,rq,rz
            end
            
            %-- get the values of x(=x1),y(=x2) and z(=x12) before recovery starts
            iTT=min(find(TT>=300)); % take data from sustained oscillation
            x1_=[mean(YY(iTT:end,1)),max(YY(iTT:end,1))-mean(YY(iTT:end,1))];
            x2_=[mean(YY(iTT:end,2)),max(YY(iTT:end,2))-mean(YY(iTT:end,2))];
            x12_=[mean(YY(iTT:end,3)),max(YY(iTT:end,3))-mean(YY(iTT:end,3))];
            x1=[x1;x1_];
            x2=[x2;x2_];
            x12=[x12;x12_];

            %-- get the values of rp(=r1),rq(=r2) and rz(=r12) before recovery starts
            r1_=[mean(RR(iTT:end,1)),max(RR(iTT:end,1))-mean(RR(iTT:end,1))];
            r2_=[mean(RR(iTT:end,2)),max(RR(iTT:end,2))-mean(RR(iTT:end,2))];
            r12_=[mean(sum(RR(iTT:end,1:2),2)),max(sum(RR(iTT:end,1:2),2))-mean(sum(RR(iTT:end,1:2),2))];
            r1=[r1;r1_];
            r2=[r2;r2_];
            r12=[r12;r12_]; 
            
            %-- release perturbation 
            t1=t2; t2=t1+200;
            tspan=t1:0.001:t2;
            para.D=D_base;
            [T,Y]=ode15s(@odeModel,tspan,y0,options,para);
            R=zeros(length(T),3);
            for ii=1:length(T)
                y=Y(ii,:);
                [dydt,murho1,murho2] = odeModel([],y,para);
                R(ii,:)=[murho1*y(1),murho2*y(2),murho1*y(1)+murho2*y(2)];
            end
            
            %-- collect the variables to plot
            TT=[TT;T]; % time 
            YY=[YY;Y]; % x,y,z
            RR=[RR;R]; % rp,rq,rz
            
            
            %-- plot the results
            plotResilienceA(TT,YY,RR,tend_oscil,tauLow,tauHigh)

            %-- get hitting and settling times
            inunInterval_=tauHigh+tauLow;

            X1=Y(:,1); x1Base=y0_base(1); 
            X2=Y(:,2); x2Base=y0_base(2);
            X12=Y(:,3); x12Base=y0_base(3);

            R1=R(:,1); r1Base=r0_base(1); 
            R2=R(:,2); r2Base=r0_base(2);
            R12=sum(R(:,1:2),2); r12Base=r0_base(1)+r0_base(2);
            
            
            inunInterval=[inunInterval;inunInterval_];
            
            tRmin2_X1=T(min(find(abs(X1-x1Base)<=x1Base*0.02)))-T(1);
            tRmax2_X1=T(max(find(abs(X1-x1Base)>x1Base*0.02))+1)-T(1);
            tRmin2_X2=T(min(find(abs(X2-x2Base)<=x2Base*0.02)))-T(1);
            tRmax2_X2=T(max(find(abs(X2-x2Base)>x2Base*0.02))+1)-T(1);
            tRmin2_X12=T(min(find(abs(X12-x12Base)<=x12Base*0.02)))-T(1);
            tRmax2_X12=T(max(find(abs(X12-x12Base)>x12Base*0.02))+1)-T(1);

            tRmin5_X1=T(min(find(abs(X1-x1Base)<=x1Base*0.05)))-T(1);
            tRmax5_X1=T(max(find(abs(X1-x1Base)>x1Base*0.05))+1)-T(1);
            tRmin5_X2=T(min(find(abs(X2-x2Base)<=x2Base*0.05)))-T(1);
            tRmax5_X2=T(max(find(abs(X2-x2Base)>x2Base*0.05))+1)-T(1);
            tRmin5_X12=T(min(find(abs(X12-x12Base)<=x12Base*0.05)))-T(1);
            tRmax5_X12=T(max(find(abs(X12-x12Base)>x12Base*0.05))+1)-T(1);
            
            if isempty(tRmax2_X1),tRmax2_X1=0;end
            if isempty(tRmax2_X2),tRmax2_X2=0;end
            if isempty(tRmax2_X12),tRmax2_X12=0;end

            if isempty(tRmax5_X1),tRmax5_X1=0;end
            if isempty(tRmax5_X2),tRmax5_X2=0;end
            if isempty(tRmax5_X12),tRmax5_X12=0;end
            
            timeRecovery2_X1_=[tRmin2_X1,tRmax2_X1];
            timeRecovery2_X2_=[tRmin2_X2,tRmax2_X2];
            timeRecovery2_X12_=[tRmin2_X12,tRmax2_X12];

            timeRecovery5_X1_=[tRmin5_X1,tRmax5_X1];
            timeRecovery5_X2_=[tRmin5_X2,tRmax5_X2];
            timeRecovery5_X12_=[tRmin5_X12,tRmax5_X12];
                       
            timeRecovery2_X1=[timeRecovery2_X1;timeRecovery2_X1_];
            timeRecovery2_X2=[timeRecovery2_X2;timeRecovery2_X2_];
            timeRecovery2_X12=[timeRecovery2_X12;timeRecovery2_X12_];
            
            timeRecovery5_X1=[timeRecovery5_X1;timeRecovery5_X1_];
            timeRecovery5_X2=[timeRecovery5_X2;timeRecovery5_X2_];
            timeRecovery5_X12=[timeRecovery5_X12;timeRecovery5_X12_];

            %---
            tRmin2_R1=T(min(find(abs(R1-r1Base)<=r1Base*0.02)))-T(1);
            tRmax2_R1=T(max(find(abs(R1-r1Base)>r1Base*0.02))+1)-T(1);
            tRmin2_R2=T(min(find(abs(R2-r2Base)<=r2Base*0.02)))-T(1);
            tRmax2_R2=T(max(find(abs(R2-r2Base)>r2Base*0.02))+1)-T(1);
            tRmin2_R12=T(min(find(abs(R12-r12Base)<=r12Base*0.02)))-T(1);
            tRmax2_R12=T(max(find(abs(R12-r12Base)>r12Base*0.02))+1)-T(1);

            tRmin5_R1=T(min(find(abs(R1-r1Base)<=r1Base*0.05)))-T(1);
            tRmax5_R1=T(max(find(abs(R1-r1Base)>r1Base*0.05))+1)-T(1);
            tRmin5_R2=T(min(find(abs(R2-r2Base)<=r2Base*0.05)))-T(1);
            tRmax5_R2=T(max(find(abs(R2-r2Base)>r2Base*0.05))+1)-T(1);
            tRmin5_R12=T(min(find(abs(R12-r12Base)<=r12Base*0.05)))-T(1);
            tRmax5_R12=T(max(find(abs(R12-r12Base)>r12Base*0.05))+1)-T(1);
            
            if isempty(tRmax2_R1),tRmax2_R1=0;end
            if isempty(tRmax2_R2),tRmax2_R2=0;end
            if isempty(tRmax2_R12),tRmax2_R12=0;end

            if isempty(tRmax5_R1),tRmax5_R1=0;end
            if isempty(tRmax5_R2),tRmax5_R2=0;end
            if isempty(tRmax5_R12),tRmax5_R12=0;end
            
            timeRecovery2_R1_=[tRmin2_R1,tRmax2_R1];
            timeRecovery2_R2_=[tRmin2_R2,tRmax2_R2];
            timeRecovery2_R12_=[tRmin2_R12,tRmax2_R12];

            timeRecovery5_R1_=[tRmin5_R1,tRmax5_R1];
            timeRecovery5_R2_=[tRmin5_R2,tRmax5_R2];
            timeRecovery5_R12_=[tRmin5_R12,tRmax5_R12];
                       
            timeRecovery2_R1=[timeRecovery2_R1;timeRecovery2_R1_];
            timeRecovery2_R2=[timeRecovery2_R2;timeRecovery2_R2_];
            timeRecovery2_R12=[timeRecovery2_R12;timeRecovery2_R12_];
            
            timeRecovery5_R1=[timeRecovery5_R1;timeRecovery5_R1_];
            timeRecovery5_R2=[timeRecovery5_R2;timeRecovery5_R2_];
            timeRecovery5_R12=[timeRecovery5_R12;timeRecovery5_R12_];
            
        end
        
        % plot the results
        plotResilienceB(x1,x2,x12,r1,r2,r12,inunInterval,...
            timeRecovery2_X1,timeRecovery2_X2,timeRecovery2_X12,...
            timeRecovery5_X1,timeRecovery5_X2,timeRecovery5_X12,...
            timeRecovery2_R1,timeRecovery2_R2,timeRecovery2_R12,...
            timeRecovery5_R1,timeRecovery5_R2,timeRecovery5_R12)        

    case 'hysteresis'
        %-- fix operational parameters 
        D_base = 0.095; % base dilution rate
        tend_ss=200; % time to attain steady state  
        tend_oscil=200; % duration perturbed with periodic oscillation 
        tauLowShort=5; % short interval 
        tauLowLong=15; % long interval 
        
        para.D=D_base;
        
        %-- attain a steady state 
        tspan=[0,tend_ss];
        [T,Y]=ode15s(@odeModel,tspan,y0,options,para);
        y0_base=Y(end,:); % take the end value as base
        
        %-- start fluctuating D around the S-S values: short->long->short->long
        %--- short interval
        y0=y0_base; tauLow=tauLowShort; TT=[];YY=[];RR=[];t1=0;t2=tend_oscil;
        [TT,YY,RR]=fluctuateD(tauLow,para,tauHigh,D_base,D_alpha,y0,t1,t2,TT,YY,RR,options);
        nTT(1)=length(TT);
        %--- long interval
        y0=YY(end,:); tauLow=tauLowLong; t1=TT(end); t2=2*tend_oscil;
        [TT,YY,RR]=fluctuateD(tauLow,para,tauHigh,D_base,D_alpha,y0,t1,t2,TT,YY,RR,options); 
        nTT(2)=length(TT);
        %--- short interval
        y0=YY(end,:); tauLow=tauLowShort; t1=TT(end); t2=3*tend_oscil;
        [TT,YY,RR]=fluctuateD(tauLow,para,tauHigh,D_base,D_alpha,y0,t1,t2,TT,YY,RR,options); 
        nTT(3)=length(TT);
        %--- long interval
        y0=YY(end,:); tauLow=tauLowLong; t1=TT(end); t2=4*tend_oscil;
        [TT,YY,RR]=fluctuateD(tauLow,para,tauHigh,D_base,D_alpha,y0,t1,t2,TT,YY,RR,options); 
        nTT(4)=length(TT);

        %-- plot the results
        plotHysteresis(TT,YY,RR,nTT)
        
end

