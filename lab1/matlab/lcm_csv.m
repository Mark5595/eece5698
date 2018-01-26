
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

    figure;
    plot_utm_vectors(utm_vectors);
    title(my_title);
    xlabel('UTM_X in M');
    ylabel('UTM_Y in M');

end

function utm_vectors = extract_utm(data_square)
    % Returns a [N x 2] matrix representing [x y] vectors
    % [timestamp lat lon alt utm_x utm_y]
    utm_vectors = data_square(:, 5:6);
end

function plot_utm_vectors(utm_vectors)
    % plots the xy vectors

    plot(utm_vectors(:, 1), utm_vectors(:, 2), 'r*');
end




