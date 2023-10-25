clf 
clc 

dobot = DobotMagician()
hold on;
checker = PlaceObject('checker.ply',[0.6,0,0.25]);
hold on; 
axis equal
%loading in the dobot and the checkerboard files 

q = cell(1, 5); % creating an empty array for 'q' to be filled later 

q{1} = [0,0,0,0,0]; %setting initial joint angles
q{2} = [deg2rad(0),deg2rad(30.1),deg2rad(15.1),deg2rad(45.7),deg2rad(0)];
q{2} = [deg2rad(0),deg2rad(30.1),deg2rad(15.1),deg2rad(45.7),deg2rad(0)];
q{3} = [deg2rad(-22.6),deg2rad(42.7),deg2rad(17.8),deg2rad(49.3),deg2rad(0)];
q{4} = [deg2rad(-4.8),deg2rad(22.5),deg2rad(24.2),deg2rad(62.1),deg2rad(20.3)];
q{5} = [deg2rad(0.685),deg2rad(68.2),deg2rad(24.2),deg2rad(-8.22),deg2rad(0)];
q{6} = [deg2rad(-6.85),deg2rad(61.9),deg2rad(25.2),deg2rad(3.65),deg2rad(0)];
q{7} = [deg2rad(13.7),deg2rad(42.7),deg2rad(17.8),deg2rad(52.1),deg2rad(-1.29)];
q{8} = [deg2rad(13.7),deg2rad(17),deg2rad(25.8),deg2rad(62.1),deg2rad(-28.5)];
q{9} = [deg2rad(-6.85),deg2rad(80),deg2rad(25.2),deg2rad(-21.9),deg2rad(3.88)];
q{10} = [deg2rad(8.91),deg2rad(80),deg2rad(25.2),deg2rad(-21.9),deg2rad(3.88)];
%describing each of the joint angles to be cycles through

% dobot.model.fkine(dobot.RealQToModelQ(q{1})) used to find the transform
% matrix of any joint angle configuration

for i = 2:1:10
    pause(2);

    qMatrix{i} = jtraj(q{i-1},q{i},50);
    %this for loop creates the trajectories between each movement 

    for j = 1:1:50

        dobot.model.animate(qMatrix{i}(j,:));
        %animating the trajectory in 50 steps 

        drawnow()
        %short pause to allow the animation to show
    end
end




%--------------------------------------------------------------------------
%INBUILT FUNCTIONS WITH THE UTS MODEL VERSION OF DOBOT

%dobot.TestMoveJoints(); 

% dobot.RealQToModelQ(); %Converts a set of real joint angles (realQ) to
% % model joint angles (modelQ) based on the robot's kinematic model.
% 
% dobot.ModelQToRealQ(); %Converts a set of model joint angles (modelQ) to 
% % real joint angles (realQ) considering the robot's kinematic model.



%--------------------------------------------------------------------------







