function [X,Y] = readDaVisFile(fileName)
inFid = fopen(fileName,'r');

cline = fgetl(inFid);   % skip headerline

cline = fgetl(inFid);   % read in the y axis
Y = str2num(cline);     % convert to number and return

cline = fgetl(inFid);   % read in the x axis
X = str2num(cline);     % convert to number and return