
function gps_vs_imu()
    % Main file
    driveGps = '../data/drive/gps_location.csv';
    driveImu = '../data/drive/imu_reading.csv';
    %driveGps = '../data/magnetometer_calibration/gps_location.csv';
    %driveImu = '../data/magnetometer_calibration/imu_reading.csv';

    figure;
    hold all;
    v_gps = plot_gps(driveGps);
    v_imu = plot_imu(driveImu);
    hold off;
    title('GPS vs IMU Dead Reckoning');
    xlabel('X (M)');
    ylabel('Y (M)');
    legend('show');

    vel_comparision(v_gps, v_imu);

end

function vel_comparision(v_gps, v_imu)
    scale = 1/45;
    v_imu.x = decimate(v_imu.x, 40);
    v_imu.y = decimate(v_imu.y, 40);

    figure;
    subplot(3, 1, 1);
    hold on;
    plot(v_gps.x, 'DisplayName', 'GPS X');
    plot(v_imu.x*scale, 'DisplayName', 'IMU x');
    legend('show');
    title('Velocity X over Time');
    
    subplot(3, 1, 2);
    hold on;
    plot(v_gps.y, 'DisplayName', 'GPS Y');
    plot(v_imu.y*scale, 'DisplayName', 'IMU Y');
    hold off;
    title('Velocity Y over Time');
    legend('show');
    
    subplot(3, 1, 3);
    hold on;
    plot(sqrt((v_gps.y).^2 + (v_gps.x).^2), 'DisplayName', 'GPS Y');
    plot(sqrt((v_imu.y).^2 + (v_imu.x).^2) .* scale, 'DisplayName', 'IMU Y');
    hold off;
    title('Velocity Y over Time');
    legend('show');


end

function vel = plot_imu(input_file)
    raw_data = csvread(input_file);
    data = generate_data_cube(raw_data);
    data = callibrate_data(data)

    dt = 1/40;
    % Drive
    scale_factor = 1/45;
    rotation = -80
    
    % Circles
    %scale_factor = 1/15;
    %rotation = -90

    velocity.x = cumtrapz(data.accel.x) * dt;
    velocity.name = 'Velocity';

    % Y Accel observed = Velocity X * ROC of yaw(z)
    y_accel_observed = (velocity.x .* data.gyro.z);
    y_accel_shift = (data.accel.y(1) - y_accel_observed(1));
    y_accel_scale = 2;
    y_accel_observed = y_accel_observed + y_accel_shift;
    y_accel_observed = y_accel_observed/y_accel_scale;
   
    % 1. Start with x¨ which is the x - accelerometer output from the IMU
    accel_x = data.accel.x;
    
    % 2. Integrate it once to get dx - using cumtrapz
    % The result is the displacement at each point in time. 
    velocity_x  = cumtrapz(accel_x) * dt;

    % 4. Break up each displacement into x and y component based on heading.  
    % So rotate the displacement vector from purely x direction to x and y by 
    % applying the rotation through one of the angles found earlier.  (compass 
    % or gyro or both)
    vel.x =  velocity_x .* (sin(deg2rad(data.ypr.x - rotation)));
    vel.y =  velocity_x .* (cos(deg2rad(data.ypr.x - rotation)));
    pos.x = cumtrapz(vel.x) * dt * scale_factor;
    pos.y = cumtrapz(vel.y) * dt * scale_factor;
   
    pos.x = rot90(pos.x);
    pos.y = rot90(pos.y);

    plot(pos.x, pos.y, 'DisplayName', 'IMU')

end


function velocity = plot_gps(input_file)
    display(strcat('Plotting GPS'))
    % This function takes an input file name and plots the data
    data = csvread(input_file);
    utm_vectors = extract_utm(data);
    utm_vectors(:, 1) = utm_vectors(:, 1) - utm_vectors(1, 1);
    utm_vectors(:, 2) = utm_vectors(:, 2) - utm_vectors(1, 2);

    plot_utm_vectors(utm_vectors);
    %plot_vector_averages(utm_vectors);

    velocity.x = diff(utm_vectors(:, 1));
    velocity.y = diff(utm_vectors(:, 2));
end

function plot_utm_vectors(utm_vectors)
    % plots the xy vectors
    % utm_vectors = scale_utm(utm_vectors);
    plot(utm_vectors(:, 1), utm_vectors(:, 2), 'r', 'DisplayName', 'GPS');
end

function plot_vector_averages(utm_vectors)
    average_x_raw = mean(utm_vectors(:, 1));
    average_y_raw = mean(utm_vectors(:, 2));
    average_text = ['Average UTM (' num2str(average_x_raw) ', ' num2str(average_y_raw) ')'];
    disp(average_text)
    utm_vectors = scale_utm(utm_vectors);
    average_x_scaled = mean(utm_vectors(:, 1));
    average_y_scaled = mean(utm_vectors(:, 2));
    
    plot(average_x_scaled, average_y_scaled, 'b*', 'DisplayName', 'GPS Average');
    text(average_x_scaled, average_y_scaled,average_text);
end

function utm_vectors = scale_utm(data_square)
    % Subtracts out the minimum value from each vector from the entire vector
    % Inputs each row is of format [x y]
    scale_x = mean(data_square(:, 1));
    scale_y = mean(data_square(:, 2));

    scaled_x = data_square(:, 1) - scale_x;
    scaled_y = data_square(:, 2) - scale_y;

    utm_vectors = [scaled_x, scaled_y];
end

function utm_vectors = extract_utm(data_square)
    % Input: [timestamp lat lon alt utm_x utm_y]
    % Return: a [N x 2] matrix representing [x y] vectors
    utm_vectors = data_square(:, 5:6);
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
