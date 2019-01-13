% % % Compare Groups: Language History Questionnaire
clear all; close all; clc

ItaSMono = readtable('ling_variables_Ita-S-Mono.csv', 'ReadVariableName', false);
ItaEng = readtable('ling_variables_Ita-Eng.csv', 'ReadVariableName', false);

%% compare all variables: use a 2 samples ttest for numerical variables, a Mann Whitney U test for ordinal ones

% NOTE if group is english variables on row > 21 need to add 1
% age
[h.age, p.age] = ttest2(str2double(table2array(ItaEng(2, 6:end))),...
    str2double(table2array(ItaSMono(2, 6:end))));
% edu
[h.edu, p.edu] = ttest2(str2double(table2array(ItaEng(5, 6:end))),...
    str2double(table2array(ItaSMono(5, 6:end))));

% begin_learn_Ita
[h.beginLearnIta, p.beginLearnIta] = ttest2(str2double(table2array(ItaEng(6, 6:end))),...
    str2double(table2array(ItaSMono(6, 6:end))));
% begin_fluent_Ita
[h.beginFluentIta, p.beginFluentIta] = ttest2(str2double(table2array(ItaEng(7, 6:end))),...
    str2double(table2array(ItaSMono(7, 6:end))));
% Ita_oral_prod
[p.OralProdIta, h.OralProdIta] = ttest2(str2double(table2array(ItaEng(8, 6:end))),...
    str2double(table2array(ItaSMono(8, 6:end))));
% [p.OralProdIta, h.OralProdIta] = ranksum(str2double(table2array(ItaEng(8, 6:end))),...
%     str2double(table2array(ItaSMono(8, 6:end))));
% Ita_writ_prod
[p.WritProdIta, h.WritProdIta] = ranksum(str2double(table2array(ItaEng(9, 6:end))),...
    str2double(table2array(ItaSMono(9, 6:end))));
% Ita_oral_compr
[p.OralCompIta, h.OralCompIta] = ranksum(str2double(table2array(ItaEng(10, 6:end))),...
    str2double(table2array(ItaSMono(10, 6:end))));
% Ita_writ_compr
[p.WritCompIta, h.WritCompIta] = ranksum(str2double(table2array(ItaEng(11, 6:end))),...
    str2double(table2array(ItaSMono(11, 6:end))));
% n_contexts ita
[h.NContextsIta, p.NContextsIta] = ttest2(str2double(table2array(ItaEng(12, 6:end))),...
    str2double(table2array(ItaSMono(12, 6:end))));
% exposure ita
[p.ExpIta, h.ExpIta] = ranksum(str2double(table2array(ItaEng(14, 6:end))),...
    str2double(table2array(ItaSMono(14, 6:end))));
% exp_home_child ita
[p.ExpHomeChildIta, h.ExpHomeChildIta] = ranksum(str2double(table2array(ItaEng(15, 6:end))),...
    str2double(table2array(ItaSMono(15, 6:end))));
% exp_school_child ita
[p.ExpSchoolChildIta, h.ExpSchoolChildIta] = ranksum(str2double(table2array(ItaEng(16, 6:end))),...
    str2double(table2array(ItaSMono(16, 6:end))));
% exp_home_now ita
[p.ExpHomeNowIta, h.ExpHomeNowIta] = ranksum(str2double(table2array(ItaEng(17, 6:end))),...
    str2double(table2array(ItaSMono(17, 6:end))));
% exp_work_now ita
[p.ExpWorkNowIta, h.ExpWorkNowIta] = ranksum(str2double(table2array(ItaEng(18, 6:end))),...
    str2double(table2array(ItaSMono(18, 6:end))));

% begin_learn_L2
[h.BeginLearnL2, p.BeginLearnL2] = ttest2(str2double(table2array(ItaEng(19, 6:end))),...
    str2double(table2array(ItaSMono(19, 6:end))));
% begin_fluent_L2
[h.BeginFluentL2, p.BeginFluentL2] = ttest2(str2double(table2array(ItaEng(20, 6:end))),...
    str2double(table2array(ItaSMono(20, 6:end))));
% L2_oral_prod
[p.OralProdL2, h.OralProdL2] = ranksum(str2double(table2array(ItaEng(22, 6:end))),...
    str2double(table2array(ItaSMono(21, 6:end))));
% L2_writ_prod
[p.WritProdL2, h.WritProdL2] = ranksum(str2double(table2array(ItaEng(23, 6:end))),...
    str2double(table2array(ItaSMono(22, 6:end))));
% L2_oral_compr
[p.OralCompL2, h.OralCompL2] = ranksum(str2double(table2array(ItaEng(24, 6:end))),...
    str2double(table2array(ItaSMono(23, 6:end))));
% L2_writ_compr
[p.WritCompL2, h.WritCompL2] = ranksum(str2double(table2array(ItaEng(25, 6:end))),...
    str2double(table2array(ItaSMono(24, 6:end))));
% n_contexts L2
[h.NContextsL2, p.NContextsL2] = ttest2(str2double(table2array(ItaEng(26, 6:end))),...
    str2double(table2array(ItaSMono(25, 6:end))));
% exposure L2
[p.ExpL2, h.ExpL2] = ranksum(str2double(table2array(ItaEng(28, 6:end))),...
    str2double(table2array(ItaSMono(27, 6:end))));
% exp_home_child L2
[p.ExpHomeChildL2, h.ExpHomeChildL2] = ranksum(str2double(table2array(ItaEng(29, 6:end))),...
    str2double(table2array(ItaSMono(28, 6:end))));
% exp_school_child L2
[p.ExpSchoolChildL2, h.ExpSchoolChildL2] = ranksum(str2double(table2array(ItaEng(30, 6:end))),...
    str2double(table2array(ItaSMono(29, 6:end))));
% exp_home_now_L2
[p.ExpHomeNowL2, h.ExpHomeNowL2] = ranksum(str2double(table2array(ItaEng(31, 6:end))),...
    str2double(table2array(ItaSMono(30, 6:end))));
% exp_work_now_L2
[p.ExpWorkNowL2, h.ExpWorkNowL2] = ranksum(str2double(table2array(ItaEng(32, 6:end))),...
    str2double(table2array(ItaSMono(31, 6:end))));

% freq_switch
[p.FreqSw, h.FreqSw] = ranksum(str2double(table2array(ItaEng(33, 6:end))),...
    str2double(table2array(ItaSMono(32, 6:end))));
% n_other_lang
[h.OtherLang, p.OtherLang] = ttest2(str2double(table2array(ItaEng(35, 6:end))),...
    str2double(table2array(ItaSMono(34, 6:end))));
% multiling
[p.Multi, h.Multi] = ranksum(str2double(table2array(ItaEng(40, 6:end))),...
    str2double(table2array(ItaSMono(39, 6:end))));

%% print to file

variables = fieldnames(h);
for v = 1:length(fieldnames(h))
     hv(v,1) = h.(variables{v});
     pv(v,1) = p.(variables{v});
end
stats = table(variables, hv, pv);
writetable(stats, 'statsCompared_ItaEng-ItaSMono.csv')