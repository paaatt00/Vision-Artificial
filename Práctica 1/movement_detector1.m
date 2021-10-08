%MOVEMENT DETECTOR
%Get video from webcam and detect the movement.
%Author: Diego Orlando Barragán Guerrero
%For more information, visit: www.matpic.com
%diegokillemall@yahoo.com
%Loja (ECUADOR)
%Electronics & Telecommunications
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

clear all
clc

vid = videoinput('winvideo', 1);
set(vid, 'TriggerRepeat', Inf);
vid_src = getselectedsource(vid);
vid.FrameGrabInterval = 3;
start(vid);
try
    %    media=[];
    while(vid.FramesAcquired <= 50) % Stop after 110 frames
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
        %     sum(sum(m))
        %     media = [media sum(sum(m))];
        if sum(sum(m)) > 550
            disp('Movement');beep
        end
        %*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    end
    stop(vid);
catch
    stop(vid);
end