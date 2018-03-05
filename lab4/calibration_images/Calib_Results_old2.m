% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3798.098311356760860 ; 3786.693690785676608 ];

%-- Principal point:
cc = [ 1913.488151296766773 ; 1754.934129428947017 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.007647546743248 ; -0.084258120769100 ; -0.008261308104010 ; 0.006718521843578 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.848099535864239 ; 0.863627091301823 ];

%-- Principal point uncertainty:
cc_error = [ 1.017614247149184 ; 1.080052111392051 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.000735687229270 ; 0.002091955532739 ; 0.000089663279979 ; 0.000088589148573 ; 0.000000000000000 ];

%-- Image size:
nx = 3024;
ny = 4032;


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
omc_1 = [ 3.119301e+00 ; 1.459606e-03 ; 7.270474e-02 ];
Tc_1  = [ -1.369616e+02 ; 1.396366e+02 ; 3.328128e+02 ];
omc_error_1 = [ 4.167009e-04 ; 1.187055e-04 ; 7.171384e-04 ];
Tc_error_1  = [ 9.365959e-02 ; 9.897659e-02 ; 1.074163e-01 ];

%-- Image #2:
omc_2 = [ 2.984141e+00 ; 3.182572e-02 ; 8.573269e-01 ];
Tc_2  = [ -1.278163e+02 ; 1.447267e+02 ; 3.101714e+02 ];
omc_error_2 = [ 3.909327e-04 ; 1.549258e-04 ; 5.804256e-04 ];
Tc_error_2  = [ 9.296748e-02 ; 9.463498e-02 ; 1.071941e-01 ];

%-- Image #3:
omc_3 = [ 2.572459e+00 ; -3.453969e-02 ; 1.229645e-01 ];
Tc_3  = [ -1.245172e+02 ; 1.084833e+02 ; 2.751990e+02 ];
omc_error_3 = [ 3.414409e-04 ; 1.418598e-04 ; 4.682763e-04 ];
Tc_error_3  = [ 7.874841e-02 ; 8.656735e-02 ; 9.329501e-02 ];

%-- Image #4:
omc_4 = [ 2.713121e+00 ; -1.458662e-01 ; -7.959092e-01 ];
Tc_4  = [ -1.142870e+02 ; 1.563953e+02 ; 3.842805e+02 ];
omc_error_4 = [ 3.711282e-04 ; 1.713628e-04 ; 4.614559e-04 ];
Tc_error_4  = [ 1.064579e-01 ; 1.113617e-01 ; 1.077932e-01 ];

%-- Image #5:
omc_5 = [ -2.546247e+00 ; 7.723904e-02 ; 2.226244e-01 ];
Tc_5  = [ -1.020995e+02 ; 9.808278e+01 ; 4.561930e+02 ];
omc_error_5 = [ 3.521941e-04 ; 1.538893e-04 ; 4.826843e-04 ];
Tc_error_5  = [ 1.224932e-01 ; 1.324217e-01 ; 9.344917e-02 ];

%-- Image #6:
omc_6 = [ 2.638539e+00 ; 7.631949e-02 ; 1.457399e+00 ];
Tc_6  = [ -3.108453e+01 ; 1.358967e+02 ; 2.420853e+02 ];
omc_error_6 = [ 3.239613e-04 ; 2.419184e-04 ; 4.209950e-04 ];
Tc_error_6  = [ 7.083160e-02 ; 7.097084e-02 ; 8.811080e-02 ];

%-- Image #7:
omc_7 = [ -3.038050e+00 ; -4.303529e-02 ; 4.411244e-01 ];
Tc_7  = [ -1.570655e+02 ; 6.834232e+01 ; 5.516428e+02 ];
omc_error_7 = [ 5.586244e-04 ; 2.015569e-04 ; 8.218500e-04 ];
Tc_error_7  = [ 1.482599e-01 ; 1.610579e-01 ; 1.476817e-01 ];

%-- Image #8:
omc_8 = [ 2.439025e+00 ; -1.205455e+00 ; -8.569694e-01 ];
Tc_8  = [ 3.380089e+01 ; 1.143482e+02 ; 3.761278e+02 ];
omc_error_8 = [ 3.485735e-04 ; 1.929509e-04 ; 5.223445e-04 ];
Tc_error_8  = [ 1.029702e-01 ; 1.083467e-01 ; 1.074387e-01 ];

%-- Image #9:
omc_9 = [ 2.721356e+00 ; 6.305353e-02 ; 1.271395e+00 ];
Tc_9  = [ -5.169893e+01 ; 1.338231e+02 ; 2.395307e+02 ];
omc_error_9 = [ 3.245341e-04 ; 2.093786e-04 ; 4.328895e-04 ];
Tc_error_9  = [ 7.057406e-02 ; 7.114069e-02 ; 8.690884e-02 ];

%-- Image #10:
omc_10 = [ -2.527389e+00 ; -2.228628e-01 ; -4.017744e-01 ];
Tc_10  = [ -1.005543e+02 ; 1.091445e+02 ; 3.974781e+02 ];
omc_error_10 = [ 3.374193e-04 ; 1.705471e-04 ; 4.531977e-04 ];
Tc_error_10  = [ 1.077767e-01 ; 1.135368e-01 ; 9.635435e-02 ];

%-- Image #11:
omc_11 = [ -2.522764e+00 ; -1.069691e-01 ; -1.856168e-01 ];
Tc_11  = [ -7.869278e+01 ; 1.262594e+02 ; 4.402089e+02 ];
omc_error_11 = [ 3.411569e-04 ; 1.671329e-04 ; 4.715171e-04 ];
Tc_error_11  = [ 1.200873e-01 ; 1.254149e-01 ; 1.010064e-01 ];

%-- Image #12:
omc_12 = [ -2.949392e+00 ; 9.394529e-03 ; -8.453436e-01 ];
Tc_12  = [ -6.256796e+01 ; 1.096783e+02 ; 3.455874e+02 ];
omc_error_12 = [ 3.827100e-04 ; 1.830214e-04 ; 5.393069e-04 ];
Tc_error_12  = [ 9.570168e-02 ; 1.002182e-01 ; 1.044651e-01 ];

%-- Image #13:
omc_13 = [ 2.922304e+00 ; 1.940371e-02 ; 3.832587e-01 ];
Tc_13  = [ -1.061819e+02 ; 1.371755e+02 ; 3.077595e+02 ];
omc_error_13 = [ 4.048713e-04 ; 1.273368e-04 ; 6.336957e-04 ];
Tc_error_13  = [ 9.020484e-02 ; 9.454295e-02 ; 1.062426e-01 ];

%-- Image #14:
omc_14 = [ 2.798450e+00 ; -1.216731e-01 ; -5.749219e-01 ];
Tc_14  = [ -1.138953e+02 ; 1.400527e+02 ; 3.666212e+02 ];
omc_error_14 = [ 3.818768e-04 ; 1.490006e-04 ; 5.042595e-04 ];
Tc_error_14  = [ 1.005991e-01 ; 1.066455e-01 ; 1.042441e-01 ];

%-- Image #15:
omc_15 = [ 3.063928e+00 ; -3.850128e-02 ; 1.147334e-01 ];
Tc_15  = [ -1.248340e+02 ; 1.485465e+02 ; 3.526619e+02 ];
omc_error_15 = [ 4.632607e-04 ; 1.249765e-04 ; 8.042114e-04 ];
Tc_error_15  = [ 9.997885e-02 ; 1.051539e-01 ; 1.174976e-01 ];

%-- Image #16:
omc_16 = [ 2.822202e+00 ; -3.528787e-02 ; 7.961588e-02 ];
Tc_16  = [ -1.201366e+02 ; 1.191543e+02 ; 2.603833e+02 ];
omc_error_16 = [ 3.432740e-04 ; 1.119189e-04 ; 5.055607e-04 ];
Tc_error_16  = [ 7.494800e-02 ; 8.092400e-02 ; 8.593416e-02 ];

%-- Image #17:
omc_17 = [ -2.967465e+00 ; -7.912387e-02 ; -2.334174e-01 ];
Tc_17  = [ -1.354234e+02 ; 1.682775e+02 ; 3.670828e+02 ];
omc_error_17 = [ 4.164557e-04 ; 1.321675e-04 ; 6.722476e-04 ];
Tc_error_17  = [ 1.036720e-01 ; 1.075274e-01 ; 1.151575e-01 ];

%-- Image #18:
omc_18 = [ -2.860312e+00 ; -4.205310e-01 ; -4.841532e-01 ];
Tc_18  = [ -1.617802e+02 ; 1.243579e+02 ; 3.420011e+02 ];
omc_error_18 = [ 3.898738e-04 ; 1.499772e-04 ; 5.833628e-04 ];
Tc_error_18  = [ 9.642785e-02 ; 1.016664e-01 ; 1.080713e-01 ];

%-- Image #19:
omc_19 = [ 2.825113e+00 ; -8.301358e-01 ; 1.837945e-01 ];
Tc_19  = [ -5.193857e+01 ; 1.918813e+02 ; 3.687185e+02 ];
omc_error_19 = [ 5.167889e-04 ; 1.827906e-04 ; 8.423549e-04 ];
Tc_error_19  = [ 1.060275e-01 ; 1.126426e-01 ; 1.326560e-01 ];

%-- Image #20:
omc_20 = [ 2.172236e+00 ; -2.244824e+00 ; 2.468684e-02 ];
Tc_20  = [ 1.388295e+02 ; 6.977332e+01 ; 3.403587e+02 ];
omc_error_20 = [ 2.981155e-04 ; 3.436294e-04 ; 6.752214e-04 ];
Tc_error_20  = [ 9.290436e-02 ; 1.005852e-01 ; 1.082787e-01 ];

%-- Image #21:
omc_21 = [ -1.909977e+00 ; 2.027617e+00 ; 5.816741e-01 ];
Tc_21  = [ 1.275671e+02 ; 5.162865e+01 ; 3.755385e+02 ];
omc_error_21 = [ 2.524862e-04 ; 3.007258e-04 ; 5.284118e-04 ];
Tc_error_21  = [ 1.001757e-01 ; 1.083449e-01 ; 9.654329e-02 ];

%-- Image #22:
omc_22 = [ -1.982186e+00 ; 1.913449e+00 ; 7.503860e-01 ];
Tc_22  = [ 1.198628e+02 ; 1.068391e+02 ; 3.411644e+02 ];
omc_error_22 = [ 2.167331e-04 ; 2.889532e-04 ; 4.585055e-04 ];
Tc_error_22  = [ 9.205108e-02 ; 9.851949e-02 ; 8.955614e-02 ];

%-- Image #23:
omc_23 = [ 1.870811e+00 ; -1.812597e+00 ; 5.105162e-01 ];
Tc_23  = [ 1.187705e+02 ; 3.292927e+01 ; 2.509594e+02 ];
omc_error_23 = [ 2.280079e-04 ; 2.902899e-04 ; 4.008344e-04 ];
Tc_error_23  = [ 6.889439e-02 ; 7.523452e-02 ; 8.481881e-02 ];

