function [ IMdata ] = splitter( path, n )
% Split an image to n*n.
% Use:
% IMdata = splitter('path\to\image', dimesion)
% IMdata = splitter(image_data, dimesion)
% return a n*n cell.

%% init
IMdata=cell(n);

if(isequal(class(path),'char'))
    M=imread(path);
else
    M=path;
end

[h,w,l]=size(M);

%% split
for i = 1:n
    for j = 1:n
       fix_h=fix(h/n);
       fix_w=fix(w/n);
       h_start=1+(i-1)*fix_h;
       h_end=i*fix_h;
       w_start=1+(j-1)*fix_w;
       w_end=j*fix_w;
       IMdata{i,j}=M(h_start:h_end,w_start:w_end,:);
    end
end

end

