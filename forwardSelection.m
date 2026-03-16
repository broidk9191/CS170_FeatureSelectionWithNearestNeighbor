function best_set = forwardSelection(data)
    total_features = size(data,2) -1; % -1 because first column is label
    current_set = [];
    best_set = [];
    best_overall_accuracy = 0;

    fprintf('Running Forward Selection Search...\n\n\n');

    for i = 1:total_features
        feature_to_add = -1; %placeholder
        best_accuracy_now = 0;

        % check every remaining feature with LOO and pick highest accuracy
        for j = 1:total_features
            if ~ismember(j, current_set) % only consider features that are not in current set
                accuracy = LOO(data, [current_set, j]);
                fprintf("Using feature {%s} accuracy is %.1f%%\n", num2str([current_set, j]), accuracy * 100);

                if accuracy > best_accuracy_now % update if current accuracy is best for this level
                    best_accuracy_now = accuracy;
                    feature_to_add = j;
                end
            end
        end

        if feature_to_add ~= -1
            current_set = [current_set, feature_to_add];
            fprintf("\nFeature set {%s} was best with accuracy of %.1f%%\n\n\n", num2str(current_set), best_accuracy_now * 100);

            if best_accuracy_now > best_overall_accuracy % update if current accuracy is best overall
                best_overall_accuracy = best_accuracy_now;
                best_set = current_set;

            else
                fprintf("(Warning, Accuracy has decreased! Continuing search in case of local maxima)\n\n");
            end

        else
            fprintf("\nNo feature to add, stop search.\n\n\n");
            break;
        end
    end

    fprintf("Search completed. The best feature subset is {%s} with an accuracy of %.1f%%\n", num2str(best_set), best_overall_accuracy * 100);
end

