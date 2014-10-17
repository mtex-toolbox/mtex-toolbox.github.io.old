function makeDoc(varargin)
% build help with the DocHelp Toolbox
%

if check_option(varargin,'clear')
  !find doc/UsersGuide -exec touch {} \;
  mtexdata clear
end

clear
close all
setMTEXpref('FontSize',12)
setMTEXpref('figSize','normal')


%%

plotx2east


setMTEXpref('generatingHelpMode',true);
set(0,'FormatSpacing','compact')

set(0,'DefaultFigureColor','white');

addpath(fullfile(pwd,'..','..','mtex-doc'))
addpath(fullfile(pwd,'..','..','mtex-doc','tools'))

%% DocFiles
%

mtexFunctionFiles = [...
  DocFile( fullfile(mtex_path,'EBSDAnalysis')) ...
  DocFile( fullfile(mtex_path,'ODFAnalysis')) ...
  DocFile( fullfile(mtex_path,'PoleFigureAnalysis')) ...
  DocFile( fullfile(mtex_path,'plotting')) ...
  DocFile( fullfile(mtex_path,'geometry')) ...
  DocFile( fullfile(mtex_path,'tools')) ];

%mtexFunctionFiles = exclude(mtexFunctionFiles,'Patala');

mtexExampleFiles = ...
  DocFile( getFiles(fullfile(mtex_path,'examples'),'*.m',false));
mtexDocFiles = ...
  DocFile( fullfile(mtex_path,'help','doc'));

mtexHelpFiles = [mtexFunctionFiles mtexExampleFiles mtexDocFiles];

mtexDocPictures = DocFile(getFiles(fullfile(mtex_path,'help','doc'),'*.png',true));

mtexGeneralFiles = [DocFile(fullfile(mtex_path,'COPYING.txt')) ...
  DocFile(fullfile(mtex_path,'README.txt')) ...
  DocFile(fullfile(mtex_path,'VERSION'))];


%%



options.outputDir = fullfile(pwd,'..','files','doc');
options.tempDir = fullfile(pwd,'tmp');
options.publishSettings.stylesheet = fullfile(pwd,'web.xsl');

%%

makeToolboxXML('name','MTEX',...
  'fullname','<b>MTEX</b> - A MATLAB Toolbox for Quantitative Texture Analysis',...
  'versionname',getMTEXpref('version'),...
  'procuctpage','mtex_product_page.html')

%%

copyfile(fullfile(options.outputDir,'../../css/up.css'),options.outputDir);
copy(mtexDocPictures,options.outputDir)
copy(mtexGeneralFiles,options.outputDir)

%% Copy productpage

productpage = DocFile(fullfile(mtex_path,'help','general','mtex_product_page.html'));
copy(productpage,fullfile(options.outputDir,'index.html'))

%% make function reference overview pages

makeFunctionsReference(mtexHelpFiles,'FunctionReference','outputDir',options.outputDir);

%% make help toc

makeHelpToc(mtexHelpFiles,'Documentation','FunctionMainFile','FunctionReference','outputDir',options.outputDir);
%copyfile(fullfile(outputDir,'helptoc.xml'), docPath);

%% Publish Function Reference

options.evalCode = true;
options.force = false;
publish(mtexFunctionFiles,options);

%% Publish Examples Reference

publish(mtexExampleFiles,options);


%%

makeDemoToc(mtexExampleFiles,'outputDir',options.outputDir);
copyfile(fullfile(options.outputDir,'demos.xml'), fullfile(mtex_path,'examples'));


%%

src = struct(mtexExampleFiles);
src = [src.sourceInfo];

for k=1:numel(src)
  temp = DocFile(getFiles(options.outputDir,[src(k).docName '*']));
  copy(temp,fullfile(mtex_path,'examples','html'));
end
copy(DocFile(getPublishGeneral),fullfile(mtex_path,'examples','html'));


%% Publish Doc

options.evalCode = true;
options.force = false;
publish(mtexDocFiles,options);
%copy(mtexDocFiles,fullfile(mtex_path,'examples','UsersGuide'));

%%

%view(mtexHelpFiles,options)


%%

%view(mtexExampleFiles,outputDir);

%%

deadlink(mtexDocFiles,options.outputDir);

%% Enable search in documentation
% (also F1 Help in recent matlab)

%builddocsearchdb(outputDir);
%copyfile(fullfile(outputDir,'helpsearch'),fullfile(docPath,'helpsearch'));


%% Build the help.jar

%system(['jar -cf ' fullfile(docPath,'help.jar') ' -C ' outputDir ' .']);

%% set back mtex options

setMTEXpref('generatingHelpMode',false);

end
