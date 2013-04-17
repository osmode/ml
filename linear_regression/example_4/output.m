function f = generateOutput(x1,x2)

x = rand*1000;
r = (x1^2 + x2^2 - 0.6);

while r == 0,
	r = (x1^2 + x2^2 - 0.6);
	end;

if r > 0,
	r = 1;
else
	r = -1;
end;

if x>= 100 && x<200,
	r = r*-1;
end;

f = r;

endfunction;


