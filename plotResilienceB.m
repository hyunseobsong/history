function plotResilienceB(x1,x2,x12,r1,r2,r12,inunInterval,...
        timeRecovery2_X1,timeRecovery2_X2,timeRecovery2_X12,...
        timeRecovery5_X1,timeRecovery5_X2,timeRecovery5_X12,...
        timeRecovery2_R1,timeRecovery2_R2,timeRecovery2_R12,...
        timeRecovery5_R1,timeRecovery5_R2,timeRecovery5_R12)        
    
% population curves vs. inundation interval 
figure 
errorbar(inunInterval,x1(:,1),x1(:,2),'LineWidth',2)
hold on
errorbar(inunInterval,x2(:,1),x2(:,2),'LineWidth',2)
hold on
errorbar(inunInterval,x12(:,1),x12(:,2),'LineWidth',2)
hold off
ax=gca;
ax.FontSize=14;
ax.LineWidth=2;
set(gca,'XTickLabel',[])
ylabel('Variable')
xlabel('\Delta\tau')
axis square

% hitting time and settling time (2%)
figure 
plot(inunInterval,timeRecovery2_X1(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery2_X2(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery2_X12(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery2_X1(:,2),'ko')
hold on
plot(inunInterval,timeRecovery2_X2(:,2),'ko')
hold on
plot(inunInterval,timeRecovery2_X12(:,2),'ko')
hold off
xlabel('\Delta\tau')
ylabel('Time-to-compositional recovery (2%)')
ax=gca;
ax.FontSize=14;
ax.LineWidth=2;
axis square

% hitting time and settling time (5%)
figure 
plot(inunInterval,timeRecovery5_X1(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery5_X2(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery5_X12(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery5_X1(:,2),'ko')
hold on
plot(inunInterval,timeRecovery5_X2(:,2),'ko')
hold on
plot(inunInterval,timeRecovery5_X12(:,2),'ko')
hold off
xlabel('\Delta\tau')
ylabel('Time-to-compositional recovery (5%)')
ax=gca;
ax.FontSize=14;
ax.LineWidth=2;
axis square


% rate curves vs. inundation interval 
figure 
errorbar(inunInterval,r1(:,1),r1(:,2),'LineWidth',2)
hold on
errorbar(inunInterval,r2(:,1),r2(:,2),'LineWidth',2)
hold on
errorbar(inunInterval,r12(:,1),r12(:,2),'LineWidth',2)
hold off
ax=gca;
ax.FontSize=14;
ax.LineWidth=2;
set(gca,'XTickLabel',[])
ylabel('Rate')
xlabel('\Delta\tau')
axis square

% hitting time and settling time (2%)
figure 
plot(inunInterval,timeRecovery2_R1(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery2_R2(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery2_R12(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery2_R1(:,2),'ko')
hold on
plot(inunInterval,timeRecovery2_R2(:,2),'ko')
hold on
plot(inunInterval,timeRecovery2_R12(:,2),'ko')
hold off
xlabel('\Delta\tau')
ylabel('Time-to-functional recovery (2%)')
ax=gca;
ax.FontSize=14;
ax.LineWidth=2;
axis square

% hitting time and settling time (5%)
figure 
plot(inunInterval,timeRecovery5_R1(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery5_R2(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery5_R12(:,1),'LineWidth',2)
hold on
plot(inunInterval,timeRecovery5_R1(:,2),'ko')
hold on
plot(inunInterval,timeRecovery5_R2(:,2),'ko')
hold on
plot(inunInterval,timeRecovery5_R12(:,2),'ko')
hold off
xlabel('\Delta\tau')
ylabel('Time-to-functional recovery (5%)')
ax=gca;
ax.FontSize=14;
ax.LineWidth=2;
axis square
