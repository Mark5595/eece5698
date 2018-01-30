
function lcm_csv()
    % Main file
    inPlace = '../data/30minInplace.csv';
    lineWalk = '../data/2minLineWalk.csv';
    
    plot_file(inPlace, 'In Place');
    plot_file(lineWalk, 'Walking in a Line');
end

function plot_file(input_file, my_title)
    display(strcat('Plotting', my_title))
    % This function takes an input file name and plots the data
    data = csvread(input_file);
    utm_vectors = extract_utm(data);
    utm_vectors = scale_utm(utm_vectors);

    figure;
    plot_utm_vectors(utm_vectors);
    title(my_title);
    xlabel('UTM_X in M');
    ylabel('UTM_Y in M');

end

function utm_vectors = scale_utm(data_square)
    % Subtracts out the minimum value from each vector from the entire vector
    % Inputs each row is of format [x y]
    min_x = min(data_square(:, 1));
    min_y = min(data_square(:, 2));

    scaled_x = data_square(:, 1) - min_x;
    scaled_y = data_square(:, 2) - min_y;

    utm_vectors = [scaled_x, scaled_y]
end

function utm_vectors = extract_utm(data_square)
    % Input: [timestamp lat lon alt utm_x utm_y]
    % Return: a [N x 2] matrix representing [x y] vectors
    utm_vectors = data_square(:, 5:6);
end

function plot_utm_vectors(utm_vectors)
    % plots the xy vectors

    plot(utm_vectors(:, 1), utm_vectors(:, 2), 'r');
end




