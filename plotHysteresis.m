function plotHysteresis(TT,YY,RR,nTT)

% fluctuations in time
figure
subplot(2,1,1)
plot(TT,YY(:,1:3),'linewidth',1.2)
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
xlabel('\tau')
ylabel('Variable')
subplot(2,1,2)
plot(TT,RR(:,1:3),'linewidth',1.2)
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
xlabel('\tau')
ylabel('Rate')

% 3-D limit cycle: x,y,z
figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot3(YY(t1:t2,1),YY(t1:t2,2),YY(t1:t2,3),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot3(YY(t1:t2,1),YY(t1:t2,2),YY(t1:t2,3),'b','linewidth',1)
    end
    hold on
end
plot3(YY(1,1),YY(1,2),YY(1,3),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
xlabel('x(t)')
ylabel('y(t)')
zlabel('z(t)')

% 3-D limit cycle: rx,ry,rz
figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot3(RR(t1:t2,1),RR(t1:t2,2),RR(t1:t2,3),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot3(RR(t1:t2,1),RR(t1:t2,2),RR(t1:t2,3),'b','linewidth',1)
    end
    hold on
end
plot3(RR(1,1),RR(1,2),RR(1,3),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
xlabel('r_x(t)')
ylabel('r_y(t)')
zlabel('r_z(t)')

% 2-D limit cycles
figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(YY(t1:t2,1),RR(t1:t2,1),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(YY(t1:t2,1),RR(t1:t2,1),'b','linewidth',1)
    end
    hold on
end
plot(YY(1,1),RR(1,1),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
ylabel('r_x(t)')
xlabel('x(t)')


figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(YY(t1:t2,2),RR(t1:t2,2),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(YY(t1:t2,2),RR(t1:t2,2),'b','linewidth',1)
    end
    hold on
end
plot(YY(1,2),RR(1,2),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
ylabel('r_y(t)')
xlabel('y(t)')

figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(YY(t1:t2,3),RR(t1:t2,3),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(YY(t1:t2,3),RR(t1:t2,3),'b','linewidth',1)
    end
    hold on
end
plot(YY(1,3),RR(1,3),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
ylabel('r_z(t)')
xlabel('z(t)')

% 2-D limit cycles
figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(YY(t1:t2,1),YY(t1:t2,2),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(YY(t1:t2,1),YY(t1:t2,2),'b','linewidth',1)
    end
    hold on
end
plot(YY(1,1),YY(1,2),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
xlim([0.31 0.37])
ylabel('y(t)')
xlabel('x(t)')

figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(YY(t1:t2,2),YY(t1:t2,3),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(YY(t1:t2,2),YY(t1:t2,3),'b','linewidth',1)
    end
    hold on
end
plot(YY(1,2),YY(1,3),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
ylabel('z(t)')
xlabel('y(t)')


figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(YY(t1:t2,3),YY(t1:t2,1),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(YY(t1:t2,3),YY(t1:t2,1),'b','linewidth',1)
    end
    hold on
end
plot(YY(1,3),YY(1,1),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
ylabel('x(t)')
xlabel('z(t)')


figure
for iTT=1:length(nTT)
    if iTT==1
        t1=1;
        t2=nTT(iTT);
    else
        t1=nTT(iTT-1)+1;
        t2=nTT(iTT);
    end
    
    switch iTT
        case {1,3}
            plot(RR(t1:t2,1),RR(t1:t2,2),'k','linewidth',1,'Color',[0 0 0]+0.6)
        case {2,4}
        plot(RR(t1:t2,1),RR(t1:t2,2),'b','linewidth',1)
    end
    hold on
end
plot(RR(1,1),RR(1,2),'ro','linewidth',1)
hold off
ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
axis square
ylabel('r_y(t)')
xlabel('r_x(t)')
