clc
clear all
close all

% read in the data
fileName = 'DIC_InstrongStrainError.csv';
inFID = fopen([pwd,'/',fileName],'r');
D = textscan(inFID,'%s %f %f','delimiter','\t','headerlines',1,'treatAsEmpty','na');
specimen = D{:,1};
average = D{:,2};
stdev = D{:,3};

% classify specimens as "valid" or "invalid" based on an uncertainty of
% <500 microstrain with 1 standard deviation
valid = false(length(specimen),1);
valid( ~isnan(average)  ) = 1;

% plot all the data
f1H = figure(1);
set(f1H,'position',[1684 43 1674 929])
a1H = axes;
hold on;
j = 1;
for i=1:length(valid)
    if valid(i) == 0;
        continue
    end
    plot(a1H,[j j],[average(i)-stdev(i) average(i)+stdev(i)],'linewidth',5)
    j = j+1;
end
plot(a1H,1:length(find(valid==1)),average(valid),'s','markersize',15,'markeredgecolor','r','markerfacecolor','r')
grid
xlim([0 21])
% set the tick locations, and increase the spacing from the bottom of the
% figure for labels
set(a1H,'xtick',1:20,'xtickLabel',[],'fontname','times','fontsize',30,'position',[.13 .2 .75 .75])
ylabel('Error (\mu\epsilon)','fontsize',35)

% position the labels and then rotate the text so that it fits.
labelPosition = get(get(gca,'xlabel'),'position');
j = 1;
for i = 1:length(specimen)
    if valid(i) == 0
        continue;
    end
    t(j) = text(j,labelPosition(2),specimen{i});
    j = j+1;
end
set(t,'Rotation',70,'HorizontalAlignment','right','fontsize',35,'fontname','times')
hLengend = legend('$\mu$','$\pm\sigma$');
set(hLengend,'interpreter','latex')

% figure out the legend for all these plots
childern = get(hLengend,'children');
XdotLocation = get(childern(end-1),'Xdata');
YdotLocation = get(childern(end-1),'Ydata');
set(childern(end-1),'Xdata',mean(XdotLocation),'Ydata',YdotLocation(1),'linestyle','none','color','r','marker','s','markersize',15,'markeredgeColor','r','markerfaceColor','r')
