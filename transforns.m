clc
clf

dobot = DobotMagician();

%doms (tests 1&3) joint targets/angles
joint_targets1 = [
    [0.0, 0, 0, 0.0, 0];
    [0.0, 0.2, 0.4, 0.0, 0];
    [-0.2, 0.2, 0.4, 0.0, 0];
    [0.2, 0.2, 0.4, 0, 0];
    [0.28, 0.14, 0.4, 0.0, 0];
    [0.12, 0.1, -0.07, 0.0, 0];
    [0.0, 0.1, 0.24, 0.0, 0];
    [0.0, 0.05, -0.1, 0.0, 0];
    [0.1, 0.3, 0.3, 0.0, 0];
    [0.1, 0.1, 0.1, 0.0, 0]
];


%ryans (test 2) joint targets/angles 
joint_targets2 = [
    [0, 0, 0, 0, 0];
    [deg2rad(20), deg2rad(10), deg2rad(-5), 0, 0];
    [deg2rad(-20), deg2rad(20), deg2rad(10), 0, 0];
    [deg2rad(15), deg2rad(30), deg2rad(20), 0, 0];
    [deg2rad(-15), deg2rad(40), deg2rad(30), 0, 0];
    [deg2rad(10), deg2rad(50), deg2rad(40), 0, 0];
    [deg2rad(-10), deg2rad(60), deg2rad(50), 0, 0];
    [deg2rad(5), deg2rad(70), deg2rad(60), 0, 0];
    [deg2rad(-5), deg2rad(25), deg2rad(70), 0, 0];
    [deg2rad(2), deg2rad(15), deg2rad(75), 0, 0]
];

%creating arrays of different joint angles used for each point at which the
%camera took a photo

for i = 1:size(joint_targets1, 1)
    joint_target = joint_targets1(i, :);
    transformation_matrix = dobot.model.fkine(dobot.RealQToModelQ(joint_target));
    %converting the joint angles used in the real demo to the simulated
    %version to find the relative transformation matrix
    
    % Display or use the transformation_matrix as needed
    disp(['dom (tests 1&3) for joint target ', num2str(i), ':']);
    disp(transformation_matrix);
    %printing to the command window the resulting transformation matrices 
end

%the above block of code is repeated for ryans test as seen below: 

for i = 1:size(joint_targets2, 1)
    joint_target = joint_targets2(i, :);
    transformation_matrix = dobot.model.fkine(dobot.RealQToModelQ(joint_target));
    
    % Display or use the transformation_matrix as needed
    disp(['ryan (test2) for joint target ', num2str(i), ':']);
    disp(transformation_matrix);
end