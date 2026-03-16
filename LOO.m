function accuracy = LOO(data, feature_set)
    class_label = data(:,1);                    % N×1
    feature_mat = data(:, feature_set + 1);          % N×num_selected_features
    
    N = size(feature_mat,1);
    correct = 0;
    
    for i = 1:N
        % leave out the i-th sample
        test_sample = feature_mat(i, :);                   % 1 * num_features
        training_sample = feature_mat([1:i-1, i+1:end], :);    % (N-1) * num_features
        training_labels = class_label([1:i-1, i+1:end]);
        
        % Compute squared Euclidean distances vectorized
        sqrDist = sum((training_sample - test_sample).^2, 2); % d^2(x_i,x_j) = d sum (k=1) (x_ik - x_jk)^2
         % result is (N-1)×1 vector of distances to training samples as we leave one out
         % (training_sample - test_sample) Automatic expansion for vertorization avoiding the loop. Way more efficient.
         % Cite: https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html
         % i.e. training samp = 
         % [2 2; 3 3; 4 4] 
         % test samp = [1 1]
         % diff = training samp - test samp = [1 1; 2 2; 3 3]

         % diff.^2 = [1 1; 4 4; 9 9]
         % sum(diff.^2, 2) = [1+1; 4+4; 9+9] = [2; 8; 18]
         % It sums up the rows to get the squared distance for each training sample to the test sample.

        % Find nearest neighbor
        [~, index] = min(sqrDist);  % [min_value, index] = min(...)
        predicted_label = training_labels(index);
        
        if predicted_label == class_label(i)
            correct = correct + 1;
        end
    end
    
    accuracy = correct / N;
end
