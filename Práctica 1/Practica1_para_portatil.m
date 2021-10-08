clear all
close all
clc

imaqhwinfo
info = imaqhwinfo('winvideo')
dev_info = imaqhwinfo('winvideo',1)

% Create video input object. 
% vid = videoinput('winvideo', 1, 'YUY2_640x480');
vid = videoinput('winvideo', 1, 'MJPG_1280x720');
preview(vid)
closepreview(vid)
get(vid)
vid_src = getselectedsource(vid);

vid_src.Hue = 203;
vid_src.Saturation = 177;
vid_src.Gamma = 175;
vid_src.Sharpness = 58;
vid_src.WhiteBalance = 462;
vid_src.Brightness = 137;
vid_src.Contrast = 182;
vid_src.Exposure = -9;

% Set video input object properties for this application.
% Note that example uses both SET method and dot notation method.

set(vid, 'TriggerRepeat', Inf);
vid.FrameGrabInterval = 3; 
% vid_src.HorizontalFlip = 'on'

% Set value of a video source object property.

set(vid_src, 'Tag', 'motion detection setup');

% Create a figure window.
figure; 

% Start acquiring frames.
start(vid)

% Calculate difference image and display it.
while(vid.FramesAcquired <= 100) % Stop after 100 frames
    data = getdata(vid, 2); 
    diff_im = imabsdiff(data(:,:,:,1), data(:,:,:,2));
    imshow(diff_im);
    % pause(0.5)    %Descomentar si no funciona
end

stop(vid)

delete(vid)
clear
close(gcf)

