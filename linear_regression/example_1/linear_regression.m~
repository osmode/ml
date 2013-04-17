#This function is a simple demonstration of linear regression.
#First 2 random points are chosen in a [-1 1] x [-1 ] space, and a 
#line is drawn connecting them. Then N points are generated randomly,
#and using their x-coordinates and the line function (i.e. f),  vector y 
#is created. 
#Then linear regression is used to obtain the weight vector w.
# w = pinv(X'X)*X' = g
#N=100 points are randomly generated in this space and classified
#as +1 or -1 (depending on whether they fall above or below the line)
#using linear regression and the line function, and the in-sample
#errors compared (E_in)

function linear_regression(num_points)

N = num_points;
NUM_EXP = 1000;

Ess = [];
for r=1:NUM_EXP,

# coordinates are generated in the form  [x0, x, y] where x0 = 1 

[x0, x, y] = generateCoords();
onex = [x0 x y];
[x0, x, y] = generateCoords();
twox = [x0 x y];

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
	if u3 - actual_y < 0,
		y = [y; -1];
	else
		y = [y; 1];
	end;

end;

#calculate weight vector using linear regression (normal equation method)
w = (pinv(points' * points)*points')*y;

#disp("Weight vector (g) = ");
#disp(w);

#use vector w to populate 'points2' and then compare y coordinates 
#of points2 with that of 'points' 

mismatch = 0;

for i=1:N,
	
	#using the same set of points in matrix 'points', calculate
	#the predicted y value, and then decide if it's on the same 
        #side of the line as its actual y value	
	#y_per_g is the y value of each point as predicted by 
	#hypothesis g (i.e. using weight vector)
	#points(1,3) is the actual y value of the randomly generated pt
	
       y_per_g = points(i,:)*w; 	

       if y_per_g*y(i) < 0,
	       mismatch = mismatch + 1;
       end;

end;
	 	
E_in = mismatch/N;

Ess = [Ess; E_in];

end; #close outermost for loop

average = sum(Ess)/NUM_EXP;

printf("Average E_in = %0.6f\n",average);

endfunction;

