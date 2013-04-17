#This function is a simple demonstration of linear regression.
#First 2 random points are chosen in a [-1 1] x [-1 ] space, and a 
#line is drawn connecting them. Then N=num_points points are generated randomly,
#and using their x-coordinates and the line function (i.e. f), hypothesis  
#function g is created.
#Linear regression is used to obtain the weight vector w.
# w = pinv(X'X)*X' = g
#Finally the Perceptron Learning Algorithm is applied using the
#weight vector as initial weights. Note that this causes it to converge very quickly.

function linear_regression(num_points)

N = num_points;
NUM_EXP = 1;
NUM_TRIALS = 1000;

iterations = [];
mismatch_counter = 0;
mismatches = [];


# coordinates are generated in the form  [x0, x, y] where x0 = 1 

[x0, x, y] = generateCoords();
onex = [x0 x y];
[x0, x, y] = generateCoords();
twox = [x0 x y];

disp(onex);

m = (twox(1,3) - onex(1,3)) / ( twox(1,2) - onex(1,2) );
b = onex(1,3) - m*onex(1,2);
line = [1; m; b];

points = [];
Ess = [];
signn = [];
g_signn = [];
y = zeros(N,1);

for i=1:N,
	[x0, x, y] = generateCoords;
	temp_point = [x0 x y];
	points = [points; temp_point];

	actual_y = m*temp_point(1,2) + b;

	y(i,1) = actual_y;
	
	if temp_point(1,3) - actual_y < 0,
		signn = [signn; -1];
	else
		signn = [signn; 1];
	end;

end;

#calculate weight vector using linear regression (normal equation method)
w = (pinv(points' * points)*points')*y;

#disp("Weight vector (g) = ");
#disp(w);

for g=1:1,

	for j=1:N,
		product = points(j,:)*w;
		if( (product*signn(j)) < 0),
			w = w + (signn(j)*points(j,:))';
		end;
	end;
end;

#test number of mismatches
for s=1:NUM_TRIALS,

for g=1:N,
	sign2 = points(g,:)*w;

	if sign2*signn(j) < 0 ,
		mismatch_counter = mismatch_counter+1;
	end;
end;

mismatches = [mismatches; mismatch_counter];
mismatch_counter = 0;

end;

average = ((sum(mismatches) / NUM_TRIALS) /N);

printf("Number of mismatches: %i\n",average);
disp('w = '), disp(w);


endfunction;

