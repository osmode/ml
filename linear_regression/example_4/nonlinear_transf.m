#Given target function f(x1,x2)=sign(x1^2 + x2^2 -0.6)
#and a training set of N = 1000 points in space X = [-1, 1] x
# [-1, 1] with uniform probability of picking a point x in this space, and simulated noise generated by flipping the sign of the output
#in a random 10% subset of the generated training set.
#The training data are transformed via the nonlinear feature vector
#(1,x1,x2,x1x2,x1^2,x2^2).
#Then linear regression is used to classify 1000 new randomly-generated points.

function nonlinear_transf(num_points)

N = num_points;
NUM_EXP = 100;
Ess = [];

for r=1:NUM_EXP,

y = zeros(N,1);

#feature vector in the form (1,x1,x2,x1x2,x1^2,x2^2)
points = [];

for i=1:N,
	[a, b, c] = generateCoords;
	temp_point = [1 b c b*c b^2 c^2];
	
	points = [points; temp_point];

	actual_y = generateOutput(b,c);

	y(i,1) = actual_y; 

end;

#calculate weight vector using linear regression (normal equation method)
w = (pinv(points' * points)*points')*y;

disp("Weight vector (g) = ");
disp(w);
mismatches = 0;

for i=1:N,
	[a, b, c] = generateCoords;
	
	temp_point = [1 b c b*c b^2 c^2];
	
	points = [points; temp_point];

	y_per_f = generateOutput(b,c);
	y_per_g = temp_point*w;
	
	if y_per_f*y_per_g <0,
		mismatches = mismatches +1;
	end;
end;

#printf("E_out = %0.6f\n",(mismatches/N));
#printf("test\n");

#Now generate 1000 new random points, and use vector w to populate 
#'points2' and then compare y coordinates of points2 with that of 'points' 

#{
mismatch = 0;

for i=1:1000,
	
	#y_per_g is the y value of each point as predicted by 
	#hypothesis g (i.e. using weight vector)
	#points(1,3) is the actual y value of the randomly generated pt

	[u1, u2, u3] = generateCoords();
	random_pt = [u1 u2 u3];
	
       y_per_g = random_pt*w; 	
       y_per_f = generateOutput(u2,u3);

       if y_per_g*y_per_f <0,
	       mismatch = mismatch + 1;
       end;

end;
	 	
#}

E_in = mismatches/N;

Ess = [Ess; E_in];

end; #close outermost for loop

average = sum(Ess)/NUM_EXP;

printf("Average E_out = %0.6f\n",average);

endfunction;

