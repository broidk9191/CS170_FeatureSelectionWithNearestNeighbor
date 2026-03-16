function accuracy = LOO(data, feature_set)
    total_samples = size(data, 1);
    correct = 0;

    % Loop through each sample in dataset
    for i = 1:total_samples 
        object = data(i,feature_set +1); % +1 here because first column is 
        label = data(i,1);

        best_distance = inf; % initialize best distance to infinity because we want to find minimum
        best_label = -1; % placeholder of label for nearest neighbor

        % Compare current sample with all other samples in dataset
        for j = 1:total_samples 
            if j ~= i
                distance = sqrt(sum((object -data(j, feature_set+1)).^2)); % Compute Euclidean distance between current sample and other sample
                
                % update if current distance is smaller than best distance
                if distance < best_distance
                    best_distance = distance;
                    best_label = data(j, 1);
                end
            end
        end

        if label == best_label % check if prediction is correct
            correct = correct + 1;
        end
    end

    accuracy = correct / total_samples;
end
