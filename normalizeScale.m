% This Octave script takes two csv files as inputs, 'train.csv' and 'test.csv'
% and performs mean normalization and feature scaling. It assumes that both
% files have a header in the first row, and that the first column of 
% 'train.csv' contains the supervised class

train_data = dlmread('train.csv');
test_data = dlmread('test.csv');

% number of rows minus header
num_train = size(train_data,1) - 1;
num_test = size(test_data,1) - 1;

% remember that number of train columns is one greater than
% number of test columns because of the target class in column 1
num_col = size(test_data,2);

% store means and standard deviations of each column as a num_train 
% (or num_test) x 1 column, with each row corresponding to a column
% in either train_data or test_data

% mean normalize and scale train data
means = []
stds = []
temp_mean = []
temp_std = []

for i = 2:size(train_data,2),
	temp_mean = mean(train_data(:,i));
	temp_std = std(train_data(:,i));

	means = [means; temp_mean];
	stds = [stds; temp_std];
end;

for j = 2:size(train_data,1),
	for i = 2:size(train_data,2),
		train_data(j,i) = ( 1.0*train_data(j,i) - means(i-1) ) / stds(i-1);
		
	end;
end;

% mean normalize and scale test data
% note the minor differences in indices
for j = 2:size(test_data,1),
	for i = 1:size(test_data,2),
		test_data(j,i) = ( 1.0*test_data(j,i) - means(i) ) / stds(i);

	end;
end;


% write the data to disk in csv format
dlmwrite('train2.csv',train_data);
dlmwrite('test2.csv',test_data);


