%---------------------
%Detecta el movimiento
%---------------------

clear all
close all

imaqhwinfo
info = imaqhwinfo('winvideo')
dev_info = imaqhwinfo('winvideo',1)

% Create video input object. 
vid = videoinput('winvideo', 1, 'YUY2_640x480');
preview(vid)
closepreview (vid)
get (vid)
vid_src = getselectedsource(vid);

% Set video input object properties for this application.
% Note that example uses both SET method and dot notation method.

set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 3; 
% vid_src.HorizontalFlip = 'on'

% Set value of a video source object property.

set(vid_src, 'Tag', 'motion detection setup');

% Create a figure window.
figure; 

% Start acquiring frames.
start(vid)

% Calculate difference image and display it.
while(vid.FramesAcquired <= 100) % Stop after 50 frames --> cambio!
    data = getdata(vid,2); 
    diff_im = imabsdiff(data(:,:,:,1),data(:,:,:,2));
    imshow(diff_im);
    % pause(0.5)    %Descomentar si no funciona
    IM = getdata(vid, 2);
        IMGray = rgb2gray(IM(:,:,1:3));
        IMbw = im2bw(IMGray,0.5);
        IMneg = imadjust(IMGray,[0 1],[1 0]);
        subplot(2,3,1); imshow(IM(:,:,:,1)); title('Input Video-Image')
        subplot(2,3,2); imshow(IMbw); title('Black & White Video')
        subplot(2,3,3); imshow(IMGray); title('Gray Scale Video')
        subplot(2,3,4); imshow(IMneg); title('Negative Image Video')
        %*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
        i1 = IM(:,:,:,1);
        i2 = IM(:,:,:,2);
        i1 = rgb2gray(i1(:,:,1:3));
        i2 = rgb2gray(i2(:,:,1:3));
        m = imabsdiff(i1, i2);
        % m = abs(double(i1) - double(i2))/256;
        subplot(2,3,5);imshow(m);title('Movement')
        %*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
        vid_src = getselectedsource(vid);
        %vid_src.Hue = 203;
        vid_src.Saturation = 177;
        vid_src.Gamma = 175;
        vid_src.Sharpness = 58;
        vid_src.WhiteBalance = 462;
        vid_src.Brightness = 137;
        vid_src.Contrast = 182;
        vid_src.Exposure = -9;
        subplot(2,3,6);imshow(vid);title('aaa')
        %*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
        %     sum(sum(m))
        %     media = [media sum(sum(m))];
        if sum(sum(m)) > 550
            disp('Movement');beep
        end
        %*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
end

stop(vid)

delete(vid)
clear
close(gcf)