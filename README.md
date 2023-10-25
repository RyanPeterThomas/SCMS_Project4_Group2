# SCMS_Project4_Group2

# Hand-Eye Coordination for the DoBot Robot

## Description:

This project code controls a DoBot to move to several poses and take images
of a pattern from different positions. These images are then calibrated to 
find the relative position of the camera to the DoBot's end-effector.


## How to Run the Project Code:

1.  run file 'test_dobotandcam.m' or file 'dobotandcam_V1.m'

    These files initialise the DoBot in ROS and start video capture from the webcam.
    It moves the DoBot into varying positions via a joint angle input and captures greyscale images at each pose.
    The files output a directory folder with each captured image for its adjacent position.
    Each file includes differing poses and image capture positions.
    Run both to produce a more precise result.


2.  run file 'transforns.m'

    To run this you will need the 'Peter Corkes Robotics toolbox' running.
    This file will take the poses from DoBot and transform them into the 
    required matrices. The output of this file is what can be seen in our
    'Poses' file. 


3.  run file 'calibrationCode.m'
 
    The output of this file will provide the relative camera position. 
    This file is currently set up to run the poses and images from Dom's 
    trial run, collected from one of the project demos. This will need to 
    be edited in line 9 and 13 to cater to other projects.


## Explanation of Files:

DomImages - this folder contains collected images from DoBot tests taken 
with the poses from 'DomPose'.

RyanImages - this folder contains collected images from DoBot tests taken 
with the poses from 'RyanPose'.

Functions - contains several functions that are called upon in the 
'calibrationCode.m' file, which makes the code more clear and concise.

Poses - this folder contains the transformation matrix from the relative 
project poses.

letsTest - with this file you can run a simulation of the project.

calibrationCode - as outlined above.

dobotandcam_V1 - as outlined above.

test_dobotandcam - as outlined above.

transforns - as outlined above.


## Individual Contribution:

Domenic Kadioglu (24426924) - 33%

Ruby Laidlaw (14264903) - 33%

Ryan Thomas (13938802) - 33%


## References:

This code in heavily inspired by [ZacharyTaylor'swork](https://github.com/ZacharyTaylor/Camera-to-Arm-Calibration) in which he calibrates via a static camera facing toward the DoBot with a pattern attached to its end-effector.
