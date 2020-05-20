addpath('helpers');
load('models/quadraticSVM.mat');
load('models/varNames.mat');

clear features
clear features_normalized

targets = [];
outputs = [];    

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
        targets = [targets 0];
    else
        targets = [targets 1];
    end
    
    if predicted_label == 'M'
        outputs = [outputs 0];
    else    
        outputs = [outputs 1];
    end
end


plotconfusion(targets, outputs);
