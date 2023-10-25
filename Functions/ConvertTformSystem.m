
function [ tform, tformStd ] = ConvertTformSystem( aaVec, aaStd )

% converts from angle axis form to tform matrix

validateattributes(aaVec, {'numeric'},{'size',[1,6]});
validateattributes(aaStd, {'numeric'},{'size',[1,6]});
aaVec = double(aaVec);
aaStd = double(aaStd);

% transformation matrix form
tform = V2T(aaVec);
tformStd = zeros(4,4,1000);

for idx = 1:size(tformStd,3)
    tformStd(:,:,idx) = V2T(aaVec + aaStd.*randn(1,6));
end

tformStd = std(tformStd,0,3);
end