% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3423.622440775594441 ; 3444.378853994557176 ];

%-- Principal point:
cc = [ 2002.358093618288649 ; 1493.031240831381183 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.112443890084558 ; -0.222627992891587 ; -0.001286358564808 ; -0.000883214963071 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.988184000728830 ; 6.332263978015384 ];

%-- Principal point uncertainty:
cc_error = [ 6.582627584379281 ; 5.506827561207566 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.006088636299845 ; 0.018268845697773 ; 0.000623244966428 ; 0.000735165269138 ; 0.000000000000000 ];

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
omc_1 = [ 2.209151e+00 ; 2.210827e+00 ; -4.000561e-02 ];
Tc_1  = [ -1.346161e+02 ; -9.365382e+01 ; 3.156531e+02 ];
omc_error_1 = [ 1.990618e-03 ; 2.041058e-03 ; 4.268547e-03 ];
Tc_error_1  = [ 6.198247e-01 ; 5.226866e-01 ; 7.157159e-01 ];

%-- Image #2:
omc_2 = [ 1.950950e+00 ; 1.965343e+00 ; -4.581384e-01 ];
Tc_2  = [ -1.275368e+02 ; -8.232170e+01 ; 3.786651e+02 ];
omc_error_2 = [ 1.708276e-03 ; 1.981727e-03 ; 3.502470e-03 ];
Tc_error_2  = [ 7.255273e-01 ; 6.149593e-01 ; 7.257848e-01 ];

%-- Image #3:
omc_3 = [ -1.949610e+00 ; -1.953020e+00 ; 5.163122e-01 ];
Tc_3  = [ -1.312516e+02 ; -9.932384e+01 ; 3.839924e+02 ];
omc_error_3 = [ 1.834743e-03 ; 1.657097e-03 ; 3.201157e-03 ];
Tc_error_3  = [ 7.431387e-01 ; 6.195762e-01 ; 6.977483e-01 ];

%-- Image #4:
omc_4 = [ -1.813212e+00 ; -1.681839e+00 ; -3.467458e-01 ];
Tc_4  = [ -1.411651e+02 ; -8.403283e+01 ; 3.229130e+02 ];
omc_error_4 = [ 1.618413e-03 ; 1.921450e-03 ; 2.810984e-03 ];
Tc_error_4  = [ 6.292896e-01 ; 5.413204e-01 ; 7.082662e-01 ];

%-- Image #5:
omc_5 = [ -2.612502e+00 ; 7.631354e-02 ; 1.976152e-01 ];
Tc_5  = [ -1.123315e+02 ; 1.286021e+02 ; 4.143163e+02 ];
omc_error_5 = [ 2.110011e-03 ; 1.059418e-03 ; 3.303934e-03 ];
Tc_error_5  = [ 8.052126e-01 ; 6.710128e-01 ; 6.830528e-01 ];

%-- Image #6:
omc_6 = [ 1.683475e+00 ; 1.726242e+00 ; -8.928466e-01 ];
Tc_6  = [ -1.210205e+02 ; -1.132352e+02 ; 3.982465e+02 ];
omc_error_6 = [ 1.432781e-03 ; 1.920548e-03 ; 2.541647e-03 ];
Tc_error_6  = [ 7.776520e-01 ; 6.534152e-01 ; 6.409090e-01 ];

%-- Image #7:
omc_7 = [ -3.074559e+00 ; -2.823080e-02 ; 4.402852e-01 ];
Tc_7  = [ -1.684568e+02 ; 1.052647e+02 ; 4.989884e+02 ];
omc_error_7 = [ 3.275453e-03 ; 1.362411e-03 ; 5.388606e-03 ];
Tc_error_7  = [ 9.693418e-01 ; 8.160932e-01 ; 1.027523e+00 ];

%-- Image #8:
omc_8 = [ 2.418693e+00 ; -1.228804e+00 ; -7.766781e-01 ];
Tc_8  = [ 2.558708e+01 ; 1.394233e+02 ; 3.347985e+02 ];
omc_error_8 = [ 2.245152e-03 ; 1.281719e-03 ; 3.394988e-03 ];
Tc_error_8  = [ 6.656701e-01 ; 5.428901e-01 ; 7.064097e-01 ];

%-- Image #9:
omc_9 = [ 1.774319e+00 ; 1.814005e+00 ; -8.093821e-01 ];
Tc_9  = [ -1.233253e+02 ; -1.111167e+02 ; 3.820595e+02 ];
omc_error_9 = [ 1.369588e-03 ; 1.882244e-03 ; 2.718525e-03 ];
Tc_error_9  = [ 7.440459e-01 ; 6.249953e-01 ; 6.395893e-01 ];

%-- Image #10:
omc_10 = [ 2.559460e+00 ; 2.500046e-01 ; -4.151778e-01 ];
Tc_10  = [ -1.355500e+02 ; 6.367565e+01 ; 3.057147e+02 ];
omc_error_10 = [ 2.054701e-03 ; 1.154956e-03 ; 3.009599e-03 ];
Tc_error_10  = [ 5.913418e-01 ; 5.083185e-01 ; 6.617149e-01 ];

%-- Image #11:
omc_11 = [ 2.560697e+00 ; 1.289621e-01 ; -2.096075e-01 ];
Tc_11  = [ -1.350823e+02 ; 5.187776e+01 ; 2.990327e+02 ];
omc_error_11 = [ 2.066230e-03 ; 1.169579e-03 ; 3.117717e-03 ];
Tc_error_11  = [ 5.788314e-01 ; 5.030009e-01 ; 6.864996e-01 ];

%-- Image #12:
omc_12 = [ 2.973571e+00 ; 1.589027e-02 ; -8.512422e-01 ];
Tc_12  = [ -9.737035e+01 ; 1.226542e+02 ; 4.032857e+02 ];
omc_error_12 = [ 2.402517e-03 ; 1.129787e-03 ; 3.704354e-03 ];
Tc_error_12  = [ 7.844740e-01 ; 6.444974e-01 ; 7.381672e-01 ];

%-- Image #13:
omc_13 = [ 2.159063e+00 ; 2.193882e+00 ; -3.870975e-01 ];
Tc_13  = [ -1.276224e+02 ; -1.189961e+02 ; 3.636721e+02 ];
omc_error_13 = [ 1.768735e-03 ; 2.072426e-03 ; 4.060174e-03 ];
Tc_error_13  = [ 7.081013e-01 ; 5.872711e-01 ; 7.419836e-01 ];

%-- Image #14:
omc_14 = [ -1.917546e+00 ; -1.807977e+00 ; -2.227131e-01 ];
Tc_14  = [ -1.510519e+02 ; -9.627346e+01 ; 3.248627e+02 ];
omc_error_14 = [ 1.773728e-03 ; 1.913414e-03 ; 3.166529e-03 ];
Tc_error_14  = [ 6.352869e-01 ; 5.484699e-01 ; 7.240271e-01 ];

%-- Image #15:
omc_15 = [ 2.243349e+00 ; 2.190889e+00 ; -1.211154e-01 ];
Tc_15  = [ -1.315819e+02 ; -1.015062e+02 ; 3.497701e+02 ];
omc_error_15 = [ 2.178354e-03 ; 2.225922e-03 ; 4.706530e-03 ];
Tc_error_15  = [ 6.828542e-01 ; 5.716430e-01 ; 7.779906e-01 ];

%-- Image #16:
omc_16 = [ -2.088836e+00 ; -2.072271e+00 ; 2.911728e-01 ];
Tc_16  = [ -1.442843e+02 ; -1.009657e+02 ; 3.134400e+02 ];
omc_error_16 = [ 1.783660e-03 ; 1.609202e-03 ; 3.372013e-03 ];
Tc_error_16  = [ 6.113781e-01 ; 5.145928e-01 ; 6.591464e-01 ];

%-- Image #17:
omc_17 = [ 2.031334e+00 ; 2.111151e+00 ; 8.847544e-02 ];
Tc_17  = [ -9.632793e+01 ; -1.096012e+02 ; 3.207138e+02 ];
omc_error_17 = [ 1.977016e-03 ; 2.059338e-03 ; 3.963954e-03 ];
Tc_error_17  = [ 6.347279e-01 ; 5.223533e-01 ; 7.382634e-01 ];

%-- Image #18:
omc_18 = [ 1.684324e+00 ; 2.214288e+00 ; -2.240220e-02 ];
Tc_18  = [ -8.861490e+01 ; -1.297505e+02 ; 3.310334e+02 ];
omc_error_18 = [ 1.605351e-03 ; 2.177349e-03 ; 3.421279e-03 ];
Tc_error_18  = [ 6.475996e-01 ; 5.353456e-01 ; 7.091409e-01 ];

%-- Image #19:
omc_19 = [ -2.691177e+00 ; -1.486649e+00 ; 2.481041e-01 ];
Tc_19  = [ -1.463341e+02 ; -1.771886e+01 ; 3.964407e+02 ];
omc_error_19 = [ 2.789234e-03 ; 1.728557e-03 ; 5.446280e-03 ];
Tc_error_19  = [ 7.633140e-01 ; 6.410171e-01 ; 8.531702e-01 ];

%-- Image #20:
omc_20 = [ -2.254211e+00 ; -2.179847e+00 ; 4.956415e-02 ];
Tc_20  = [ -1.274959e+02 ; -9.410497e+01 ; 3.178206e+02 ];
omc_error_20 = [ 2.037481e-03 ; 1.975029e-03 ; 4.324723e-03 ];
Tc_error_20  = [ 6.241737e-01 ; 5.236643e-01 ; 7.146799e-01 ];

%-- Image #21:
omc_21 = [ -2.009302e+00 ; -1.892995e+00 ; -3.695457e-01 ];
Tc_21  = [ -1.448792e+02 ; -8.957236e+01 ; 2.773998e+02 ];
omc_error_21 = [ 1.701576e-03 ; 1.851157e-03 ; 3.264362e-03 ];
Tc_error_21  = [ 5.529504e-01 ; 4.808144e-01 ; 6.655726e-01 ];

%-- Image #22:
omc_22 = [ -1.837420e+00 ; -1.899547e+00 ; -3.545021e-01 ];
Tc_22  = [ -1.377115e+02 ; -5.831818e+01 ; 2.475284e+02 ];
omc_error_22 = [ 1.349612e-03 ; 1.880070e-03 ; 2.760406e-03 ];
Tc_error_22  = [ 4.811780e-01 ; 4.215981e-01 ; 5.810567e-01 ];

%-- Image #23:
omc_23 = [ 1.850477e+00 ; 1.891176e+00 ; -7.084004e-01 ];
Tc_23  = [ -1.299148e+02 ; -1.042697e+02 ; 3.621493e+02 ];
omc_error_23 = [ 1.328359e-03 ; 1.849142e-03 ; 2.872023e-03 ];
Tc_error_23  = [ 7.016475e-01 ; 5.927254e-01 ; 6.390967e-01 ];

