%% 
clc
clear all
close all

%% load the files for force from DT and instron

[dtFile,dtPath] = uigetfile('/media/Test_Data/DT*_filtfilt.mat','Please select a DT file');
if exist([dtPath,'Ins',dtFile(3:end)],'file')
    insFile = ['Ins',dtFile(3:end)];
    insPath = dtPath;
else
    [insFile,insPath] = uigetfile('/media/Test_Data/Ins*_filtfilt.mat','Please select an Instron file');
end

load([dtPath,dtFile]);
dtTime = time;
dtTrigger = trigger;
load([insPath,insFile]);
insTime = time;
insTrigger = trigger;

prompt = {'Enter DT Frame Rate';'Enter Instron Frame Rate'};
dlg_title = 'Acquisition Rate';
default = {'10000','100'};
frameRates = inputdlg(prompt,dlg_title,1,default);
dtRate = str2num(frameRates{1});
insRate = str2num(frameRates{2});


%% Find the max force in the instron, and then the corresponding force in DT
[insMaxF,insMaxFI] = max(-force); % max compressive force in Instron

dtInsFI = find(sixAxis(:,3) > insMaxF,1,'first'); % corresponding DT force index
insTriggerI = find(insTrigger < 4,1,'first');
insTimePostTrigger = insTime(insMaxFI) - insTime(insTriggerI);
insFrameNumber = floor(insTimePostTrigger/(1/insRate));

dtTriggerI = find(dtTrigger < 4,1,'first');
dtTimePostTrigger = dtTime(dtInsFI) - dtTime(dtTriggerI);
dtFrameNumber = floor(dtTimePostTrigger/(1/dtRate*1000)); % dt time is in ms

%% write a little data file to make getting the frames easier.
% outFile = [dtPath,'../StrainComparison.txt'];
% outFID = fopen(outFile,'w+');
% fprintf(outFID,'      \tDrop Tower\tInstron\n');
% fprintf(outFID,'Frame \t%10.0f\t%7.0f\n',dtFrameNumber,insFrameNumber);
% fprintf(outFID,'Time  \t%7.3f ms\t%5.3f s\n',dtTimePostTrigger,insTimePostTrigger);
% fprintf(outFID,'Force \t%8.0f N\t%5.0f N\n',sixAxis(dtInsFI,3),insMaxF);
% fclose(outFID);
% fprintf(outFID,'DT time post trigger = %3.3f ms\n DT frame = %4.0f\n',dtTimePostTrigger,dtFrameNumber);
% fprintf(outFID,'Ins time post trigger = %3.3f s\n Ins frame = %4.0f\n',insTimePostTrigger,insFrameNumber);
% fclose(outFID);



