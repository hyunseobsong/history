function plotResilienceA(TT,YY,RR,tend_oscil,tauLow,tauHigh)
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


if tend_oscil<1000
    figure('Name',['\tau_{up}=',num2str(tauHigh),', \tau_{down}=',num2str(tauLow),', Interval=',num2str(tauHigh+tauLow)])
    subplot(2,1,1)
    plot(TT,YY(:,1:3),'LineWidth',1.5)
    ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
    ylabel('Variable')
    xlabel('\tau')
    drawnow

    subplot(2,1,2)
    plot(TT,RR(:,1:3),'LineWidth',1.5)
    ax=gca;ax.FontSize=14;ax.LineWidth=1.5;
    ylabel('Rate')
    xlabel('\tau')
    drawnow
end
