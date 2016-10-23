function [ rate ] = simi_phist( image1, image2, n, opt )
% Calculate similarity of two images by fraction histogram.
% Use:
% rate = simi_phist('path\to\image1','path\to\image2',pieces[,opt])
% rate = simi_phist(image1_data,image2_data,pieces[,opt])
% return a dobule number of similarity.
% opt:
% r: RGB mode, default.
% g: gray mode.
% o: cosine similarity, default.
% c: corr2.
% n: no figure.

%% init
if(3 == nargin)
    opt='';
end

%% split
IMdata1=splitter(image1, n);
IMdata2=splitter(image2, n);
r=zeros(n,n);

%% calculate
for ii=1:n
    for jj=1:n
        r(ii,jj)=simi_hist(IMdata1{ii,jj},IMdata2{ii,jj},[opt,'n']);
    end
end

rate=mean(r(:));

end

