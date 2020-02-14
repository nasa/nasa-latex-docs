% Example Matlab function
function outcome = myfunc(x,a,b,c)
outcome = a*x^2 + b*x + c;

% Example Matlab loop
for n = 1:5
    x = n*0.1;
    z = myfunc(x,2,3,7);
    fprintf('x = %4.2f f(x) = %8.4f \r',x,z)
end