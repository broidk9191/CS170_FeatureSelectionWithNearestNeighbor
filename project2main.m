function project2main()
    fprintf("Welcome to Henry's Feature Selection Algorithm for Nearest Neighbor Classifier\n\n");
    filename = input("Enter the filename of dataset to test: ", 's');

    while ~isfile(filename)
        fprintf("File '%s' was not found. Please enter a valid filename.\n", filename);
        filename = input("Enter the filename of dataset to test: ", 's');
    end
    
    fprintf("Choose between 1 and 2 of algorithm to run:\n1. Forward Selection\n2. Backward Elimination\n");
    choice = input("Your choice: ");

    while ~(isequal(choice, 1) || isequal(choice, 2))
        fprintf("Invalid choice '%s'. Please enter 1 or 2.\n", num2str(choice));
        choice = input("Your choice: ");
    end

    data = load(filename);
    total_features = size(data, 2) - 1;
    total_instances = size(data, 1);

    fprintf("This dataset has %d features (not including the class attribute), with %d instances.\n\n", total_features, total_instances);

    accuracy = LOO(data, 1:total_features);
    fprintf('Running nearest neighbor with all features, using "leaving-one-out" evaluation, I get an accuracy of %.1f%%\n\n', accuracy * 100);    
    
    if choice == 1
        forwardSelection(data);
    else
        backwardElimination(data);
    end
end