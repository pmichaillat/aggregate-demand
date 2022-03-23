clear all;
close all;
j=0;
wind=4;

%% Plot evidence of matching frictions

set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 29)
set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', 29)

% Figure II, Panel A

ISMm=xlsread('data.xlsx','unused capacity','C3:C97');
UR=xlsread('data.xlsx','unused capacity','E3:E97');
Ym=xlsread('data.xlsx','unused capacity','A3:A97');
Qm=xlsread('data.xlsx','unused capacity','B3:B97');
ISMm=1-ISMm./100;
UR=UR./100;
TIMEm=Ym+(Qm-1)./4;

ISMs=xlsread('data.xlsx','unused capacity','D43:D97');
Ys=xlsread('data.xlsx','unused capacity','A43:A97');
Qs=xlsread('data.xlsx','unused capacity','B43:B97');
TIMEs=Ys+(Qs-1)./4;
ISMs=1-ISMs./100;

j=j+1;
figure(j)
clf
plot(TIMEs,ISMs,'-b','LineWidth',5)
hold on
plot(TIMEm,ISMm,'-.k','LineWidth',5)
plot(TIMEm,UR,':','LineWidth',5,'Color',[0,0.5,0])
axis tight
ylim([0,0.35])
set(gca,'YTick',[0:0.1:0.3])
set(gca,'YTickLabel',[' 0%';'10%';'20%';'30%'])
grid on
set(gca,'XTick',[1990,2000,2010])
h_legend=legend('Idleness, non-manufacturing','Idleness, manufacturing','Unemployment');
set(h_legend,'Location','NorthWest');
print('-depsc','figure_II_A.eps','-loose')

% Figure II, Panel B

REC=xlsread('data.xlsx','occupations','H3:H18')./1000;
PUR=xlsread('data.xlsx','occupations','I3:I18')./1000;

j=j+1;
figure(j)
clf
plot(PUR,'-b','LineWidth',5)
hold on
plot(REC,':','LineWidth',5,'Color',[0,0.5,0])
axis tight
ylim([0,820])
set(gca,'YTick',[0:250:800])
grid on
ylabel('Thousands of workers')
set(gca,'XTick',[1,6,11,16])
set(gca,'XTickLabel',['1997';'2002';'2007';'2012'])
h_legend=legend('Purchasing','Recruiting');
set(h_legend,'Location','SouthEast');
print('-depsc','figure_II_B.eps','-loose')

% Figure II, Panel C

CUST=xlsread('data.xlsx','long-term relationships','B2:B12')./100;
EMP=xlsread('data.xlsx','long-term relationships','C2:C12')./100;
xt = [1:1:length(CUST)];
xtstr=['AT';'BE';'DE';'ES';'FR';'IT';'LU';'PT';'SE';'UK';'US'];

j=j+1;
figure(j)
clf
plot(CUST,'db','LineWidth',5,'MarkerSize',20)
hold on
plot(EMP,'*','LineWidth',5,'MarkerSize',20,'Color',[0,0.5,0])
axis tight
ylim([0,1])
set(gca,'YTick',[0:0.25:1])
set(gca,'YTickLabel',['  0%';' 25%';' 50%';' 75%';'100%'])
ylabel('Share of relationships')
grid on
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
h_legend=legend('Long-term customers','Long-term employees');
set(h_legend,'Location','SouthEast');
print('-depsc','figure_II_C.eps','-loose')


%% Plot cyclical components for 1973:Q4--2013:Q2 period

set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 20)
set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', 20)

Y=xlsread('cyclical_components.xlsx','1973--2013','A2:A160');
X=xlsread('cyclical_components.xlsx','1973--2013','C2:C160');
TH=xlsread('cyclical_components.xlsx','1973--2013','D2:D160');
GDP=xlsread('cyclical_components.xlsx','1973--2013','E2:E160');
L=xlsread('cyclical_components.xlsx','1973--2013','F2:F160');

xt = [2+4*6:40:length(Y)];
xtstr=num2str(Y(xt));
nperiods=size(Y,1);
xn=[1:nperiods];

% Figure VIII, Panel A

y1=X;

j=j+1;
figure(j)
clf
plot(y1,'b','LineWidth',3)
axis tight
ylim([-0.16,0.08])
set(gca,'YTick',[-0.16:0.04:0.08])
grid on
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
print('-depsc','figure_VIII_A.eps','-loose')

% Figure VIII, Panel B

y1=TH;

j=j+1;
figure(j)
clf
plot(y1,'b','LineWidth',3)
axis tight
ylim([-0.75,0.5])
set(gca,'YTick',[-0.75:0.25:0.5])
grid on
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
print('-depsc','figure_VIII_B.eps','-loose')

% Figure IX, Panel A

y1=TH;
y2=L;

j=j+1;
figure(j)
clf
[AX,H1,H2] = plotyy(xn,y1,xn,y2,'plot');
axes(AX(1))
xlim([1,nperiods])
ylim([-0.8,0.8])
set(gca,'YTick',[-0.8,-0.4,0,0.4,0.8])
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
grid on
axes(AX(2))
xlim([1,nperiods])
ylim([-0.04,0.04])
set(gca,'YTick',[-0.04,-0.02,0,0.02,0.04])
set(gca,'XTick',[])
set(H1,'LineWidth',3)
set(H2,'LineWidth',3,'LineStyle','--')
print('-depsc','figure_IX_A.eps','-loose')


% Figure IX, Panel B

j=j+1;
figure(j)
clf
crosscorr(y1,y2,wind)
xlabel('Lags (quarters)')
ylim([-0.2,1])
set(gca,'YTick',[-0.2:0.2:1])
set(gca,'XTick',[-4:1:4])
ylabel('')
title('')
h = findobj(gca,'Type','line');
set(h(1),'LineWidth',2)
set(h(2),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
set(h(3),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
h = findobj(gca,'Type','stem');
set(h,'LineWidth',2,'LineStyle','-','Color','b','MarkerSize',13,'MarkerEdgeColor','b','MarkerFaceColor','b')
print('-depsc','figure_IX_B.eps','-loose')

% Figure X, Panel A

y1=X;
y2=GDP;

j=j+1;
figure(j)
clf
[AX,H1,H2] = plotyy(xn,y1,xn,y2,'plot');
axes(AX(1))
xlim([1,nperiods])
ylim([-0.16,0.08])
set(gca,'YTick',[-0.16:0.08:0.08])
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
grid on
axes(AX(2))
xlim([1,nperiods])
ylim([-0.1,0.05])
set(gca,'YTick',[-0.1:0.05:0.05])
set(gca,'XTick',[])
set(H1,'LineWidth',3)
set(H2,'LineWidth',3,'LineStyle','--')
print('-depsc','figure_X_A.eps','-loose')


% Figure X, Panel B

j=j+1;
figure(j)
clf
crosscorr(y1,y2,wind)
xlabel('Lags (quarters)')
ylim([-0.2,1])
set(gca,'YTick',[-0.2:0.2:1])
set(gca,'XTick',[-4:1:4])
ylabel('')
title('')
h = findobj(gca,'Type','line');
set(h(1),'LineWidth',2)
set(h(2),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
set(h(3),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
h = findobj(gca,'Type','stem');
set(h,'LineWidth',2,'LineStyle','-','Color','b','MarkerSize',13,'MarkerEdgeColor','b','MarkerFaceColor','b')
print('-depsc','figure_X_B.eps','-loose')

%% Plot cyclical components for 1999:Q1--2013:Q2

Y=xlsread('cyclical_components.xlsx','1999--2013','A2:A56');
X=xlsread('cyclical_components.xlsx','1999--2013','C2:C56');
TH=xlsread('cyclical_components.xlsx','1999--2013','D2:D56');
GDP=xlsread('cyclical_components.xlsx','1999--2013','E2:E56');
L=xlsread('cyclical_components.xlsx','1999--2013','F2:F56');
ISM=xlsread('cyclical_components.xlsx','1999--2013','G2:G56');

xt = [2:16:length(Y)];
xtstr=num2str(Y(xt));
nperiods=size(Y,1);
xn=[1:nperiods];

% Figure A2

y1=ISM;
y2=X;

j=j+1;
figure(j)
clf
[AX,H1,H2] = plotyy(xn,y1,xn,y2,'plot');
axes(AX(1))
xlim([1,nperiods])
ylim([-0.08,0.04])
set(gca,'YTick',[-0.08:0.04:0.04])
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
grid on
axes(AX(2))
xlim([1,nperiods])
ylim([-0.16,0.08])
set(gca,'YTick',[-0.16:0.08:0.08])
set(gca,'XTick',[])
set(H1,'LineWidth',3)
set(H2,'LineWidth',3,'LineStyle','--')
print('-depsc','figure_A2.eps','-loose')

% Figure A3, Panel A

y1=X;
y2=GDP;

j=j+1;
figure(j)
clf
[AX,H1,H2] = plotyy(xn,y1,xn,y2,'plot');
axes(AX(1))
xlim([1,nperiods])
ylim([-0.16,0.08])
set(gca,'YTick',[-0.16:0.08:0.08])
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
grid on
axes(AX(2))
xlim([1,nperiods])
ylim([-0.08,0.04])
set(gca,'YTick',[-0.08:0.02:0.04])
set(gca,'XTick',[])
set(H1,'LineWidth',3)
set(H2,'LineWidth',3,'LineStyle','--')
print('-depsc','figure_A3_A.eps','-loose')

% Figure A3, Panel B

j=j+1;
figure(j)
clf
crosscorr(y1,y2,wind)
xlabel('Lags (quarters)')
ylim([-0.4,1])
set(gca,'YTick',[-0.4:0.2:1])
set(gca,'XTick',[-4:1:4])
ylabel('')
title('')
h = findobj(gca,'Type','line');
set(h(1),'LineWidth',2)
set(h(2),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
set(h(3),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
h = findobj(gca,'Type','stem');
set(h,'LineWidth',2,'LineStyle','-','Color','b','MarkerSize',13,'MarkerEdgeColor','b','MarkerFaceColor','b')
print('-depsc','figure_A3_B.eps','-loose')

% Figure A3, Panel C

y1=ISM;
y2=GDP;

j=j+1;
figure(j)
clf
[AX,H1,H2] = plotyy(xn,y1,xn,y2,'plot');
axes(AX(1))
xlim([1,nperiods])
ylim([-0.06,0.04])
set(gca,'YTick',[-0.06:0.02:0.04])
set(gca,'XTick',xt)
set(gca,'XTickLabel',xtstr)
grid on
axes(AX(2))
xlim([1,nperiods])
ylim([-0.06,0.04])
set(gca,'YTick',[-0.06:0.02:0.04])
set(gca,'XTick',[])
set(H1,'LineWidth',3)
set(H2,'LineWidth',3,'LineStyle','--')
print('-depsc','figure_A3_C.eps','-loose')

% Figure A3, Panel D

j=j+1;
figure(j)
clf
crosscorr(y1,y2,wind)
xlabel('Lags (quarters)')
ylim([-0.4,1])
set(gca,'YTick',[-0.4:0.2:1])
set(gca,'XTick',[-4:1:4])
ylabel('')
title('')
h = findobj(gca,'Type','line');
set(h(1),'LineWidth',2)
set(h(2),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
set(h(3),'LineWidth',2,'LineStyle','--','Color',[0,0.5,0])
h = findobj(gca,'Type','stem');
set(h,'LineWidth',2,'LineStyle','-','Color','b','MarkerSize',13,'MarkerEdgeColor','b','MarkerFaceColor','b')
print('-depsc','figure_A3_D.eps','-loose')