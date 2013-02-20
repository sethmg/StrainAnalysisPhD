clc
clear all

rootDir = uigetdir('/media/BigToaster/Seth Project Data/12-018 Testing!','Please selecte the root directroy');
rootList = dir(rootDir);

for i = 1:length(rootList)
    if ~rootList(i).isdir || ~exist([rootDir,'/',rootList(i).name,'/InsDIC/'],'dir')
        continue
    end
    if exist([rootDir,'/',rootList(i).name,'/InsDIC/gauge_dic_diff_vs_time.fig'],'file')
        inFile = [rootDir,'/',rootList(i).name,'/InsDIC/gauge_dic_diff_vs_time.fig'];
    else
        [file,path] = uigetfile([rootDir,'/',rootList(i).name,'/InsDIC/'],'Please select the fig file');
        if isequal(file,0)
            continue
        end
        inFile = [path file];
    end
    openfig(inFile,'new','invisible')
    kids = get(gcf,'children');
    kids2 = get(kids(2),'children');
    j = 1;
    while(~strcmp(get(kids2(j),'DisplayName'),'Strain Error'))
        j = j+1;
    end
    
    strainError = get(kids2(j),'Ydata');
    specimenName = rootList(i).name;
    
    outFileID = fopen([rootList(i).name,'.txt'],'w');
    fprintf(outFileID,'StrainError(%%)\n');
    for j = 1:length(strainError)
        fprintf(outFileID,'%f\n',strainError(j));
    end
    
end
        