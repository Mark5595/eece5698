

function ros_csv()
    % Main file
    inplace     = get_file_name('partial_obstruction/inplace')
    smallSquare = get_file_name('partial_obstruction/smallSquare')
    largeSquare = get_file_name('partial_obstruction/largeSquare')
    
    clear_inplace       = get_file_name('data_clear/inplace_clear')
    clear_smallSquare   = get_file_name('data_clear/smallSquare_clear')
    clear_largeSquare   = get_file_name('data_clear/largeSquare_clear')
    
    plot_file(inplace, 'Partial Obstruction: 10 Minutes In Place (Outdoors)', 0);
    plot_file(smallSquare, 'Partial Obstruction: Small Square (Outdoors)', 0);
    plot_file(largeSquare, 'Partial Obstruction: Large Square (Outdoors)', 0);
    
    plot_file(clear_inplace,        'No Obstruction: 10 Minutes In Place (Outdoors)', 0);
    plot_file(clear_smallSquare,    'No Obstruction: Small Square (Outdoors)', 0);
    plot_file(clear_largeSquare,    'No Obstruction: Large Square (Outdoors)', 0);
end

function filename = get_file_name(type)
    data_prefix = '../data/'
    utm_suffix = '/_slash_utm_fix.csv';
    
    filename = [data_prefix type utm_suffix]
end

function plot_file(input_file, my_title, linear)
    display(strcat('Plotting', my_title))
    format_spec = '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s';
    
    % This function takes an input file name and plots the data
    data = csvread(input_file);
    %data = data(2:, 12:13)
    utm_vectors = extract_utm(data);

    figure;
    plot_utm_vectors(utm_vectors);
    plot_vector_averages(utm_vectors);
    title(my_title);
    xlabel('Offset from Average X (M)');
    ylabel('Offset from Average Y (M)');
    
    if linear
        plot_linear_regression(utm_vectors, my_title)
    else
        figure;
        plot_histogram(utm_vectors, my_title);
    end
    


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
    utm_vectors = data_square(:, 1:2);
end

function plot_utm_vectors(utm_vectors)
    % plots the xy vectors
    utm_vectors = scale_utm(utm_vectors);
    plot(utm_vectors(:, 1), utm_vectors(:, 2), 'r*');
end

function plot_vector_averages(utm_vectors)
    average_x_raw = mean(utm_vectors(:, 1));
    average_y_raw = mean(utm_vectors(:, 2));
    average_text = ['Average UTM (' num2str(average_x_raw) ', ' num2str(average_y_raw) ')'];
    disp(average_text)
    utm_vectors = scale_utm(utm_vectors);
    average_x_scaled = mean(utm_vectors(:, 1));
    average_y_scaled = mean(utm_vectors(:, 2));
    
    hold on;
    plot(average_x_scaled, average_y_scaled, 'b*');
    text(average_x_scaled, average_y_scaled,average_text);
    hold off;
end

function plot_histogram(utm_vectors, name)
    utm_vectors = scale_utm(utm_vectors);
    average_x_scaled = utm_vectors(:, 1);
    average_y_scaled = utm_vectors(:, 2);
    
    subplot(2, 1, 1);
    hist(average_x_scaled);
    title(['Histogram of ' name ' [X axis]'])
    xlabel('UTM X Value (M)')
    ylabel('Number of Points')
    
    subplot(2, 1, 2);
    hist(average_y_scaled);
    title(['Histogram of ' name ' [Y axis]'])
    xlabel('UTM Y Value (M)')
    ylabel('Number of Points')

end

function plot_linear_regression(utm_vectors, title)
    utm_vectors = scale_utm(utm_vectors);
    x = utm_vectors(:, 1);
    y = utm_vectors(:, 2);
    
    X = [ones(length(x),1) x];
    b2 = X\y
    bfit_intercept = X*b2;

    hold on
    plot(x, bfit_intercept, 'b')
    legend('Data','Average', 'Slope');
    hold off

    mdl = fitlm(x, y)

end



