function [ rate ] = simi_map( image1, image2, n, opt )
% Calculate similarity of two images by saliency map and fraction histogram.
% Use:
% rate = simi_map('path\to\image1','path\to\image2',pieces[,opt])
% rate = simi_map(image1_data,image2_data,pieces[,opt])
% return a dobule number of similarity.
% opt:
% o: cosine similarity, default.
% c: corr2.
% n: no figure.
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

if(isempty(strfind(opt, 'n')))
    figure;
    imshow([samap1,samap2]);
end

end

