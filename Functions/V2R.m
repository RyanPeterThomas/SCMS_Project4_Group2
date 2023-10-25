
function [ R ] = V2R( V )
% converts a 1x3 angle-axis vector into a 3x3 rotation matrix 

validateattributes(V, {'numeric'},{'size',[1,3]});
V = double(V(:));
s = norm(V);

if(s == 0)
    R = eye(3);
    return;
end

V = [V/s; s];
R = vrrotvec2mat(V);

end