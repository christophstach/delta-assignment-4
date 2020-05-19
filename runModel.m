addpath('helpers');
load('models/quadraticSVM.mat');
load('models/varNames.mat');

rocks = 0;
mines = 0;

confusion_matrix = [
    0 0;
    0 0
];

targets = [];
ouputs = [];    

audioDir = 'audio';
audioFiles = dir(fullfile(audioDir, '*.m4a'));
for k = 1:length(audioFiles)
    baseFileName = audioFiles(k).name;
    fullFileName = fullfile(audioDir, baseFileName);
  
  
    [y, Fs] = audioread(fullFileName);
    features = extractFeaturesCodegen(y, Fs, 3, 3);
    features_normalized = normalize(features);
        
    table = array2table(features_normalized, 'VariableNames', varNames);
    predicted_label = quadraticSVM.predictFcn(table);
    
    if contains(fullFileName, 'metal')
        real_label = 'M';
    else
        real_label = 'R';
    end
    
    if isequal(real_label, 'M') && isequal(predicted_label, 'M')
        confusion_matrix(1, 1) = confusion_matrix(1, 1) + 1;
    end
    
    if isequal(real_label, 'M') && isequal(predicted_label, 'R')
        confusion_matrix(1, 2) = confusion_matrix(1, 2) + 1;
    end
    
    if isequal(real_label, 'R') && isequal(predicted_label, 'M')
        confusion_matrix(2, 1) = confusion_matrix(2, 1) + 1;
    end
    
    if isequal(real_label, 'R') && isequal(predicted_label, 'R')
        confusion_matrix(2, 2) = confusion_matrix(2, 2) + 1;
    end
    
    if predicted_label == 'R'
        rocks = rocks + 1;
    else
        mines = mines + 1;
    end
end

disp(confusion_matrix);
plotconfusion(tragets, outputs)
disp('Rocks: ' + string(rocks));
disp('Mines: ' + string(mines));
