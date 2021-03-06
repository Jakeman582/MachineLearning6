function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 0.01;
sigma = 0.03;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% The values to test on.
vals = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

% We need a model to make predictions.
model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
predictions = svmPredict(model, Xval);
min = mean(double(predictions ~= yval));

results = [];

% Iterate and find the best possible value from the above list.
for C_index = vals
    for sigma_index = vals
        model = svmTrain(X, y, C_index, @(x1, x2) gaussianKernel(x1, x2, sigma_index));
        predictions = svmPredict(model, Xval);
        result = mean(double(predictions ~= yval));
        if result < min
            min = result;
            C = C_index;
            sigma = sigma_index;
        end
    end
end

% =========================================================================

end
