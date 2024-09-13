load('C:\Users\khan332\Documents\GitHub\SiteSpecificLewyPathologyCircuits\SIFigure2code\SI2BehaviourData')
%%
f = figure;
f.Position = [681 559 960 420];
subplot(121),customBoxplot(CTXBoutsTreatmentGroup)
set(gca,'tickdir','out','fontsize',16),box off,ylabel('Running Bouts (s)'),ylim([0 40])
subplot(122),customBoxplot(STRBoutsTreatmentGroup)
set(gca,'tickdir','out','fontsize',16),box off,ylabel('Running Bouts (s)'),ylim([0 40])


getStats(CTXBoutsTreatmentGroup)
getStats(STRBoutsTreatmentGroup)

%%
f = figure;
f.Position = [681 559 960 420];
subplot(121),customBoxplot(CTXVelocityTreatmentGroup)
set(gca,'tickdir','out','fontsize',16),box off,ylabel('Running Bouts (s)'),ylim([0 10])
subplot(122),customBoxplot(STRVelocityTreatmentGroup)
set(gca,'tickdir','out','fontsize',16),box off,ylabel('Running Bouts (s)'),ylim([0 10])
getStats(CTXVelocityTreatmentGroup)
getStats(STRVelocityTreatmentGroup)
%%
f = figure;
f.Position = [681 559 960 420];
subplot(121),customBoxplot(CTXMaxSpeedTreatmentGroup)
set(gca,'tickdir','out','fontsize',16),box off,ylabel('Running Bouts (s)'),ylim([0 40])
subplot(122),customBoxplot(STRMaxSpeedTreatmentGroup)
set(gca,'tickdir','out','fontsize',16),box off,ylabel('Running Bouts (s)'),ylim([0 40])
getStats(CTXMaxSpeedTreatmentGroup)
getStats(STRMaxSpeedTreatmentGroup)
%% LOCAL FUNCTIONS
function getStats(data)
% ANOVA N analysis on paired groups. ie we are considering changes across
% monomer and PFF as a function of weeks
for n = 1:size(data,2)
    temp = data(:,n);
    temp(isnan(temp)) = [];
    dataLen(n) = length(temp);
end
dat = data(:);
dat(isnan(dat)) = [];
group = repmat(1,dataLen(1)+dataLen(2),1); % Monomer Condition
group = [group;repmat(2,dataLen(3)+dataLen(4),1)]; % PFF condition
week = repmat(1,dataLen(1),1); % Week 2 
week = [week;repmat(2,dataLen(2),1)]; % Week 12 
week = [week;repmat(1,dataLen(3),1)]; % Week 2 
week = [week;repmat(2,dataLen(4),1)]; % Week 12 
anovan(dat,{week group},'model','interaction','varnames',{'week','group'})
end
