function varargout = saveOpenFigs(varargin)
% save_open_figs Saves open figure windows as an image or .fig files in separate sub-directory
%
%   save_open_figs(figList)
%   save_open_figs(figList, figType);
%   save_open_figs(figList, figType, figNames)
%   save_open_figs(figList, figType, figNames, figDir)
%
%  INPUT:  figList = handles of currently open figure windows
%          figType = type of file format to save figures as
%         figNames = corresponding file names for values in figList
%           figDir = directory to save files in (current path = pwd;
%
%   varargout = {figList,...}
%   varargout = {figList, figType, figNames, figDir};
%
%  USAGE:      
%  >> figList = findall(groot, 'Type', 'figure');
%  >> figType = {'jpg'} or {'jpg', 'compact'};
%  >> figNames = {'fig1', 'fig2', ..., 'figN'};
%  >> figDir = pwd;
%  >> save_open_figs(figList, figType, figNames, figDir);
%
%  AUTHOR: Miles V. Barnhart
%     VER: 1.0
%    DATE: Nov. 23 2019
%  STATUS: Development
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
narginchk(1,4); 
numvarargs = length(varargin);
figList = varargin{1};
disp('Saving figures...');
figNames = cell(1,length(figList));
for n = 1:length(figList) % generate default names
    figNames{n} = strcat('fig',num2str(n),'_', num2str(randi(999999)));
end

optargs = {varargin{1}, 'jpg', figNames,  pwd};
optargs(1:numvarargs) = varargin;
[figList, figType, figNames, figDir] = optargs{:};

for iFig = 1:length(figList)
    switch char(figType)
        case 'jpg'
            saveas(figList(iFig), strcat(figDir, '/', figNames{iFig}), figType); % save as *.jpg file   
        case 'fig'
            savefig(figList(iFig), strcat(figDir, '/', figNames{iFig}), 'compact'); % save *.fig compressed 
    end
    fprintf('`%s` saved... (%g%%)\n', figNames{iFig}, 100*(iFig/length(figList)));
end
varargout = {figList, figType, figNames, figDir};