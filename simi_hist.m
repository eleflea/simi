function [ rate ] = simi_hist( image1, image2, opt )
% Calculate similarity of two images by histogram.
% Use:
% rate = simi_hist('path\to\image1','path\to\image2'[,opt])
% rate = simi_hist(image1_data,image2_data[,opt])
% return a dobule number of similarity.
% opt:
% r: RGB mode, default.
% g: gray mode.
% o: cosine similarity, default.
% c: corr2.
% n: no figure.

%% init
if(2 == nargin)
    opt='';
end

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

if(strfind(opt, 'g'))
    try
        t1=rgb2gray(im1);
        t2=rgb2gray(im2);
    catch
        t1=im1;
        t2=im2;
    end
else
    t1=im1;
    t2=im2;
end

%% resize
[a1,b1,c]=size(t1);
t2=imresize(t2,[a1,b1],'bicubic');
t1=round(t1);
t2=round(t2);

%% histogram
if(strfind(opt, 'g'))
    % Gray mode
    e1=zeros(1,256);
    e2=zeros(1,256);
    
    for i=1:a1
        for j=1:b1
            m1=t1(i,j)+1;
            m2=t2(i,j)+1;
            if(m1>256)
                m1=256
            end
            if(m2>256)
                m2=256
            end
            e1(m1)=e1(m1)+1;
            e2(m2)=e2(m2)+1;
        end
    end
    
    % show histogram or not
    if(isempty(strfind(opt, 'n')))
        figure;
        subplot(1,2,1),imhist(t1(:,:,1));
        subplot(1,2,2),imhist(t2(:,:,1));
    end
    
    % calculate
    m1=zeros(1,64);
    m2=zeros(1,64);
    
    for i=0:63
       m1(1,i+1)=e1(4*i+1)+e1(4*i+2)+e1(4*i+3)+e1(4*i+4);
       m2(1,i+1)=e2(4*i+1)+e2(4*i+2)+e2(4*i+3)+e2(4*i+4);
    end
    
    if(strfind(opt, 'c'))
        rate=corr2(m1,m2);
    else
        A=sqrt(sum(sum(m1.^2)));
        B=sqrt(sum(sum(m2.^2)));
        C=sum(sum(m1.*m2));
        rate=C/(A*B);
    end
else
    % RGB mode
    e1=zeros(3,256);
    e2=zeros(3,256);
    
    for c=1:3
        for i=1:a1
            for j=1:b1
                m1=t1(i,j,c)+1;
                m2=t2(i,j,c)+1;
                e1(c,m1)=e1(c,m1)+1;
                e2(c,m2)=e2(c,m2)+1;
            end
        end
    end
    
    % show histogram or not
    if(isempty(strfind(opt, 'n')))
        figure;
        subplot(1,2,1),imhist(t1(:,:,1)),hold on,imhist(t1(:,:,2)),imhist(t1(:,:,3)),hold off;
        subplot(1,2,2),imhist(t2(:,:,1)),hold on,imhist(t2(:,:,2)),imhist(t2(:,:,3)),hold off;
    end
    
    % calculate
    m1=zeros(3,64);
    m2=zeros(3,64);
    
    for c=1:3
        for i=0:63
           m1(c,i+1)=e1(c,4*i+1)+e1(c,4*i+2)+e1(c,4*i+3)+e1(c,4*i+4);
           m2(c,i+1)=e2(c,4*i+1)+e2(c,4*i+2)+e2(c,4*i+3)+e2(c,4*i+4);
        end
    end

    if(strfind(opt, 'c'))
        rate=corr2(m1,m2);
    else
        r=zeros(1,3);
        for c=1:3
            A=sqrt(sum(sum(m1(c,:).^2)));
            B=sqrt(sum(sum(m2(c,:).^2)));
            C=sum(sum(m1(c,:).*m2(c,:)));
            r(c)=C/(A*B);
        end
        rate=mean(r);
    end
end

%% show images or not
if(isempty(strfind(opt, 'n')))
    figure;
    imshow(uint8([t1,t2]));
end

end

