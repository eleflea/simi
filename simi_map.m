function [ rate ] = simi_map( image1, image2, n, opt )
%SIMI_MAP Summary of this function goes here
%   Detailed explanation goes here
%% init
if(3 == nargin)
    opt='';
end

opt=[opt,'g'];

%% saliency map
samap1=samap(image1);
samap2=samap(image2);

%% simi_phist
rate=simi_phist(samap1,samap2,n,opt);
%rate=simi_corr2(samap1,samap2);

%% resize and show
s1=size(samap1);
samap2=imresize(samap2,s1(:,[1,2]),'bicubic');

if(~strfind(opt, 'n'))
    figure;
    imshow([samap1,samap2]);
end

end

