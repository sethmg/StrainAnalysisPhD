clc
clear all
close all

[inFile,inPath] = uigetfile('/home/seth/Desktop/Ins*.mat','Please select the instron data file');

load([inPath inFile]);

plotPosition = get(0,'screensize');
trigTimeIndex = find(trigger<4.9,1,'first') - 1;
endIndex = find(time>time(trigTimeIndex)+11,1,'first');

time_DIC = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8 8.1 8.2 8.3 8.4 8.5 8.6 8.7 8.8 8.9 9 9.1 9.2 9.3 9.4 9.5 9.6 9.7 9.8 9.9 10 10.1];
pStrain2_DIC = [-1.1509e-006 0.00010163 -0.0073709 -0.023809 0.024149 -0.0039051 -0.0062622 -0.013604 -0.0029567 0.0022266 -0.0021553 -0.00070006 -0.010168 -0.0025966 -0.012648 0.0021781 -0.0071959 0.0016802 -0.0010387 -0.0024822 0.0041059 -0.012276 -0.019301 -0.017009 -0.017503 -0.016216 -0.0062795 0.0031398 -0.011719 -0.022978 -0.0061386 0.00287 0.0041567 -0.01538 -0.020902 -0.025873 -0.01931 -0.031936 -0.014073 -0.020541 -0.010181 -0.033337 -0.021042 -0.020436 -0.029507 -0.015211 -0.015393 0.0019753 -0.019589 -0.021481 -0.023367 -0.0057883 -0.0096814 -0.011917 -0.0022928 -0.0094191 -0.0017386 0.00078304 -0.014698 -0.0076687 -0.012935 -0.0099956 -0.0069838 -0.0021074 -0.0048369 -0.036772 -0.016946 -0.038844 -0.067866 -0.053815 -0.073039 -0.082751 -0.095826 -0.095101 -0.093518 -0.13104 -0.13429 -0.1188 -0.17458 -0.16527 -0.1726 -0.17767 -0.18107 -0.16428 -0.17695 -0.16049 -0.16211 -0.17248 -0.16344 -0.17756 -0.1591 -0.17383 -0.16638 -0.16808 -0.16608 -0.16939 -0.17683 -0.1674 -0.16864 -0.16925 -0.16103 0];

% interpolate both to the dic time
pStrain_gauge_interp = interp1(time(trigTimeIndex:endIndex)-time(trigTimeIndex),pStrain2(trigTimeIndex:endIndex)*100,time_DIC);


f1H = figure(1);
a1H = axes;
plot(time_DIC,pStrain_gauge_interp,time_DIC,pStrain2_DIC,'linewidth',2)
% plot(a1H,time(trigTimeIndex:endIndex)-time(trigTimeIndex),pStrain2(trigTimeIndex:endIndex)*100,time_DIC,pStrain2_DIC,'linewidth',2) % time in s, strain in percent
ylimits = ylim;
axis('tight');
ylim( ylimits );
grid
legend('Strain Gauge','DIC')

% Make the plot look good
set(f1H,'position',plotPosition,'paperpositionmode','auto');
set(a1H,'fontname','times','fontsize',20)
xlabel('Time (s)','fontname','times','fontsize',24)
ylabel('Minimum Principal Strain','fontname','times','fontsize',24)
