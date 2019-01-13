% Clustering participants on the basis of the Language History Variables
clear all; close all; clc


%% Read the data

opts = detectImportOptions('all_variables_k.csv');
opts = setvartype(opts,{},'double');

data = readtable('all_variables_k.csv', opts, ...
    'ReadVariableNames', true);

subject = table2cell(data(:, 2));
subjnum = table2array(data(:, 3));
group = table2cell(data(:, 1));

% chose: include Age, Sex, Education?
includeASE = 0; % yes = 1

if includeASE == 1
    ci = 4;
    lab = 'ASE';
else
    ci = 7;
    lab = 'LHq';
end
datavar = table2array(data(:, ci:end)); 


%% Kmeans

% evaluate clusters with 2 different methods: find out optimal number of
% clusters
eva1 = evalclusters(datavar,'kmeans','CalinskiHarabasz','KList',[1:10])
eva2 = evalclusters(datavar,'kmeans','silhouette','KList',[1:10])

% define clusters with manhattan geometry with high number of iterations to
% find best fit
iter = 100;
[clusters, centroids] = kmeans(datavar,eva1.OptimalK,'Replicates',iter, 'Distance','cityblock');

% plot silhouette values of items in clusters
[silh,h] = silhouette(datavar,clusters,'cityblock');
h = gca;
h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value'
ylabel 'Cluster'
title(['Silhouette values for clustering with ' num2str(iter) ' iterations (' lab ')'])

% who's who
tkmeans = table(group, subject, clusters, silh);
tcentroids = array2table(centroids);
tcentroids.Properties.VariableNames = data.Properties.VariableNames(ci:end);
writetable(tkmeans, ['Kmeans_clusters_' lab '.csv'])
writetable(tcentroids, ['Kmeans_centroids_' lab '.csv'])

% define groups and label for plots 
tgroups = tabulate(categorical(group));
tlabels = tabulate(double(categorical(group)));

%% Kmedoids

%[idx,C,sumd,d,midx,info] = kmedoids(datavar,2,'Distance','cityblock', 'replicates',5);

%% plot clusters (homemade solution)

figure;
plot(double(categorical(group(clusters==1)))+... % X: a number for the group 1:4
    (.01*subjnum(clusters==1)),...               %    + .01 * subject number to avoid overlapping
    clusters(clusters==1)+...                    % Y: cluster number
    silh(clusters==1),...                        %    + silhouette value (higher is better)
    'r.', 'MarkerSize', 14)                      % for cluster 1...
ylim([.5 2.7])
hold on
plot(double(categorical(group(clusters==2)))+... % and cluster 2.
    (.01*subjnum(clusters==2)),...
    clusters(clusters==2)+...
    silh(clusters==2),...
    'b.', 'MarkerSize', 14)
xlim([.5 4.7])
set(gca, 'XTick', 1:4)
set(gca,'XTickLabel', tgroups(:,1).');
set(gca, 'YTick', 1:2)
xlabel('groups')
ylabel('clusters')
hold on
title(['Kmeans clustering of participants (' lab ')'])




