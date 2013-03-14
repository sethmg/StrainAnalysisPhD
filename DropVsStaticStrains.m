clc
clear all
close all

% open the DT DaVis file
[dtFile,dtPath] = uigetfile('/media/BigToaster/Seth Project Data/12-018 Testing!/*.txt','Please select a Drop Tower strain file');
[dtTime,dtStrain] = readDaVisFile([dtPath dtFile]);

% open the Instron DaVis file
[inFile,inPath] = uigetfile('/media/BigToaster/Seth Project Data/12-018 Testing!/*.txt','Please select an Instron strain file');
[inTime,inStrain] = readDaVisFile([inPath inFile]);

% plot both of them
plotPosition = [ 23          73        1635         848 ];

f1H = figure('position',plotPosition);
a1H = subplot(2,1,1);
plot(a1H,dtTime,dtStrain);
grid on
title('Drop Tower')

a2H = subplot(2,1,2);
plot(a2H,inTime,inStrain)
grid on
title('Instron')

% make an input dialog to get the times for the strain comparison
prompt = {'Drop tower time (ms):','Instron time (s):'};
strainTimes = inputdlg(prompt,'Times for strain comparison');
sTimes = [str2double(strainTimes{1})/1000 str2double(strainTimes{2})];

inIndex = find(inTime > sTimes(2),1,'first');
inRange = inIndex-3:inIndex+3;
InstronStrain = median( inStrain( inRange ) )
dtIndex = find(dtTime > sTimes(1),1,'first');
dtRange = dtIndex-3:dtIndex+3;
DropTowerStrain = median(dtStrain(dtRange))


