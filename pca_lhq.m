% PCA on Language History Variables
clear all; close all; clc


%% Read the data

opts = detectImportOptions('all_variables_k.csv');
opts = setvartype(opts,{},'double');

data = readtable('all_variables_k.csv', opts, ...
    'ReadVariableNames', true);

subject = table2cell(data(:, 2));
subjnum = table2array(data(:, 3));
group = table2cell(data(:, 1));

% chose: include age, sex, education?
includeASE = 0;     % yes = 1

if includeASE == 1
    ci = 4;         % column in table to start reading variables
    lab = 'ASE';    % a label for plots and tables
else
    ci = 7;
    lab = 'LHq';
end

datavar = table2array(data(:, ci:end)); 


%% plot the data

figure()
boxplot(datavar,'orientation','horizontal','labels',data.Properties.VariableNames(ci:end))

%% perform PCA
numcom = 3;
[coeff,score,latent,tsquared,explained,mu] = pca(datavar, 'NumComponents',numcom);

% print to file
tscore = table(subject, score, tsquared);
tpca = table(data.Properties.VariableNames(ci:end).', coeff, explained); 
writetable(tscore, ['subject_scores_tsquared_' lab '.csv'])
writetable(tpca, ['coefficients_variance_' lab '.csv'])

% plot variance explained by current components
figvar = figure;
plot(1:length(explained),cumsum(explained), 'LineWidth', 4, 'Color', 'k')
ylim([30 104])
xlim([0 length(explained)+1])
xlabel('principal components')
ylabel('variance')
hold on
for c = 1:length(explained)
    if c == numcom
        plot([c c], ylim,'color', 'b', 'LineStyle', '-')
    else
        plot([c c], ylim,'color', 'b', 'LineStyle', ':')
    end
    hold on
end
title(['Variance explained by principal components (' lab ')'])

% or a pareto plot 
figpar = figure;
pareto(explained)
xlabel('principal components')
ylabel('variance')
title(['Variance explained by principal components (' lab ')'])