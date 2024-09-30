function [ files ] = getFilesFromFolder( folder, ext )
    if nargin==1
        ext = '';
    else
        ext = ['*.' ext]
    end    
    files = {};
    listing = dir([folder ext]);
    n = size(listing,1);
    for i=1:n
        mydir = listing(i);
        if mydir.isdir==0
            file = {mydir.name};
            files = [files; file];
        end
    end

end

