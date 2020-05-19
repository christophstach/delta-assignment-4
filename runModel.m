addpath('helpers');
load('models/quadraticSVM.mat');
load('models/varNames.mat');

rocks = 0;
mines = 0;

audioDir = 'audio';
audioFiles = dir(fullfile(audioDir, '*.m4a'));
for k = 1:length(audioFiles)
    baseFileName = audioFiles(k).name;
    fullFileName = fullfile(audioDir, baseFileName);
  
  
    [y, Fs] = audioread(fullFileName);
    features = extractFeaturesCodegen(y, Fs, 2, 0);
    features_normalized = mean(normalize(features));
    

    table = array2table(features_normalized, 'VariableNames', varNames);
    prediction = quadraticSVM.predictFcn(table);
    
    if prediction == 'R'
        rocks = rocks + 1;
    else
        mines = mines + 1;
    end
end

disp(rocks);
disp(mines);
