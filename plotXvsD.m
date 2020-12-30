function plotXvsD(DD,YYend,RR)

figure

subplot(2,1,1)
plot(DD,YYend(:,[1,2]),'LineWidth',2)
hold on
plot(DD,YYend(:,3),'--','LineWidth',2)
hold off
ax=gca;
ax.FontSize=16;
ax.LineWidth=2;
ylabel('Variable')
xlabel('\delta')
ylim([0 1])
drawnow

subplot(2,1,2)
plot(DD,RR(:,1:2),'LineWidth',2)
hold on
plot(DD,RR(:,3),'--','LineWidth',2)
hold off
ax=gca;
ax.FontSize=16;
ax.LineWidth=2;
xlabel('\delta')
ylabel('Rate')
ylim([0 0.12])
drawnow