clc
clear all
close all
% This data is from strain measurement over the strain gauge on H1366R_Ins
% using the custom settings from Oct 23.  The values are in % strain.
[DVFile,DVPath] = uigetfile('/media/Test_Data/H1375L/*.txt','Please select a DaVis strain file');
[time_DIC,pStrain2_DIC] = readDaVisFile([DVPath,DVFile]);
sTime = inputdlg('Please enter the time of the first image in ms.');
sTime = str2num(sTime{1})/1000;

[GFile,GPath] = uigetfile('/media/Test_Data/H1375L/Ins*.mat','Please select a processed test file');
load([GPath,GFile]);
% adjust the DaVis time to match the processed time
triggerIndex = find(trigger < 4.95,1,'first');
time = time-time(triggerIndex);
time_DIC = time_DIC + sTime - time_DIC(1);% + time(triggerIndex);
filtSpacing = 11;
DVstrainMedFilt = medfilt1(pStrain2_DIC,filtSpacing);
% interpolate the two signals to the same spacing
startIndex = find(time > sTime,1,'first'); % if the DIC started after the loading, it will be off by the strain at the start of the images
Gstrain_interp = interp1(time,pStrain2-pStrain2(startIndex),time_DIC);

fclose all;

% pStrain_error = abs(Gstrain_interp.*100-pStrain2_DIC);
pStrain_error = Gstrain_interp.*100-pStrain2_DIC;
error_average = mean(pStrain_error);
error_stdev = std(pStrain_error);

sprintf('The average error is %0.3f %%, with a standard deviation of %0.3f %%.',error_average,error_stdev)

%% visualize
% plot the gauge, the DIC and the difference
plot(time_DIC,pStrain_error,'b',time_DIC,-pStrain2_DIC,'k')
hold
plot(time_DIC,-Gstrain_interp.*100,'g','linewidth',2)
set(gcf,'position',[53 62 1569 900]) % specific to seth's computer
set(gca,'fontsize',40)
grid
xlabel('Time, s','fontsize',45)
ylabel('Compressive Strain (Noise), %','fontsize',45)
legend('Strain Error','DIC Strain','Gauge Compressive Strain','location','northwest')

% plot the histogram of the error
figure
hist(pStrain_error*10000,30);
set(gcf,'position',[53 62 1569 900]) % specific to seth's computer
set(gca,'fontsize',40)
xlabel('Error (\mu\epsilon)','fontsize',45);
ylabel('Counts','fontsize',45);
% title('Histogram of strain error','fontsize',26)
grid
limits = axis;
xposi = limits(1)+(limits(2)-limits(1))/2;
infoH = text(xposi,limits(4),sprintf('Mean = %4.0f\nStdev = %4.0f',error_average*10000,error_stdev*10000));
set(infoH,'horizontalalignment','center','verticalalignment','top','fontsize',40)

%% bland-altman plot
indexesNoOut = find(abs(pStrain_error) < 0.05);
pStrain_error_noOut = Gstrain_interp(indexesNoOut).*100-pStrain2_DIC(indexesNoOut);
error_average_noOut = mean(pStrain_error_noOut);
error_stdev_noOut = std(pStrain_error_noOut);

f3H = figure(3);
a3H = axes;
set(f3H,'position',[53 62 1569 900])
plot(a3H,-Gstrain_interp(indexesNoOut)*1000000,pStrain_error_noOut*10000,'o','markersize',10,'markerfacecolor','b')
grid
hold
plot(a3H,xlim,[error_average_noOut error_average_noOut]*10000,'color',[0 0 0],'linewidth',2)
plot(a3H,xlim,([error_average_noOut error_average_noOut]+error_stdev_noOut)*10000,'color',[.7 .7 .7],'linewidth',2)
plot(a3H,xlim,([error_average_noOut error_average_noOut]-error_stdev_noOut)*10000,'color',[.7 .7 .7],'linewidth',2)
set(a3H,'fontsize',35,'fontname','times')
xlabel('Compressive Principal Strain (\mu\epsilon)')%,'fontsize',45,'fontname','times')
ylabel('Strain Error (\mu\epsilon)','fontsize',45,'fontname','times')
xlim([0 3500])
set(a3H,'ytick',[-500 -250 0 250 500])
