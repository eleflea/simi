function [ map_data ] = samap( image )
% Calculate saliency map of image.
% Use:
% map_data = samap('path\to\image')
% map_data = samap(image_data)
% return map data (double) of image.

%% Read image from file
if(isequal(class(image),'char'))
    inImg=im2double(rgb2gray(imread(image)));
else
    inImg=im2double(rgb2gray(image));
end
%%inImg = imresize(inImg, 64/size(inImg, 2));

%% Spectral Residual
myFFT = fft2(inImg);
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
saliencyMap = abs(ifft2(exp(mySpectralResidual + 1i*myPhase))).^2;

%% After Effect
saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [10, 10], 2.5)));
imshow(saliencyMap);
map_data = uint8(round(saliencyMap.*255));

end

