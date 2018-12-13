% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3424.946567096487797 ; 3445.365904066374242 ];

%-- Principal point:
cc = [ 2001.637798882835114 ; 1493.656702306299394 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.109728614644910 ; -0.213869464624546 ; -0.001120966651929 ; -0.001157759705361 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 6.106210544140553 ; 6.454706031680990 ];

%-- Principal point uncertainty:
cc_error = [ 6.738431703821944 ; 5.631607008997173 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.006206696060540 ; 0.018635777285366 ; 0.000636876753405 ; 0.000753837439981 ; 0.000000000000000 ];

%-- Image size:
nx = 4032;
ny = 3024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 23;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.209704e+00 ; 2.211394e+00 ; -4.036608e-02 ];
Tc_1  = [ -1.345432e+02 ; -9.371476e+01 ; 3.157676e+02 ];
omc_error_1 = [ 2.029950e-03 ; 2.080827e-03 ; 4.354651e-03 ];
Tc_error_1  = [ 6.345760e-01 ; 5.345774e-01 ; 7.298317e-01 ];

%-- Image #2:
omc_2 = [ 1.951242e+00 ; 1.965754e+00 ; -4.583019e-01 ];
Tc_2  = [ -1.274410e+02 ; -8.239403e+01 ; 3.787639e+02 ];
omc_error_2 = [ 1.743187e-03 ; 2.024033e-03 ; 3.576899e-03 ];
Tc_error_2  = [ 7.428348e-01 ; 6.287751e-01 ; 7.403308e-01 ];

%-- Image #3:
omc_3 = [ -1.949167e+00 ; -1.952668e+00 ; 5.164682e-01 ];
Tc_3  = [ -1.311442e+02 ; -9.940066e+01 ; 3.840576e+02 ];
omc_error_3 = [ 1.873778e-03 ; 1.691233e-03 ; 3.267028e-03 ];
Tc_error_3  = [ 7.608978e-01 ; 6.335558e-01 ; 7.117359e-01 ];

%-- Image #4:
omc_4 = [ -1.812901e+00 ; -1.681597e+00 ; -3.464617e-01 ];
Tc_4  = [ -1.410851e+02 ; -8.411120e+01 ; 3.230283e+02 ];
omc_error_4 = [ 1.650678e-03 ; 1.962135e-03 ; 2.870707e-03 ];
Tc_error_4  = [ 6.443579e-01 ; 5.535369e-01 ; 7.224740e-01 ];

%-- Image #5:
omc_5 = [ -1.924769e+00 ; -1.815449e+00 ; -3.578543e-01 ];
Tc_5  = [ -1.353690e+02 ; -8.969768e+01 ; 2.905503e+02 ];
omc_error_5 = [ 1.810867e-03 ; 1.839639e-03 ; 3.132608e-03 ];
Tc_error_5  = [ 5.840008e-01 ; 5.076827e-01 ; 7.016050e-01 ];

%-- Image #6:
omc_6 = [ 1.683904e+00 ; 1.727082e+00 ; -8.929576e-01 ];
Tc_6  = [ -1.209106e+02 ; -1.133968e+02 ; 3.983902e+02 ];
omc_error_6 = [ 1.463754e-03 ; 1.964742e-03 ; 2.600105e-03 ];
Tc_error_6  = [ 7.964187e-01 ; 6.682687e-01 ; 6.541054e-01 ];

%-- Image #7:
omc_7 = [ -2.034398e+00 ; -2.071952e+00 ; 2.582938e-01 ];
Tc_7  = [ -1.650694e+02 ; -1.466175e+02 ; 4.897188e+02 ];
omc_error_7 = [ 2.888837e-03 ; 2.321609e-03 ; 5.000434e-03 ];
Tc_error_7  = [ 9.842227e-01 ; 8.189767e-01 ; 1.069769e+00 ];

%-- Image #8:
omc_8 = [ -2.699051e+00 ; -8.805785e-01 ; 9.118890e-01 ];
Tc_8  = [ -1.358321e+02 ; -6.753323e+00 ; 4.616320e+02 ];
omc_error_8 = [ 2.524400e-03 ; 1.262746e-03 ; 3.453973e-03 ];
Tc_error_8  = [ 9.166481e-01 ; 7.565509e-01 ; 7.545913e-01 ];

%-- Image #9:
omc_9 = [ 1.774497e+00 ; 1.814374e+00 ; -8.095686e-01 ];
Tc_9  = [ -1.232237e+02 ; -1.111939e+02 ; 3.821353e+02 ];
omc_error_9 = [ 1.398855e-03 ; 1.925016e-03 ; 2.779730e-03 ];
Tc_error_9  = [ 7.618400e-01 ; 6.390573e-01 ; 6.525859e-01 ];

%-- Image #10:
omc_10 = [ 1.809472e+00 ; 2.201424e+00 ; -8.864791e-01 ];
Tc_10  = [ -7.072463e+01 ; -1.486751e+02 ; 4.251779e+02 ];
omc_error_10 = [ 1.298106e-03 ; 2.103096e-03 ; 3.384421e-03 ];
Tc_error_10  = [ 8.520505e-01 ; 7.050260e-01 ; 6.955395e-01 ];

%-- Image #11:
omc_11 = [ 1.850331e+00 ; 2.046731e+00 ; -7.317769e-01 ];
Tc_11  = [ -1.007614e+02 ; -1.593262e+02 ; 4.323571e+02 ];
omc_error_11 = [ 1.396490e-03 ; 2.071771e-03 ; 3.361832e-03 ];
Tc_error_11  = [ 8.728140e-01 ; 7.230501e-01 ; 7.496491e-01 ];

%-- Image #12:
omc_12 = [ -1.912184e+00 ; -1.932685e+00 ; 5.994618e-01 ];
Tc_12  = [ -9.140471e+01 ; -1.291185e+02 ; 4.143529e+02 ];
omc_error_12 = [ 2.062427e-03 ; 1.755133e-03 ; 3.341439e-03 ];
Tc_error_12  = [ 8.263601e-01 ; 6.758797e-01 ; 7.723427e-01 ];

%-- Image #13:
omc_13 = [ 2.159473e+00 ; 2.194418e+00 ; -3.874413e-01 ];
Tc_13  = [ -1.275265e+02 ; -1.190696e+02 ; 3.637538e+02 ];
omc_error_13 = [ 1.803495e-03 ; 2.114957e-03 ; 4.145450e-03 ];
Tc_error_13  = [ 7.250494e-01 ; 6.005381e-01 ; 7.568127e-01 ];

%-- Image #14:
omc_14 = [ -1.917458e+00 ; -1.807888e+00 ; -2.222985e-01 ];
Tc_14  = [ -1.509746e+02 ; -9.635363e+01 ; 3.250398e+02 ];
omc_error_14 = [ 1.808988e-03 ; 1.953130e-03 ; 3.233221e-03 ];
Tc_error_14  = [ 6.506239e-01 ; 5.610017e-01 ; 7.386779e-01 ];

%-- Image #15:
omc_15 = [ 2.243867e+00 ; 2.191434e+00 ; -1.214722e-01 ];
Tc_15  = [ -1.314987e+02 ; -1.015745e+02 ; 3.498726e+02 ];
omc_error_15 = [ 2.221672e-03 ; 2.270154e-03 ; 4.802641e-03 ];
Tc_error_15  = [ 6.991131e-01 ; 5.846246e-01 ; 7.934203e-01 ];

%-- Image #16:
omc_16 = [ -2.088423e+00 ; -2.071844e+00 ; 2.915966e-01 ];
Tc_16  = [ -1.442034e+02 ; -1.010250e+02 ; 3.135665e+02 ];
omc_error_16 = [ 1.818759e-03 ; 1.640267e-03 ; 3.437652e-03 ];
Tc_error_16  = [ 6.260036e-01 ; 5.262724e-01 ; 6.723000e-01 ];

%-- Image #17:
omc_17 = [ 2.031753e+00 ; 2.111571e+00 ; 8.838703e-02 ];
Tc_17  = [ -9.625520e+01 ; -1.096619e+02 ; 3.207827e+02 ];
omc_error_17 = [ 2.019483e-03 ; 2.102866e-03 ; 4.046760e-03 ];
Tc_error_17  = [ 6.497035e-01 ; 5.341709e-01 ; 7.528811e-01 ];

%-- Image #18:
omc_18 = [ 1.684587e+00 ; 2.214669e+00 ; -2.239225e-02 ];
Tc_18  = [ -8.853289e+01 ; -1.298161e+02 ; 3.310965e+02 ];
omc_error_18 = [ 1.639940e-03 ; 2.224640e-03 ; 3.493142e-03 ];
Tc_error_18  = [ 6.629005e-01 ; 5.474840e-01 ; 7.232371e-01 ];

%-- Image #19:
omc_19 = [ -2.690906e+00 ; -1.486343e+00 ; 2.516024e-01 ];
Tc_19  = [ -1.461992e+02 ; -1.774987e+01 ; 3.967129e+02 ];
omc_error_19 = [ 2.841274e-03 ; 1.758618e-03 ; 5.546346e-03 ];
Tc_error_19  = [ 7.818549e-01 ; 6.557282e-01 ; 8.692464e-01 ];

%-- Image #20:
omc_20 = [ -2.253675e+00 ; -2.179333e+00 ; 4.988693e-02 ];
Tc_20  = [ -1.274221e+02 ; -9.416657e+01 ; 3.179213e+02 ];
omc_error_20 = [ 2.077653e-03 ; 2.014327e-03 ; 4.409763e-03 ];
Tc_error_20  = [ 6.390262e-01 ; 5.355670e-01 ; 7.287490e-01 ];

%-- Image #21:
omc_21 = [ -2.008703e+00 ; -1.892644e+00 ; -3.695628e-01 ];
Tc_21  = [ -1.448116e+02 ; -8.963384e+01 ; 2.774353e+02 ];
omc_error_21 = [ 1.733703e-03 ; 1.888932e-03 ; 3.330137e-03 ];
Tc_error_21  = [ 5.660168e-01 ; 4.915801e-01 ; 6.786880e-01 ];

%-- Image #22:
omc_22 = [ -1.836936e+00 ; -1.899251e+00 ; -3.541925e-01 ];
Tc_22  = [ -1.376397e+02 ; -5.838162e+01 ; 2.476384e+02 ];
omc_error_22 = [ 1.376074e-03 ; 1.919603e-03 ; 2.817017e-03 ];
Tc_error_22  = [ 4.927051e-01 ; 4.311686e-01 ; 5.926283e-01 ];

%-- Image #23:
omc_23 = [ 1.850718e+00 ; 1.891502e+00 ; -7.086316e-01 ];
Tc_23  = [ -1.298256e+02 ; -1.043268e+02 ; 3.621961e+02 ];
omc_error_23 = [ 1.356120e-03 ; 1.890281e-03 ; 2.935680e-03 ];
Tc_error_23  = [ 7.183366e-01 ; 6.059508e-01 ; 6.520063e-01 ];

