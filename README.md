# SCMS_Project4_Group2

Hand-Eye Coordination for the DoBot Robot
Project 4 | Group 2

Description of Project.
This project controls a DoBot to move to several positions and take images
of a pattern from different positions. These images are then calibrated to 
find the relative position of the camera to the end effector. 


How to Run the Project. 

1.  run file 'test_dobotandcam.m'

 
2.  run file 'dobotandcam_V1.m'


3.  run file 'transforns.m'
    To run this you will need the 'Peter Corkes Robotics toolbox' running.
    This file will take the poses from DoBot and transform them into the 
    required matrices. The output of this file is what can be seen in our
    'Poses' file. 


3.  run file 'calibrationCode.m'
    The output of this file will provide the relative camera position. 
    This file is currently set up to run the poses and images from Dom's 
    trial run, collected from one of the project demos. This will need to 
    be edited in line 9 and 13 to cater to other projects.


Explanation of Files. 

DomImages - this folder contains collected images from DoBot tests taken 
with the poses from 'DomPose'.
RyanImages - this folder contains collected images from DoBot tests taken 
with the poses from 'RyanPose'.
Functions - contains several functions that are called upon in the 
'calibrationCode.m' file, that makes the code more clear and concise. 
Poses - this folder contains the transformation matrix from the relative 
porject poses. 
letsTest - with this file you can run a simulation of the project. 
calibrationCode - as outlined above. 
dobotandcam_V1 - as outlined above.
test_dobotandcam - as outlined above. 
transforns - as outlined above.


Project Contribution.

calibrationCode.m - Ruby
Functions - Ruby
Poses - Ruby
transforns - Dom
dobotandcam_V1 - Ryan, Dom
test_dobotandcam - Ryan, Dom
