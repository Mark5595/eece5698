% Magnetometer Correction: https://www.sensorsmag.com/components/compensating-for-tilt-hard-iron-and-soft-iron-effects
% 

function magnetometer_analysis()
    % Main file
    Points_car = '../data/magnetometer_calibration/imu_reading.csv';
    drive = '../data/drive/imu_reading.csv';
    
    %plot_file(Points_1500, '1500 points in place IMU');
    plot_file(Points_car, '2000 points in Car IMU');
    %plot_file(drive, '2000 points in Car IMU');
end



function plot_file(input_file, my_title)
    display(['Plotting ' my_title])
    % This function takes an input file name and plots the data
    raw_data = csvread(input_file);
    data = generate_data_cube(raw_data);
    %data = callibrate_data(data);
    
    %compare_yaw(data);
    %plot_distance(data);
    find_xc(data);
    

end

function find_xc(data)
% 𝑦̈𝑜𝑏𝑠 =𝑌+𝜔𝑋+𝜔̇𝑥𝑐
% (yobs - Y - wX)/delt_w
w = data.ypr.x;
delt_w = data.gyro.z;

delt_x = cumtrapz(data.accel.x);
delt_y = cumtrapz(data.accel.y);

xc = (data.accel.y - w.*delt_x)./delt_w;

xc2 = (data.accel.x + w.*delt_y)./(-(delt_w.^2));
hold on;
xc(1)
xc2(1)
plot(xc)
plot(xc2)
hold off;

end

function plot_distance(data)
    dt = 1/40;
    velocity = struct_integrate(data.accel, dt);
    velocity.name = 'Velocity';

    data.accel.name = 'Acceleration';

    figure;
    plot_config.title = 'Acceleration over time';
    plot_config.x_label = 'sample number';
    plot_config.y_label = 'm/sec';
    plot_helper(data.accel, plot_config);
    
    figure;
    plot_config.title = 'Velocity over time';
    plot_config.y_label = 'm/sec^2';
    plot_helper(velocity, plot_config);

    % Y Accel observed = Velocity X * ROC of yaw(z)
    y_accel_observed = (velocity.x .* data.gyro.z);
    y_accel_shift = (data.accel.y(1) - y_accel_observed(1));
    y_accel_scale = 2;
    y_accel_observed = y_accel_observed + y_accel_shift;
    y_accel_observed = y_accel_observed/y_accel_scale;

    figure;
    hold on;
    plot(y_accel_observed, '*', 'DisplayName', 'Calculated Y Accel');
    plot(data.accel.y, '*', 'DisplayName', 'Recorded Accel');
    hold off;
    legend('show');
    title('Recorded vs Calculated Acceleration')
    xlabel('Point Number');
    ylabel('Acceleration (m/s^2)');
    
    % 1. Start with x¨ which is the x - accelerometer output from the IMU
    accel_x = data.accel.x;
    
    % 2. Integrate it once to get dx - using cumtrapz
    % The result is the displacement at each point in time. 
    velocity_x  = cumtrapz(accel_x) * dt;

    figure;
    hold on;
    plot(velocity_x, 'DisplayName', 'velocity x')
    legend('show')
    hold off;
    

    % 4. Break up each displacement into x and y component based on heading.  
    % So rotate the displacement vector from purely x direction to x and y by 
    % applying the rotation through one of the angles found earlier.  (compass 
    % or gyro or both)
    vel.x =  velocity_x .* (sin(deg2rad(data.ypr.x)));
    vel.y =  velocity_x .* (cos(deg2rad(data.ypr.x)));
    pos.x = cumtrapz(vel.x) * dt;
    pos.y = cumtrapz(vel.y) * dt;
    
    % this is position
    figure;
    hold on;
    %plot(pos.magnitude, 'DisplayName', 'position vector')
    plot(pos.x, 'DisplayName', 'pos x')
    plot(pos.y, 'DisplayName', 'pos y')
    legend('show')
    hold off;
    title('X Y Component Position over time')
    xlabel('X (m)')
    ylabel('Y (m)')

    figure;
    plot(pos.x, pos.y)
    title('IMU Position over time')
    xlabel('X (m)')
    ylabel('Y (m)')


    % 5. This results in individual displacement vectors at each step, but we 
    % need the position at each step from the starting point, so use cumsum to 
    % add up all the tiny displacement vectors to get the cumulative displacements.

    % 6. The result is very sensitive to: pitch, starting heading, assumption 
    % of 0 starting velocity etc and correction from X_c
end

function compare_yaw(data)

    corrected.mag = plot_magnetometer_correction(data.mag);
    %low pass magnetometer after arctan
    yaw_mag = rad2deg((atan2(-corrected.mag.y,corrected.mag.x)));
    %yaw_mag = lowpass_filter(yaw_mag);

    %high pass the gyro before integration
    %filtered_gyro = highpass_filter(data.gyro);
    filtered_gyro = data.gyro;
    integrated_gyro = plot_integrals(filtered_gyro, 'Gyro');

    yaw_gyro = rad2deg(wrapToPi((integrated_gyro.z)));
    gyro_initial_offset = yaw_mag(1) - yaw_gyro(1);
    yaw_gyro = wrapTo180(yaw_gyro + gyro_initial_offset);

    imu_initial_offset = yaw_mag(1) - data.ypr.x(1);
    yaw_imu = wrapTo180(data.ypr.x + imu_initial_offset);
    yaw_comp = complementary_filter(yaw_mag, yaw_gyro, .90);
    
    figure;
    hold on;
    plot(yaw_imu, '*', 'DisplayName', 'IMU Yaw')
    plot(yaw_mag - 1, '*', 'DisplayName', 'Magnetometer Yaw')
    plot(yaw_gyro, '*', 'DisplayName', 'Integrated gyro')
    plot(yaw_comp, '*', 'DisplayName', 'Complementary Filter')
    legend('show')
    title('Yaw measurement comparisons')
    ylabel('Heading (degrees)')
    xlabel('Point Number')
    hold off;

end

function result = plot_integrals(gyro, name)
    order = 1;  % order = number of poles
    Fs = 40;    % sampled at 40Hz
    Fn = Fs/2;  % Nyquist frequency is 1/2 sampling frequency
    Fc = .00001;% for the integral
    Wn = Fc/Fn;
    [b, a] = butter(order, Wn);
    %fvtool(b, a, 'Fs', Fs)
    
    display(['Plotting integral of ' name]);
    
    integral.cumtrapz = struct_integrate(gyro, 1/(Fs));
    integral.cumtrapz.name = 'Cumtrapz';

    % TODO: Why does this need to be scaled like this?
    integral.filter.name = 'Filter';
    integral.filter.x = filter(b, a, gyro.x) .* 20^5/5 * (1/Fs);
    integral.filter.y = filter(b, a, gyro.y) .* 20^5/5 * (1/Fs);
    integral.filter.z = filter(b, a, gyro.z) .* 20^5/5 * (1/Fs);

    % Plot the Angular velocity first
    figure;
    gyro.name = 'Gyro';
    plot_config.title = 'Drift';
    plot_config.x_label = 'sample number';
    plot_config.y_label = 'radians/sec';
    plot_helper(gyro, plot_config)
    
    % Plot Integrals reprsenting change over time
    plot_config.y_label = 'radians moved';

    figure;
    plot_helper(integral.cumtrapz, plot_config)
    
    figure;
    plot_helper(integral.filter, plot_config)

    result = integral.cumtrapz;
end

function corrected = plot_magnetometer_correction(mag_data)

    function corrected = hard_iron_correction(mag)
        alpha = (max(mag.x) + min(mag.x))/2;
        beta = (max(mag.y) + min(mag.y))/2;
        gamma = 0; % ???

        corrected.x = mag.x - alpha;
        corrected.y = mag.y - beta;
        corrected.z = mag.z - gamma;
    end

    function corrected = soft_iron_correction(mag, r_max, r_min)
        %TODO: This needs to be fixed....
        ratio = r_min/r_max;

        r = sqrt(mag.x.^2 + mag.y.^2 + mag.z.^2); % Find the radius to every point
        
        [r_max, i_max] = max(r); % Long radius is maximum value and corresponding index 
        [r_min, i_min] = min(r); % Short radius is minimum value and corresponding index

        theta = asin(mag.y(i_max)/r_max); % This is the angle the elipse is rotated at

        R = [cos(theta) sin(theta); -sin(theta) cos(theta)];         % Rotation matrix
        R_rev = [cos(-theta) sin(-theta); -sin(-theta) cos(-theta)]; % Reverse Rotation matrix
        sigma = r_min/r_max;
        %TODO: This needs to be put back
        sigma = ratio;

        v = [mag.x, mag.y]';
       
        figure; 
        suptitle('Magnometer Soft Iron Corrections')
        subplot(2, 2, 1);
        plot(v(1,:), v(2, :), '*');

        % Rotate the values
        temp = R*v;
        subplot(2, 2, 2);
        plot(temp(1,:), temp(2, :), '*')

        % Scale the X
        temp = [temp(1, :)/sigma; temp(2, :)];
        subplot(2, 2, 3);
        plot(temp(1,:), temp(2, :), '*')
        
        % Reverse the rotation
        temp2 = R_rev * temp;
        subplot(2, 2, 4);
        plot(temp2(1,:), temp2(2, :), '*')

        corrected.x = temp2(1, :)';
        corrected.y = temp2(2, :)';
        corrected.z = mag.z;
    end

    % Generate a matrix from our data
    matrix = [mag_data.x(:), mag_data.y(:)];
    
    %[A, c] = MinVolEllipse(matrix', .01);
    %[U Q V] = svd(A);

    %r1 = 1/sqrt(Q(1,1))
    %r2 = 1/sqrt(Q(2,2))
    r1 = .0679;
    r2 = .0830;
    
    % Get some correction values
    hard_corrected_mag = hard_iron_correction(mag_data);
    hard_soft_corrected = soft_iron_correction(hard_corrected_mag, r1, r2);



    % Takes a struct representing magnetometer data (w/ x, y, z values) and plots
    % it
    figure;
    subplot(1, 2, 1);
    hold on;
    
    %Ellipse_plot(A,c);                                  % Minimum enclosing circle
    plot(mag_data.x, mag_data.y, '*', 'DisplayName', 'Raw'); % Raw Data
    plot(hard_corrected_mag.x, hard_corrected_mag.y, '*', ...
        'DisplayName', 'Hard Iron Corrected');   % Corrected for hard iron 
    plot(hard_soft_corrected.x, hard_soft_corrected.y, '*',...
        'DisplayName', 'Soft Iron Corrected'); % Corrected for hard iron 
    bestfit_circle(hard_corrected_mag)
    bestfit_circle(hard_soft_corrected)
    legend('show')
    %text(c(1), c(2), strcat('Center point: ', num2str(c(1)), ', ', num2str(c(2))))
    
    hold off;

    title('Magnometer Data on XY Plane')
    xlabel('X values (Gauss)')
    ylabel('Y values (Gauss)')
    grid on;
    
    subplot(1, 2, 2);
    plot3(mag_data.x, mag_data.y, mag_data.z)
    title('Magnometer Data on XYZ Plane')
    xlabel('X values (Gauss)')
    ylabel('Y values (Gauss)')
    zlabel('Z values (Gauss)')
    grid on;

    % Set correction return value
    corrected = hard_soft_corrected;
    %corrected = hard_corrected_mag;
end

function [r, c] = bestfit_circle(data)
    r = sqrt(data.x.^2 + data.y.^2); % Find the radius to every point
    r = max(r);
    x_center = (max(data.x) + min(data.x))/2;
    y_center = (max(data.y) + min(data.y))/2;
    c = [x_center, y_center];

    plot_circle(x_center, y_center, r);

end

function plot_circle(x, y, r)
    hold on;
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + mean(x);
    yunit = r * sin(th) + mean(y);
    h = plot(xunit, yunit);
    hold off;
end

function plot_helper(data, plot_config)
    function plot_subplot(id, axis)
        subplot(3, 1, id);
        
        switch axis
            case 'X'
                plot_data = data.x;
            case 'Y'
                plot_data = data.y;
            case 'Z'
                plot_data = data.z;
        end

        plot(plot_data, '*')
        title([data.name ' ' plot_config.title ' ' axis ' axis'])
        xlabel(plot_config.x_label)
        ylabel(plot_config.y_label)
    end

    plot_subplot(1, 'X')
    plot_subplot(2, 'Y')
    plot_subplot(3, 'Z')
end

function result = complementary_filter(x, y, x_weight)
    result = (x * x_weight) + (y * (1-x_weight));
end

function result = highpass_filter(data)
    order = 1;  % order = number of poles
    Fs = 40;    % sampled at 40Hz
    Fn = Fs/2;  % Nyquist frequency is 1/2 sampling frequency
    Fc2 = 1;   % cutoff frequency
    
    Wn2 = Fc2/Fn;

    [b, a] = butter(order, Wn2, 'high');

    if isstruct(data)
        result = struct_filter(data, b, a);
    else
        result = filter(b, a, data);
    end
end

function result = lowpass_filter(data)
    order = 1;  % order = number of poles
    Fs = 40;    % sampled at 40Hz
    Fn = Fs/2;  % Nyquist frequency is 1/2 sampling frequency
    Fc2 = 19;   % cutoff frequency
    
    Wn2 = Fc2/Fn;

    [b, a] = butter(order, Wn2, 'low');

    if isstruct(data)
        result = struct_filter(data, b, a);
    else
        result = filter(b, a, data);
    end
end

function corrected = callibrate_data(data)
    corrected.ypr.x = data.ypr.x - 0;
    corrected.ypr.y = data.ypr.y - 0;
    corrected.ypr.z = data.ypr.z - 0;
    
    corrected.mag.x = data.mag.x - 0;
    corrected.mag.y = data.mag.y - 0;
    corrected.mag.z = data.mag.z - 0;
    
    corrected.accel.x = data.accel.x - .38076;
    corrected.accel.y = data.accel.y - -.047313;
    corrected.accel.z = data.accel.z - -10.0008;
    
    corrected.gyro.x = data.gyro.x - -0.0;
    corrected.gyro.y = data.gyro.y - .0;
    corrected.gyro.z = data.gyro.z - .0;

    order = 1;  % order = number of poles
    Fs = 40;    % sampled at 40Hz
    Fn = Fs/2;  % Nyquist frequency is 1/2 sampling frequency
    Fc2 = 10;   % cutoff frequency
    
    Wn2 = Fc2/Fn;

    [b2, a2] = butter(order, Wn2);
    %corrected.gyro = struct_filter(corrected.gyro, b2, a2);

end

function result = shift(square, shift)
    result.x = square.x + shift;
    result.y = square.y + shift;
    result.z = square.z + shift;
end

function result = struct_flip(square)
    result.x = flip(square.x);
    result.y = flip(square.y);
    result.z = flip(square.z);
end

function result = struct_delay(square, delay)
    result.x = delayseq(square.x, delay);
    result.y = delayseq(square.y, delay);
    result.z = delayseq(square.z, delay);
end

function result = struct_integrate(data, dt)
    result.x = cumtrapz(data.x) * dt;
    result.y = cumtrapz(data.y) * dt;
    result.z = cumtrapz(data.z) * dt;
end

function result = struct_diff(data)
    result.x = diff(data.x);
    result.y = diff(data.y);
    result.z = diff(data.z);
end

function result = struct_unwrap(square)
    result.x = unwrap(square.x);
    result.y = unwrap(square.y);
    result.z = unwrap(square.z);
end

function result = struct_filter(square, b, a)
    result.x = filter(b, a, square.x);
    result.y = filter(b, a, square.y);
    result.z = filter(b, a, square.z);
end

function cube = generate_data_cube(raw_data)
    cube.ypr = extract_triplet(raw_data, 0);
    cube.mag = extract_triplet(raw_data, 1);
    cube.accel = extract_triplet(raw_data, 2);
    cube.gyro = extract_triplet(raw_data, 3);
end

function xyz = extract_triplet(data_square, offset)
    % Input: [timestamp yaw pitch roll mag_x mag_y mag_z 
    %         accel_x accel_y accel_z gyro_x gyro_y gyro_z]
    % Returns a struct with
    %   x: vector with x values
    %   y: vector with y values
    %   z: vector with z values
    % Offset of 0 returns [yaw pitch roll]
    
    data_matrix = data_square(:, (2 + (offset * 3)):(4 + (offset * 3)));

    xyz.x = data_matrix(:, 1);
    xyz.y = data_matrix(:, 2);
    xyz.z = data_matrix(:, 3);
end
