function [X,Y] = readDaVisFile(fileName)
% [X,Y] = readDaVisFile(fileName)
% Input a file name and the X and Y axes will be returned. Only works with
% one data set (that is, one x and one y)

inFid = fopen(fileName,'r');

cline = fgetl(inFid);   % skip headerline

cline = fgetl(inFid);   % read in the y axis
Y = str2num(cline);     % convert to number and return

cline = fgetl(inFid);   % read in the x axis
X = str2num(cline);     % convert to number and return