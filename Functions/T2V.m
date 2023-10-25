
function [ V ] = T2V( T )
% converts 4x4 transformation matrix into a 1x6 vector

validateattributes(T, {'numeric'},{'size',[4,4]});

T = double(T);

V(1:3) = T(1:3,4);
V(4:6) = R2V(T(1:3,1:3));

end