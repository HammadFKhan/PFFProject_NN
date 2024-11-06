addpath(genpath('main'))
addpath(genpath('Pipelines'))
addpath(genpath('CaImAn-MATLAB'))
addpath(genpath('utilities'));
addpath(genpath('deconvolution'));
addpath(genpath('NoRMCorre')); %add the NoRMCorre motion correction package to MATLAB path
%%
figure,[Coor,json_file] = plot_contours(A,C,ops,0); title('Selected components','fontweight','bold','fontsize',14);

%% Analysis
set(0,'DefaultFigureWindowStyle','normal')
addpath(genpath('main'));
addpath(genpath('Pipelines'));
std_threshold = 3;
static_threshold = .01;
Spikes = rasterizeDFoF(DeltaFoverF,std_threshold,static_threshold);
figure,stack_plot(DeltaFoverF,1,3,1) % Show fluorescence for each cell
figure,Show_Spikes(Spikes) % Plot binary raster plot
%% Ensemble Analysis
factorCorrection = 5*floor(size(Spikes(:,1:end),2)/5); % Correct for frame size aquisition
Ensemble = ensembleAnalysis2(Spikes(:,1:factorCorrection),ROIcentroid);
% Ensemble stats
Ensemble = ensembleMetric(Ensemble,AverageImage,ROIcentroid);
Ensemble = ensembleStat(Ensemble);
