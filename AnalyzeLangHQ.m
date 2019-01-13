% % % Analyze Language History Questionnaire
clear all; close all; clc

group = 'Ita-Sard';
coded = 1;

if coded == 0 
    % read the logs
    logfile = dir('Lang_Quest_Ita_Sard-*.csv');
    logfile = sort_nat({logfile.name}).';
    for s = 1:length(logfile)
        [na, txt, whole]= xlsread(char(logfile(s)));
        subjnum = cellstr(strrep(strrep(char(logfile(s)), 'Lang_Quest_Ita_Sard-', 'sbj'), '.csv', ''));
        resp(:,s) = [subjnum; whole(2:end, 7)];
    end

    % consolidate them in a table and print it to file
    questions = readtable('codeQuestionsS.xlsx', 'ReadVariableName', false);
    alldata = [questions resp];
    writetable(alldata, 'all_responses_Lang_HQ_Sard.csv', 'QuoteStrings',true)   
else
    % code manually answers (according to "code questions.xlsx") - less prone to errors when all logs are there
    [n, t, coded] = xlsread('all_responses_Lang_HQ_Sard_CODED.xlsx');


%% extract means, range and sd and produce a table
sumstat = coded(:,1:5).';
sumstats = (sumstat(:, ~isnan(sum(cell2mat(sumstat(2:end, :))))));
sumstats = table(sumstats);
writetable(sumstats, 'linguistic_stats_Ita-Sard.csv', 'WriteVariableNames',false) 
nsubj = size(coded, 2)-5;

%% define L1 and L2

sc = size(coded, 1);
coded(sc+1, 1) = {'dominant'};
for ns = 1:nsubj
    if mean(cell2mat(coded(6:7,5+ns))) < mean(cell2mat(coded(19:20,5+ns)))
        coded(sc+1, 5+ns) = {'L1ita'};
    elseif mean(cell2mat(coded(6:7,5+ns))) > mean(cell2mat(coded(19:20,5+ns)))
        coded(sc+1, 5+ns) = {'L1sard'};
    elseif mean(cell2mat(coded(6:7,5+ns))) == mean(cell2mat(coded(19:20,5+ns)))
        coded(sc+1, 5+ns) = {'balanced'};
    end
end

%% print Coded to file
codedf = table(coded);
writetable(codedf, ['ling_variables_' group '.csv'], 'WriteVariableNames',false)

%% plot
fig1 = figure;
subplot(2,2,1)
    pie(categorical(coded(40, 6:end)))%, {'always' 'childhood' 'teen' 'adult'})
    view(-30, 90)
    hold on
    title('Since when have you been using more than one language?')
hold on
subplot(2,2,2)
    boxplot(cell2mat(coded(32, 6:end)))
    set(gca, 'XTickLabel', {})
    ylabel('1 = almost never; 7 = all the time');
    view(-270, 270)
    hold on
    title(['How often do you switch between languages? mean:' ...
        num2str(round(mean(cell2mat(coded(32, 6:end)))))])
hold on
subplot(2,2,3)
    hist(cell2mat(coded(34, 6:end)))
    ylim([0 30])
    xlim([-.5 4.5])
    set(gca, 'XTick', [0:4])
    xlabel('n languages');
    hold on
    title('How many other languages do you know?')
hold on
subplot(2,2,4)
    hist(cell2mat(coded(39,6:end )))
    ylim([0 30])
    xlim([.5 5.5])
    set(gca, 'XTick', [1:5])
    xlabel('1 = almost never; 5 = all the time');
    hold on
    title('Do people around you speak more than one language?')
suptitle(['Use of more languages in ' group])
saveas(fig1, ['Multiling_' group], 'tif')

fig2 = figure;
subplot(1,3,1)
    pie(categorical(coded(41, 6:end)));
    hold on
    title('Language Dominance')
hold on
subplot(1,3,2)
    boxplot([cell2mat(coded(6, 6:end)); cell2mat(coded(7, 6:end))].')
    ylabel('Age in years');
    set(gca, 'XTickLabel', {'Begin Learning' 'Speak Fluently'})
    ylim([0 35])
    hold on
    title ('When did you learn Italian?')
hold on
subplot(1,3,3)
boxplot([cell2mat(coded(19, 6:end)); cell2mat(coded(20, 6:end))].')
    ylabel('Age in years');
    set(gca, 'XTickLabel', {'Begin Learning' 'Speak Fluently'})
    ylim([0 35])
    hold on
    title ('When did you learn Sardinian?')
hold on
suptitle('Linguistic dominance and age of acquisition')
saveas(fig2, ['Dominance_' group], 'tif')


fig3 = figure;
subplot(1,2,1)
    prof = ([mean(cell2mat(coded(8, 6:end))); mean(cell2mat(coded(9, 6:end)));...
        mean(cell2mat(coded(10, 6:end))); mean(cell2mat(coded(11, 6:end)))].');
    err = ([std(cell2mat(coded(8, 6:end))); std(cell2mat(coded(9, 6:end)));...
        std(cell2mat(coded(10, 6:end))); std(cell2mat(coded(11, 6:end)))].');
    bar(prof)
    hold on
    h=errorbar(prof, err);
    set(h(1),'LineStyle','none')
    ylim([1 7.5])
    set(gca,'XTickLabel',{'OralProd', 'WritProd', 'OralCompr', 'WritCompr'})
    ylabel('Mean Rating from 1 to 7. Bars = SD');
    hold on
    title ('Italian proficiency')
hold on
subplot(1,2,2)
    exp = ([mean(cell2mat(coded(15, 6:end))); mean(cell2mat(coded(16, 6:end)));...
        mean(cell2mat(coded(17, 6:end))); mean(cell2mat(coded(18, 6:end)))].');
    err = ([std(cell2mat(coded(15, 6:end))); std(cell2mat(coded(16, 6:end)));...
        std(cell2mat(coded(17, 6:end))); std(cell2mat(coded(18, 6:end)))].');
    bar(exp)
    hold on
    h=errorbar(exp, err);
    set(h(1),'LineStyle','none')
    ylim([1 7.5])
    set(gca,'XTickLabel',{'Childhood Home', 'Childhood School', 'Now Home', 'Now Work'})
    ylabel('Mean Rating from 1 to 7. Bars = SD');
    hold on
    title ('Exposure to Italian')
hold on
suptitle(['Proficiency and Exposure: Italian ' group])
saveas(fig3, ['Italian_' group], 'tif')


fig4 = figure;
subplot(1,2,1)
    prof = ([mean(cell2mat(coded(21, 6:end))); mean(cell2mat(coded(22, 6:end)));...
        mean(cell2mat(coded(23, 6:end))); mean(cell2mat(coded(24, 6:end)))].');
    err = ([std(cell2mat(coded(21, 6:end))); std(cell2mat(coded(22, 6:end)));...
        std(cell2mat(coded(23, 6:end))); std(cell2mat(coded(24, 6:end)))].');
    bar(prof)
    hold on
    h=errorbar(prof, err);
    set(h(1),'LineStyle','none')
    ylim([1 7.5])
    set(gca,'XTickLabel',{'OralProd', 'WritProd', 'OralCompr', 'WritCompr'})
    ylabel('Mean Rating from 1 to 7. Bars = SD');
    hold on
    title ('Sardinian proficiency')
hold on
subplot(1,2,2)
    exp = ([mean(cell2mat(coded(28, 6:end))); mean(cell2mat(coded(29, 6:end)));...
        mean(cell2mat(coded(30, 6:end))); mean(cell2mat(coded(31, 6:end)))].');
    err = ([std(cell2mat(coded(28, 6:end))); std(cell2mat(coded(29, 6:end)));...
        std(cell2mat(coded(30, 6:end))); std(cell2mat(coded(31, 6:end)))].');
    bar(exp)
    hold on
    h=errorbar(exp, err);
    set(h(1),'LineStyle','none')
    ylim([1 7.5])
    set(gca,'XTickLabel',{'Childhood Home', 'Childhood School', 'Now Home', 'Now Work'})
    ylabel('Mean Rating from 1 to 7. Bars = SD');
    hold on
    title ('Exposure to Sardinian')
hold on
suptitle(['Proficiency and Exposure: Sardinian' group])
saveas(fig4, ['Sardinian_' group], 'tif')



end
