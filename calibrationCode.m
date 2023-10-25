
function [TBase, TEnd, cameraParams, TBaseStd, TEndStd, pixelErr]=calibrateKinova(poseNum, squareSize)

%% Initialize variables.
clc;
posesMat=zeros(4,4);
poseNum = 10;
squareSize = 17;
imageFolder = 'DomImages';

%% Open the text file.
for count=1:poseNum
    filename=sprintf('DomPose%1d.txt',count);
    fullName=sprintf('Poses/%s',filename);
    fileID = fopen(fullName,'r');
    list = load(fullName);
    posesMat(:,:,count)=list;
end

%% check inputs
%set optional inputs in default values
maxBaseOffset = 1;
maxEndOffset = 1;
inliers = 80;
errEst = true;
numBoot = 100;
cameraParams = [];
baseEst = eye(4);
endEst = eye(4);

%% Extract chessboards
%convert squareEst to metres
squareSize = squareSize / 1000;

%get images
imageFiles = dir(imageFolder);
imageFiles = {imageFiles(~[imageFiles.isdir]).name};
for i = 1:length(imageFiles)
    imageFiles{i} = [imageFolder filesep imageFiles{i}];
end

%find checkerboards
[points, boardSize, imagesUsed] = detectCheckerboardPoints(imageFiles);

%% Process arm poses
armPose = posesMat(:,:,imagesUsed);

%% Find camera parameters
%generate an ideal chessboard to compare points to
worldPoints = generateCheckerboardPoints(boardSize, 1);

%estimate camera parameters
if(isempty(cameraParams))
    cameraParams = estimateCameraParameters(points,squareSize*worldPoints,'WorldUnits','m','NumRadialDistortionCoefficients',3,'EstimateTangentialDistortion',true);
end
    
%% Optimize
%estimate for camera to arm base transform
baseEst = T2V(baseEst);
%size of range to search around above estimate for the true value
baseRange = [maxBaseOffset,maxBaseOffset,maxBaseOffset,pi,pi,pi];

%estimate for gripper to chessboard transofrm
endEst = T2V(endEst);
%size of range to search around above estimate for the true value
gripRange = [maxEndOffset,maxEndOffset,maxEndOffset,pi,pi,pi];

%size of range to search around above estimate for the true value
squareRange = 0.001;

%set up search range
inital = [baseEst,endEst,squareSize];
ub = [baseEst,endEst,squareSize] + [baseRange,gripRange,squareRange];
lb = [baseEst,endEst,squareSize] - [baseRange,gripRange,squareRange];

%set to intrior-point to allow for gradient free optimization
options = optimoptions(@fmincon,'Algorithm','interior-point','Display','off');

%function to optimize
optFunc = @(est) ProjectErrorEyeInHand(points, cameraParams, worldPoints, armPose, inliers, est);

%optimize
[solution,pixelErr] = fmincon(optFunc,inital,[],[],[],[],lb,ub,[],options);

%% Bootstrap
if(errEst)
    bootSol = zeros(numBoot,length(inital));
    
    fprintf('Calibrating       ');
    for idx = 1:numBoot
        %sample points
        sample = datasample(1:size(armPose,3),size(armPose,3));
        bootArmPose = armPose(:,:,sample);
        bootPoints = points(:,:,sample,:);

        %optimize
        bootSol(idx,:) = fmincon(optFunc,solution,[],[],[],[],lb,ub,[],options);
        bootSol = std(bootSol);
                    
        fprintf('\b\b\b\b\b\b\b %5.1f%%',100*idx/numBoot);
       
    end 
end

%% Convert format
%angle axis form
TBase = solution(1,1:6);
TBaseStd = bootSol(:,1:6);
TEnd = solution(1,7:12);
TEndStd = bootSol(:,7:12);

%convert to matrix
[ TBase, TBaseStd ] = ConvertTformSystem(TBase, TBaseStd);
[ TEnd, TEndStd ] = ConvertTformSystem(TEnd, TEndStd);
InvTB = inv(TBase);
InvTE = inv(TEnd);
%[TBase, InvTB, TEnd, InvTE, cameraParams, TBaseStd, TEndStd, pixelErr] = CalCamArmEIH(imageFolder, posesMat, squareSize,'maxBaseOffset',1);

fprintf('Final checkerboard to arm base transform is\n')
disp(TEnd);

fprintf('Final arm base to checkerboard transform is\n')
disp(InvTE);

fprintf('Final camera matrix is\n')
disp(cameraParams.IntrinsicMatrix);

fprintf('Final camera radial distortion parameters are\n')
disp(cameraParams.RadialDistortion);

fprintf('Final camera tangential distortion parameters are\n')
disp(cameraParams.TangentialDistortion);

end

