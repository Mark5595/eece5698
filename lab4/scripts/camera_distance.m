
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

I = readimage(buildingScene, 1);

a = size(I)
% Shrink images
scale = [8 8 1]
inputSize = size(I)./scale
buildingScene.ReadFcn = @(buildingScene)imresize(imread(buildingScene), inputSize(1:2));

numImages = numel(buildingScene.Files);

IPano = imread([source_dir 'figures/pano_latin.jpg']);

tformArray(numImages) = affine2d(eye(3));

for n = 1:numImages
    image = readimage(buildingScene, n);

    %figure
    %imshowpair(IPano, image, 'montage');
    %title('Original Images');
    
    % Detect feature points
    panoPoints = detectMinEigenFeatures(rgb2gray(IPano), 'MinQuality', 0.1);
    imagePoints = detectMinEigenFeatures(rgb2gray(image), 'MinQuality', 0.1);
    
    % Visualize detected points
    %figure
    %imshow(IPano, 'InitialMagnification', 50);
    %title('150 Strongest Corners from the Pano Image');
    %hold on
    %
    %plot(selectStrongest(imagePoints, 1500));
    %figure
    %imshow(image, 'InitialMagnification', 50);
    %title('150 Strongest Corners from the First Image');
    %hold on
    %plot(selectStrongest(imagePoints, 1500));
    
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
    [features, imagePoints] = extractFeatures(rgb2gray(image), imagePoints);
    
    indexPairs = matchFeatures(featuresPano, features, 'Unique', true);
    
    matchedPointsPano = panoPoints(indexPairs(:, 1), :)
    matchedPoints = imagePoints(indexPairs(:, 2), :)
    
    % Find the center of all the matched points
    average_x = mean(matchedPoints.Location(:, 1));
    average_y = mean(matchedPoints.Location(:, 2));
    
    % Visualize correspondences
    figure
    showMatchedFeatures(IPano, image, matchedPointsPano, matchedPoints);
    title('Tracked Features');
    
    tformArray(n) = estimateGeometricTransform(matchedPointsPano,matchedPoints,'affine')

    %% Get size of existing image A. 
    %[rowsA colsA numberOfColorChannelsA] = size(IPano); 
    %% Get size of existing image B. 
    %[rowsB colsB numberOfColorChannelsB] = size(image); 
    %% See if lateral sizes match. 
    %if rowsB ~= rowsA || colsA ~= colsB 
    %    % Size of B does not match A, so resize B to match A's size. 
    %    B = imresize(B, [rowsA colsA]); 
    %end
    new_image = imwarp(image, tformArray(n));
    figure;
    imshowpair(IPano, new_image, 'montage');
    title('Adjusted picture')
    

end
  
figure;
%imshow(IPano)
hold on;
% Plot Center points
for n = 1:numImages
    % Translate the center point 
    trans_x = tformArray(n).T(3, 1);
    trans_y = tformArray(n).T(3, 2);
    center_x = inputSize(2)/2 + abs(trans_x);
    center_y = inputSize(1)/2 + abs(trans_y);
    plot(center_x, center_y, 'g+', 'markers', 5)
end
hold off;
title('Center of Pictures')
xlabel('X Axis Pixels (px)')
ylabel('Y Axis Pixels (px)')
axis([0 size(IPano, 2) 0 size(IPano, 1)])

figure;
imshow(IPano)
hold on;
% Plot Center points
for n = 1:numImages
    % Translate the center point 
    trans_x = tformArray(n).T(3, 1);
    trans_y = tformArray(n).T(3, 2);
    center_x = inputSize(2)/2 + abs(trans_x);
    center_y = inputSize(1)/2 + abs(trans_y);
    plot(center_x, center_y, 'g+', 'markers', 5)
end

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

