% PRÁCTICA 1 - Patricia Cuesta Ruiz y Laura Mambrilla Moreno

clc; clear; close all;

% Create video input object
% vid = videoinput('winvideo', 1, 'MJPG_1920x1080');
vid = videoinput('winvideo', 1, 'MJPG_1280x720');
src = getselectedsource(vid);
vid.FramesPerTrigger = 30;

% Set video input object properties for this application
set(vid, 'TriggerRepeat', Inf);

% Create a figure window
figure; 

% Start acquiring frames
start(vid);

while(vid.FramesAcquired <= 200) % Stop after 200 frames
    IM = getdata(vid, 2);
    sizeIM = size(IM);
    rows = sizeIM(1,1);
    columns = sizeIM(1,2);

    % Gray and BW
    % IMGray = rgb2gray(IM(:, :, 1:3));
    % IMbw = im2bw(IMGray, 0.5);
    
    % One color
    % IM(:, :, 1) = IM(:, :, 1) * 2;
    % IM(:, :, 2) = IM(:, :, 2) * 2;
    % IM(:, :, 3) =  0;
    
    % Stripes
    firstR = rows/3;
    firstC = columns/3;
    secR = rows * (2/3);
    secC = columns * (2/3);
        % first stripe (red)
    IM(1:firstR, :, 2) = 0;
    IM(1:firstR, :, 3) = 0;
        % second stripe (yellow)
    IM(firstR:secR, :, 3) = 0;
        % third stripe (red)
    IM(secR:rows, :, 2) = 0;
    IM(secR:rows, :, 3) = 0;
    
    % show image
    imshow(IM(:,:,:,1));
end

stop(vid);
delete(vid)
close(gcf)