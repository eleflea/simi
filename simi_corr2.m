function [ rate ] = simi_corr2( image1, image2 )	
% Calculate similarity of two images by using corr2.
% Use:
% rate = simi_corr2('path\to\image1','path\to\image2')
% rate = simi_corr2(image_data,image2_data)
% return a dobule number of similarity.

%% read
if(isequal(class(image1),'char'))
    im1=imread(image1);
else
    im1=image1;
end

if(isequal(class(image2),'char'))
    im2=imread(image2);
else
    im2=image2;
end

%% resize
s1=size(im1);
im2=imresize(im2,s1(:,[1,2]),'bicubic');

%% calculate RGB
r=zeros(1,3);
for i=1:3
    r(i)=corr2(im1(:,:,i),im2(:,:,i));
end
rate=mean(r);

%% show figure
figure;
imshow(uint8([im1,im2]));

end