#This program demonstrates a very simple perceptron learning algorithm.
#First a line is randomly drawn in a [-1, 1] x [-1, 1] space.
#Then N points (the first parameter of function main) are randomly generated
#and assigned a value of either -1 or 1 by the target function depending
#on whether or not they fall above or below the line. The PLA iterates
#num_exp times (the second paramter of function main), and during each
#iteration the weight vector is adjusted as W:= W + y_n'*X, where w is the
#weight vector, y_n is the transverse of a vector consisting of the output 
#of the target function, and X is a vector consisting of input points (i.e.
#vector X = [x0; x1; x2] where x0 = 1.

function main(x, num_exp)

NUM_TRIALS = 500;
temp_averages = [];

#generate two random numbers (x and y coords) with range [-1 1] x [-1 1]
[x1, y1, z1] = generateCoords();
[x2, y2, z2] = generateCoords();
m = (z2 - z1) / (y2 - y1);
b = z2 - (m*y2);

N = x;

# 'line' is the vector [m; b] representing the dividing line
# i.e. function f
line = [m; b];
sprintf('function f: ');
disp(line);

#W is the perceptron weight vector that converges to 'line' (i.e. f)
W = [0.01; 0.01; 0.01];

#X stores x_n values (triplet of x0, x1, and x2 where x0 =1)
X = [];
#sign is a vector holding data on whether point is above or below line
# i.e. either 1 or -1
signn = [];

for i = 1:N,

	# [x3, y3, z3] represents the randomly generated point
	# where x3 is always 1
	[x3, y3, z3] = generateCoords();

	while ( (y3 == 0) || (z3 == 0) ),
	[x3, y3, z3] = generateCoords();
	end;

	# X represents the design matrix holding random point data
	point = [y3 1];

	# product is f(x3)
	product =  point*line;

	# store N lines in matrix Y 
	X = [X; [x3, y3, z3]];

	if z3-product >= 0,
		signn = [signn; 1];
	else
		signn = [signn; -1];
	end;

end;


# now iterate 'num_iterations' times over these N points, each time:
# 1.) Multiply x_n (i.e. a triplet) and weight vector W to calculate 'product'
# 2.) If 'product' (a scalar) has the same sign as y_n (output of target 
#     function), don't do anything. If not, adjust weight vector as follows:
#     W := W + y_n*(x_n)

num_iterations = num_exp;

for i = 1:num_iterations,
	
	for j = 1:N,

	product = X(j,:)*W;

	#if classification is in the wrong direction (wrong sign)
	#adjust weights
	if ( (product*signn(j)) < 0),
		W = W + (signn(j)*X(j,:))';
		end;
	end;

end;	

#This last part uses the weight vector W that was generated through
#iterations and tests it against the input points to how accurate it is.

mismatch_counter = 0;
#mismatches is a vector that holds # of mismatches for each experiment
mismatches = [];

for i=1:NUM_TRIALS,

for i=1:N,
	sign2 = X(i,:)*W;

	if (sign2*signn(i) < 0),
		mismatch_counter = mismatch_counter +1;
	end;
end;

mismatches = [mismatches; mismatch_counter];
mismatch_counter = 0;
#disp(mismatch_counter);

end;

#calculate average number of mismatches
average = ((sum(mismatches) / NUM_TRIALS) / N);

printf('Average number of mismatches: %0.6f\n',average);

disp('W = '), disp(W);

endfunction

