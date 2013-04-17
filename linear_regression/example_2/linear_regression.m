#This function is a simple demonstration of linear regression.
#First 2 random points are chosen in a [-1 1] x [-1 ] space, and a 
#line is drawn connecting them. Then N=num_points points are generated randomly,
#and using their x-coordinates and the line function (i.e. f),  the hypothesis function g 
#is created by generating the weight vector w.
# w = pinv(X'X)*X' = g
#Lastly, N=1000 fresh points are generated and used to calculate the 
#out-of-sample error E_out

function linear_regression(num_points)

N = num_points;
NUM_EXP = 1000;

Ess = [];
for r=1:NUM_EXP,

# coordinates are generated in the form  [x0, x, y] where x0 = 1 

[z0, z1, z2] = generateCoords();
onex = [z0 z1 z2];
[z0, z1, z2] = generateCoords();
twox = [z0 z1 z2];

m = (twox(1,3) - onex(1,3)) / ( twox(1,2) - onex(1,2) );
b = onex(1,3) - m*onex(1,2);
line = [m; b];

points = [];
y = [];

for i=1:N,
	[u1, u2, u3] = generateCoords;
	temp_point = [u1 u2 u3];
	points = [points; temp_point];

	actual_y = [u2 u3]*line; 

	if u3 - actual_y <0,
		y = [y; -1];
	else
		y = [y; 1];
	end;

end;

#calculate weight vector using linear regression (normal equation method)
w = (pinv(points' * points)*points')*y;

#disp("Weight vector (g) = ");
#disp(w);

#Now generate 1000 new random points, and use vector w to populate 
#'points2' and then compare y coordinates of points2 with that of 'points' 

mismatch = 0;

for i=1:1000,
	
	#y_per_g is the y value of each point as predicted by 
	#hypothesis g (i.e. using weight vector)
	#points(1,3) is the actual y value of the randomly generated pt

	[u1, u2, u3] = generateCoords();
	random_pt = [u1 u2 u3];
	
       y_per_g = random_pt*w; 	
       y_per_f = [u2 u3]*line;

       sign1 = u3 - y_per_f;

       if sign1*y_per_g  <0,
	       mismatch = mismatch + 1;
       end;

end;
	 	
E_out = mismatch/1000;

Ess = [Ess; E_out];

end; #close outermost for loop

average = sum(Ess)/NUM_EXP;

printf("Average E_out = %0.6f\n",average);

endfunction;

