
function [ T ] = V2T( V )
% converts 1x6 vector into 4x4 transformation matrix

validateattributes(V, {'numeric'},{'size',[1,6]});
V = double(V);

T = eye(4);
T(1:3,4) = V(1:3);
T(1:3,1:3) = V2R(V(4:6));

end