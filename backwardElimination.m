function best_set = backwardElimination(data)
    total_features = size(data,2)-1;% -1 because first column is label
    current_set = 1:total_features; % start with all features
    best_set = current_set;
    best_overall_accuracy = LOO(data, current_set); % initialize best overall accuracy with all features

    fprintf('Running Backward Elimination Search...\n\n\n');

    for i = 1:total_features-1 %stop when only one feature left
        feature_to_remove = -1; %placeholder
        best_accuracy_now = 0;

        % check every remaining feature with LOO and pick highest accuracy
        for j = 1:total_features
            if ismember(j, current_set) % only consider features that are in current set
                accuracy = LOO(data, setdiff(current_set, j));
                fprintf("Using feature {%s} accuracy is %.1f%%\n", num2str(setdiff(current_set, j)), accuracy * 100);

                if accuracy > best_accuracy_now % update if current accuracy is best for this level
                    best_accuracy_now = accuracy;
                    feature_to_remove = j;
                end
            end
        end

        if feature_to_remove ~= -1
            current_set = setdiff(current_set, feature_to_remove);
            fprintf("\nFeature set {%s} was best with accuracy of %.1f%%\n\n\n", num2str(current_set), best_accuracy_now * 100);

            if best_accuracy_now > best_overall_accuracy % update if current accuracy is best overall
                best_overall_accuracy = best_accuracy_now;
                best_set = current_set;

            else
                fprintf("(Warning, Accuracy has decreased! Continuing search in case of local maxima)\n\n");
            end

        else
            fprintf("\nNo feature to remove, stop search.\n\n\n");
            break;
        end
    end

    fprintf("Search completed. The best feature subset is {%s} with an accuracy of %.1f%%\n", num2str(best_set), best_overall_accuracy * 100);
end