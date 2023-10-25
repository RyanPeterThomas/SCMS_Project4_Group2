
function [ V ] = R2V( R )
% converts 3x3 rotation matrix into a 1x3 angle-axis vector

validateattributes(R, {'numeric'},{'size',[3,3]});

R = vrrotmat2vec(double(R));
V = R(1:3)*R(4);
V = V';

end