

function csv_in_place_analysis()
    % Main file
    Points_1500 = '../data/1000_pts_in_place_imu_reading.csv';
    Points_car = '../data/2000PointsInPlaceInCar/imu_reading.csv';
    
    %plot_file(Points_1500, '1500 points in place IMU');
    plot_file(Points_car, '2000 points in Car IMU');
end

function plot_file(input_file, my_title)
    display(strcat('Plotting ', my_title))
    % This function takes an input file name and plots the data
    data = csvread(input_file);
    
    data2.ypr = extract_triplet(data, 0);
    data2.mag = extract_triplet(data, 1);
    data2.accel = extract_triplet(data, 2);
    data2.gyro = extract_triplet(data, 3);

    figure;
    plot_xyz(data2.ypr, 'Yaw Pitch Roll', 'Deg');
    figure;
    plot_xyz(data2.mag, 'Mag', 'Gauss');
    figure;
    plot_xyz(data2.accel, 'Accel', 'm/s^2');
    figure;
    plot_xyz(data2.gyro, 'Gyro', 'rad/s');
    
    figure;
    bias = plot_all(data2, 'Raw Stationary');
    adjusted_data = adjust(data2, bias);

    figure;
    plot_all(adjusted_data, 'Adjusted Stationary');

    figure;
    hold on
    plot(cumtrapz(data2.accel.x), '*', 'DisplayName', 'not adjusted');
    plot(cumtrapz(adjusted_data.accel.x), '*', 'DisplayName', 'adjsuted');
    hold off;
    legend('show');
    title('velocity over time');
end

function bias = plot_all(input_data, type)

    function bias = plot_helper(my_title, data, index, my_xlabel, my_ylabel, type)
        subplot(4, 1, index);
        hold on;
        plot(data.x, 'DisplayName', 'X')

        plot(data.y, 'DisplayName', 'Y')
        

        plot(data.z, 'DisplayName', 'Z')
        
        mean_x = mean(data.x);
        mean_y = mean(data.y);
        mean_z = mean(data.z);
        last_x = size(data.z);
        last_x = last_x(1);
        
        text(last_x, 0, ...
        ['X avg: ' num2str(mean_x) char(10) ...
         'Y avg: ' num2str(mean_y) char(10) ...
         'Z avg: ' num2str(mean_z)])

        legend('show')
        title(my_title)
        xlabel(my_xlabel)
        ylabel(my_ylabel)
        hold off;

        bias.x = mean_x;
        bias.y = mean_y;
        bias.z = mean_z;
    end

    bias.ypr = plot_helper(['YPR ' type ' Data'], input_data.ypr, 1, 'Sample Num', 'Degrees');
    bias.mag = plot_helper(['Mag ' type ' Data'], input_data.mag, 2, 'Sample Num', 'Gauss');
    bias.accel = plot_helper(['Accel ' type ' Data'], input_data.accel, 3, 'Sample Num', 'm/s^2');
    bias.gyro = plot_helper(['Gyro ' type ' Data'], input_data.gyro, 4, 'Sample Num', 'rad/s');

end

function plot_xyz(xyz, my_title, unit)
    % plots the xyz vectors
    xyz_scaled = scale_xyz(xyz);
    subplot(3, 3, [1, 4, 7])
    plot3(xyz_scaled.x, xyz_scaled.y, xyz_scaled.z, 'r*');
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
    average_x_scaled = vectors.x;
    average_y_scaled = vectors.y;
    average_z_scaled = vectors.z;
    
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
    average_x = mean(vectors.x);
    average_y = mean(vectors.y);
    average_z = mean(vectors.z);
    num_pts = size(vectors.x);

    average_x_text = ['Average X: ' num2str(average_x)];
    average_y_text = ['Average Y: ' num2str(average_y)];
    average_z_text = ['Average Z: ' num2str(average_z)];
    
    subplot(3, 3, 3);
    hold on;
    plot(vectors.x);
    plot(ones(num_pts) * average_x)
    text(num_pts(1), average_x, average_x_text);
    hold off;
    title(strcat(name,' [X axis] over time'))
    ylabel(strcat('Y Value (', unit, ')'))
    xlabel('Point number')
    
    subplot(3, 3, 6);
    hold on;
    plot(vectors.y);
    plot(ones(num_pts) * average_y)
    text(num_pts(1), average_y, average_y_text);
    hold off;
    title(strcat(name,' [Y axis] over time'))
    ylabel(strcat('Y Value (', unit, ')'))
    xlabel('Point number')
    
    subplot(3, 3, 9);
    hold on;
    plot(vectors.z);
    plot(ones(num_pts) * average_z)
    text(num_pts(1), average_z, average_z_text);
    hold off;
    title(strcat(name,' [Z axis] over time'))
    ylabel(strcat('Z Value (', unit, ')'))
    xlabel('Point number')
end

function plot_vector_averages(vectors)
    average_x_raw = mean(vectors.x);
    average_y_raw = mean(vectors.y);
    average_z_raw = mean(vectors.z);

    average_text = ['Average XYZ (' ...
    num2str(average_x_raw) ', ' ...
    num2str(average_y_raw) ',' ...
    num2str(average_z_raw) ...
    ')'];

    disp(average_text)
    vectors = scale_xyz(vectors);
    average_x_scaled = mean(vectors.x);
    average_y_scaled = mean(vectors.y);
    average_z_scaled = mean(vectors.z);
    
    hold on;
    plot3(average_x_scaled, average_y_scaled, average_z_scaled, 'b*');
    text(average_x_scaled, average_y_scaled, average_z_scaled, average_text);
    hold off;
end

function adjusted = adjust(data, bias)

    adjusted.ypr.x = data.ypr.x - bias.ypr.x;
    adjusted.ypr.y = data.ypr.y - bias.ypr.y;
    adjusted.ypr.z = data.ypr.z - bias.ypr.z;

    adjusted.mag.x = data.mag.x - bias.mag.x;
    adjusted.mag.y = data.mag.y - bias.mag.y;
    adjusted.mag.z = data.mag.z - bias.mag.z;
    
    adjusted.accel.x = data.accel.x - bias.accel.x;
    adjusted.accel.y = data.accel.y - bias.accel.y;
    adjusted.accel.z = data.accel.z - bias.accel.z;
    
    adjusted.gyro.x = data.gyro.x - bias.gyro.x;
    adjusted.gyro.y = data.gyro.y - bias.gyro.y;
    adjusted.gyro.z = data.gyro.z - bias.gyro.z;
end

function scaled_xyz = scale_xyz(data_square)
    % Subtracts out the minimum value from each vector from the entire vector
    % Inputs each row is of format [x y]
    scale_x = mean(data_square.x);
    scale_y = mean(data_square.y);
    scale_z = mean(data_square.z);

    scaled_x = data_square.x - scale_x;
    scaled_y = data_square.y - scale_y;
    scaled_z = data_square.z - scale_z;

    scaled_xyz.x = scaled_x;
    scaled_xyz.y = scaled_y;
    scaled_xyz.z = scaled_z;
end

function xyz = extract_triplet(data_square, offset)
    % Input: [timestamp yaw pitch roll mag_x mag_y mag_z accel_x accel_y accel_z gyro_x gyro_y gyro_z]
    % Return: a [N x 2] matrix representing [x y z] vectors at a given offset. 
    % Offset of 0 returns [yaw pitch roll]
    
    xyz_temp = data_square(:, (2 + (offset * 3)):(4 + (offset * 3)));
    xyz.x = xyz_temp(:, 1);
    xyz.y = xyz_temp(:, 2);
    xyz.z = xyz_temp(:, 3);
end
