#this function returns an ordered triplet of random numbers
#between -1 and 1

function [x, y, z] = generateCoords()

x = 1;
y = rand; 
z = rand;
c = rand;
if c > 0.5,
	z = z*(-1);
end;
d = rand;
if d < 0.5,
	y = y*(-1);
end;

endfunction;
