% produce a summary of the LHq variables by experiment
clear all; clc

data = readtable('all_variables_4groups_LSW.csv', 'ReadVariableNames', false);

groups = {'IE', 'ISS'};

% find the groups
for g = 1:length(groups)
    p = 1;
    
    for w = 1:width(data)
        
        if strncmp(table2cell(data(1,w)), groups{g}, size(groups{g}, 2))
            
            bygroup.(groups{g})(1, p) = str2double(table2array(data(3,w)));  % age 
            bygroup.(groups{g})(2, p) = str2double(table2array(data(8,w)));  % edu 
            
            bygroup.(groups{g})(3, p) = str2double(table2array(data(9,w)));  % L1 begin acq 
            bygroup.(groups{g})(4, p) = str2double(table2array(data(10,w)));  % L1 begin acq fluent
            bygroup.(groups{g})(5, p) = str2double(table2array(data(13,w)));  % L1 oral prod
            bygroup.(groups{g})(6, p) = str2double(table2array(data(14,w)));  % L1 writ prod
            bygroup.(groups{g})(7, p) = str2double(table2array(data(15,w)));  % L1 oral compr
            bygroup.(groups{g})(8, p) = str2double(table2array(data(16,w)));  % L1 writ compr
            bygroup.(groups{g})(9, p) = str2double(table2array(data(25,w)));  % L1 mean exp
            
            bygroup.(groups{g})(10, p) = str2double(table2array(data(26,w)));  % L2 begin acq 
            bygroup.(groups{g})(11, p) = str2double(table2array(data(27,w)));  % L2 begin acq fluent
            bygroup.(groups{g})(12, p) = str2double(table2array(data(31,w)));  % L2 oral prod
            bygroup.(groups{g})(13, p) = str2double(table2array(data(32,w)));  % L2 writ prod
            bygroup.(groups{g})(14, p) = str2double(table2array(data(33,w)));  % L2 oral compr
            bygroup.(groups{g})(15, p) = str2double(table2array(data(34,w)));  % L2 writ compr
            bygroup.(groups{g})(16, p) = str2double(table2array(data(43,w)));  % L2 mean exp
            
            bygroup.(groups{g})(17, p) = str2double(table2array(data(46,w)));  % freq switch
            
            p = p+1;
            
        end
    end
    
    % labels
    labels = {'age';'edu';'L1beginAcq';...
        'L1beginAcqFluent';'L1speak';...
        'L1write';'L1listen';'L1read';...
        'L1exp';'L2beginAcq';'L2beginAcqFluent';...
        'L2speak';'L2write';'L2listen';...
        'L2read';'L2exp';'freqswitch'};
    
    % average tables
    avbygroup(:, g) = nanmean(bygroup.(groups{g}), 2);
    sdbygroup(:, g) = nanstd(bygroup.(groups{g}), 0,2);
 
end

clear p

%%  % compare
 ittest = [1, 2, 3, 4, 10, 11]; % an index to find numeric values for ttest
 imwu = [5:9, 12:17]; % an index to find ordinal values for Wilcoxon rank sum test
 
 for a = 1: size(avbygroup, 1)
     
     if ismember(a, ittest)
        [h.IEISS(a,:),p.IEISS(a,:)] =...
        ttest2(bygroup.IE(a,:), bygroup.ISS(a,:));
     elseif ismember(a, imwu)
         [p.IEISS(a,:), h.IEISS(a,:)] =...
        ranksum(bygroup.IE(a,:), bygroup.ISS(a,:));
     end
         
    if p.IEISS(a,:) <= .05 && p.IEISS(a,:) > .01
        star.IEISS{a, :} = '*';
    elseif p.IEISS(a,:) <= .01 && p.IEISS(a,:) > .001
        star.IEISS{a, :} = '**';
    elseif p.IEISS(a,:) <= .001 
        star.IEISS{a, :} = '***';  
    else star.IEISS{a, :} = '';
    end
    
    
   
 end
 
 
 tabav = (reshape([avbygroup;sdbygroup], size(avbygroup,1), []));
 tabav = array2table(tabav(:, :));
 tabav.Properties.VariableNames = ...
     {'IEm', 'IEsd', 'ISm', 'ISsd'};
 %tabp = struct2table(p);
 tabp = struct2table(star);

 alltab = [labels, tabav, tabp];
 
 writetable(alltab, 'compareLHq_LSw.csv')
 
 %% compare, in each group, L1 proficiency to L2 proficiency as a measure of dominance
 
 
  for g = 1:length(groups)
      
      dom(g, 1) = ...    
      ranksum(bygroup.(groups{g})(5,:), bygroup.(groups{g})(12,:));
      
      dom(g, 2) = ...
      ranksum(bygroup.(groups{g})(6,:), bygroup.(groups{g})(13,:));
  
      dom(g, 3) = ...
      ranksum(bygroup.(groups{g})(7,:), bygroup.(groups{g})(14,:));
  
      dom(g, 4) = ...
      ranksum(bygroup.(groups{g})(8), bygroup.(groups{g})(15,:));
            
  end
 
 domt = array2table(dom(:, :));
 domt.Properties.VariableNames = ...
     {'OralProd', 'WritProd', 'OralCompr', 'WritCompr'};
 domt.Properties.RowNames = groups;
 writetable(domt, 'compare_dominance.csv', 'WriteRowNames',true)
 
 
 %%  calculate correlation between age and years of education and other variables
 
 [rall.r, rall.p] = corrcoef (table2array(struct2table(bygroup)).');
 signp = rall.p < .05;
 
 signrt = array2table(rall.r(:, :));
 signrt.Properties.VariableNames = labels;
 signrt.Properties.RowNames = labels;
 writetable(signrt, 'correlation_LHq_r_LSw.csv', 'WriteRowNames',true)
 
 signpp = array2table(rall.p(:, :));
 signpp.Properties.VariableNames = labels;
 signpp.Properties.RowNames = labels;

 writetable(signpp, 'correlation_LHq_p_LSw.csv', 'WriteRowNames',true)

 signpt = array2table(signp(:, :));
 signpt.Properties.VariableNames = labels;
 signpt.Properties.RowNames = labels;

 writetable(signpt, 'correlation_LHq_logical_LSw.csv', 'WriteRowNames',true)
