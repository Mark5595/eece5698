

function csv_in_place_analysis()
    % Main file
    Points_1500 = '../data/1000_pts_in_place_imu_reading.csv';
    Points_car = '../data/2000PointsInPlaceInCar/imu_reading.csv';
    
    %plot_file(Points_1500, '1500 points in place IMU');
    plot_file(Points_car, '2000 points in Car IMU');
end

function plot_file(input_file, my_title)
    display(strcat('Plotting', my_title))
    % This function takes an input file name and plots the data
    data = csvread(input_file);
    
    ypr = extract_triplet(data, 0);
    mag = extract_triplet(data, 1);
    accel = extract_triplet(data, 2);
    gyro = extract_triplet(data, 3);

    figure;
    plot_xyz(ypr, 'Yaw Pitch Roll', 'Deg');
    figure;
    plot_xyz(mag, 'Mag', 'Gauss');
    figure;
    plot_xyz(accel, 'Accel', 'm/s^2');
    figure;
    plot_xyz(gyro, 'Gyro', 'rad/s');
    

end

function plot_xyz(xyz, my_title, unit)
    % plots the xyz vectors
    xyz_scaled = scale_xyz(xyz);
    subplot(3, 3, [1, 4, 7])
    plot3(xyz_scaled(:, 1), xyz_scaled(:, 2), xyz_scaled(:, 3), 'r*');
    plot_vector_averages(xyz)
    title(my_title);
    xlabel(strcat('Offset from Average X (', unit, ')'));
    ylabel(strcat('Offset from Average Y (', unit, ')'));
    zlabel(strcat('Offset from Average Z (', unit, ')'));
    grid on

    plot_histogram(xyz, my_title, unit);
    plot_over_time(xyz, my_title, unit);
end


function plot_histogram(vectors, name, unit)
    vectors = scale_xyz(vectors);
    average_x_scaled = vectors(:, 1);
    average_y_scaled = vectors(:, 2);
    average_z_scaled = vectors(:, 3);
    
    subplot(3, 3, 2);
    hist(average_x_scaled);
    title(strcat('Histogram of ', name,' [X axis]'))
    xlabel(strcat('X Value (', unit, ')'))
    ylabel('Number of Points')
    
    subplot(3, 3, 5);
    hist(average_y_scaled);
    title(strcat('Histogram of ', name,' [Y axis]'))
    xlabel(strcat('Y Value (', unit, ')'))
    ylabel('Number of Points')
    
    subplot(3, 3, 8);
    hist(average_z_scaled);
    title(strcat('Histogram of ', name,' [Z axis]'))
    xlabel(strcat('Z Value (', unit, ')'))
    ylabel('Number of Points')

end

function plot_over_time(vectors, name, unit)
    %vectors = scale_xyz(vectors);
    average_x_scaled = vectors(:, 1);
    average_y_scaled = vectors(:, 2);
    average_z_scaled = vectors(:, 3);
    
    subplot(3, 3, 3);
    plot(average_x_scaled);
    title(strcat(name,' [X axis] over time'))
    xlabel(strcat('X Value (', unit, ')'))
    ylabel('Number of Points')
    
    subplot(3, 3, 6);
    plot(average_y_scaled);
    title(strcat(name,' [Y axis] over time'))
    xlabel(strcat('Y Value (', unit, ')'))
    ylabel('Number of Points')
    
    subplot(3, 3, 9);
    plot(average_z_scaled);
    title(strcat(name,' [Z axis] over time'))
    xlabel(strcat('Z Value (', unit, ')'))
    ylabel('Number of Points')
end

function plot_vector_averages(vectors)
    average_x_raw = mean(vectors(:, 1));
    average_y_raw = mean(vectors(:, 2));
    average_z_raw = mean(vectors(:, 3));

    average_text = ['Average XYZ (' ...
    num2str(average_x_raw) ', ' ...
    num2str(average_y_raw) ',' ...
    num2str(average_z_raw) ...
    ')'];

    disp(average_text)
    vectors = scale_xyz(vectors);
    average_x_scaled = mean(vectors(:, 1));
    average_y_scaled = mean(vectors(:, 2));
    average_z_scaled = mean(vectors(:, 3));
    
    hold on;
    plot3(average_x_scaled, average_y_scaled, average_z_scaled, 'b*');
    text(average_x_scaled, average_y_scaled, average_z_scaled, average_text);
    hold off;
end

function scaled_xyz = scale_xyz(data_square)
    % Subtracts out the minimum value from each vector from the entire vector
    % Inputs each row is of format [x y]
    scale_x = mean(data_square(:, 1));
    scale_y = mean(data_square(:, 2));
    scale_z = mean(data_square(:, 3));

    scaled_x = data_square(:, 1) - scale_x;
    scaled_y = data_square(:, 2) - scale_y;
    scaled_z = data_square(:, 3) - scale_z;

    scaled_xyz = [scaled_x, scaled_y, scaled_z];
end

function xyz = extract_triplet(data_square, offset)
    % Input: [timestamp yaw pitch roll mag_x mag_y mag_z accel_x accel_y accel_z gyro_x gyro_y gyro_z]
    % Return: a [N x 2] matrix representing [x y z] vectors at a given offset. 
    % Offset of 0 returns [yaw pitch roll]
    
    xyz = data_square(:, (2 + offset):(4 + offset));
end
