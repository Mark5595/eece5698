
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
source_dir = '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/'
images_dir = 'latino_center/calib'
%images_dir = 'brick_wall/landscape'
%images_dir = 'brick_wall'
%images_dir = 'tromso_night'
%images_dir = 'willis'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load images.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
buildingDir = fullfile(source_dir, images_dir)
buildingScene = datastore(buildingDir);

% Shrink images
inputSize = [300 300];
buildingScene.ReadFcn = @(buildingScene)imresize(imread(buildingScene), inputSize);
IPano = imread([source_dir 'figures/pano_latin.jpg']);
I1 = readimage(buildingScene, 1);
I2 = readimage(buildingScene, 2);
figure
imshowpair(I1, I2, 'montage');
title('Original Images');

% Detect feature points
panoPoints = detectMinEigenFeatures(rgb2gray(IPano), 'MinQuality', 0.1);
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'MinQuality', 0.1);
imagePoints2 = detectMinEigenFeatures(rgb2gray(I2), 'MinQuality', 0.1);

% Visualize detected points
figure
imshow(IPano, 'InitialMagnification', 50);
title('150 Strongest Corners from the Pano Image');
hold on

plot(selectStrongest(imagePoints1, 1500));
figure
imshow(I1, 'InitialMagnification', 50);
title('150 Strongest Corners from the First Image');
hold on
plot(selectStrongest(imagePoints1, 1500));

figure
imshow(I2, 'InitialMagnification', 50);
title('150 Strongest Corners from the Second Image');
hold on
plot(selectStrongest(imagePoints2, 1500));

%% Create the point tracker
%tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);
%
%% Initialize the point tracker
%imagePoints1 = imagePoints1.Location;
%initialize(tracker, imagePoints1, I1);
%
%% Track the points
%[imagePoints2, validIdx] = step(tracker, I2);
%matchedPoints1 = imagePoints1(validIdx, :);
%matchedPoints2 = imagePoints2(validIdx, :);

[featuresPano, panoPoints] = extractFeatures(rgb2gray(IPano), panoPoints);
[features1, imagePoints1] = extractFeatures(rgb2gray(I1), imagePoints1);
[features2, imagePoints2] = extractFeatures(rgb2gray(I2), imagePoints2);

indexPairs = matchFeatures(featuresPano, features1, 'Unique', true);

matchedPointsPano = panoPoints(indexPairs(:, 1), :)
matchedPoints1 = imagePoints1(indexPairs(:, 2), :)


% Visualize correspondences
figure
showMatchedFeatures(IPano, I1, matchedPointsPano, matchedPoints1);
title('Tracked Features');

tform = estimateGeometricTransform(matchedPointsPano,matchedPoints1,'affine')



%% Estimate the fundamental matrix
%[E, epipolarInliers] = estimateEssentialMatrix(...
%    matchedPoints1, matchedPoints2, cameraParams, 'Confidence', 99.99);
%
%% Find epipolar inliers
%inlierPoints1 = matchedPoints1(epipolarInliers, :);
%inlierPoints2 = matchedPoints2(epipolarInliers, :);
%
%% Display inlier matches
%figure
%showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
%title('Epipolar Inliers');

%[orient, loc] = relativeCameraPose(E, cameraParams, inlierPoints1, inlierPoints2);

