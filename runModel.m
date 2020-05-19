addpath('helpers');
load('models/quadraticSVM.mat');




varNames = {
    'VarName1'
    'VarName2'
    'VarName3'
    'VarName4'
    'VarName5'
    'VarName6'
    'VarName7'
    'VarName8'
    'VarName9'
    'VarName10'
    'VarName11'
    'VarName12'
    'VarName13'
    'VarName14'
    'VarName15'
    'VarName16'
    'VarName17'
    'VarName18'
    'VarName19'
    'VarName20'
    'VarName21'
    'VarName22'
    'VarName23'
    'VarName24'
    'VarName25'
    'VarName26'
    'VarName27'
    'VarName28'
    'VarName29'
    'VarName30'
    'VarName31'
    'VarName32'
    'VarName33'
    'VarName34'
    'VarName35'
    'VarName36'
    'VarName37'
    'VarName38'
    'VarName39'
    'VarName40'
    'VarName41'
    'VarName42'
    'VarName43'
    'VarName44'
    'VarName45'
    'VarName46'
    'VarName47'
    'VarName48'
    'VarName49'
    'VarName50'
    'VarName51'
    'VarName52'
    'VarName53'
    'VarName54'
    'VarName55'
    'VarName56'
    'VarName57'
    'VarName58'
    'VarName59'
    'VarName60'
};

rocks = 0;
mines = 0;

audioDir = 'audio';
audioFiles = dir(fullfile(audioDir, '*.m4a')); %gets all txt files in struct
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
