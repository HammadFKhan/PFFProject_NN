%% Remove ROIs
if exist('badComponents','var') && ~exist('badComFlag','var')
    [DeltaFoverF,dDeltaFoverF,ROI,ROIcentroid,Noise_Power,A] = ...
        removeROI(DeltaFoverF,dDeltaFoverF,ROI,ROIcentroid,Noise_Power,A,unique(badComponents));
    badComFlag = 1;
end
%%
ROIcentroid = [];ROInew = [];
for i = 1:length(ROI)
    blah = vertcat(ROI{i}{:});
    polyin = polyshape(blah(:,1),blah(:,2));
    [x,y] = centroid(polyin);
    ROIcentroid(i,:) = [x y];
    for ii = 1:size(blah,1)
        ROInew{i,1}{ii,1} = blah(ii,:);
    end
end

%% Interdendritic activity (cross-population behavior)
addpath(genpath('main'));
std_threshold = 6;
static_threshold = .01;
Spikes = Spike_Detector_Single(dDeltaFoverF,std_threshold,static_threshold);
[coactive_cells,detected_spikes] = coactive_index(Spikes,floor(length(Spikes)*.05));

% Dendritic Population Coopertivity 
corr = correlation_dice(Spikes);
factorCorrection = 5*floor(size(Spikes,2)/5); % Correct for frame size aquisition
Ensemble = ensembleAnalysis(Spikes(:,1:factorCorrection),ROIcentroid);
corrEnsemble = correlation_dice(Ensemble.ensemble);
Connected_ROI = Connectivity_dice(corrEnsemble,0.15);
% Ensemble stats
Ensemble = ensembleMetric(Ensemble,AverageImage,ROIcentroid);
Ensemble = ensembleStat(Ensemble);
%% Plot
figure,imagesc(corr),colormap(jet),caxis([0 max(tril(corr,-1),[],'all')])
figure,Dendritic_Map(AverageImage,Connected_ROI,ROIcentroid,ROI,1,1),title('Pairwise Coopertivity')
figure,imagesc(corrEnsemble),colormap(jet),caxis([0 max(tril(corrEnsemble,-1),[],'all')]),colorbar
figure,Dendritic_Map(AverageImage,Connected_ROI,ROIcentroid,ROI,1,1)
