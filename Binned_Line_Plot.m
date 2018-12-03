function [ x_vals, call_points ] = camillePlot( call_latencies, x_range, bin_size )
%CAMILLEPLOT This will plot a line graph of the number of calls that occur
%in a particular range binned at a certain point. All times in seconds.
%   call_latencies - Vector with numbers within the x_range specified
%   x_range - Range of values to look through (e.g. [0 8] is 0 to 8 sec
%   bin_size - How small of steps to take in the range (e.g. 0.2 for 200
%   msec).
begin_time = x_range(1); % Where it starts
end_time = x_range(2) - bin_size; % That is the maximal value
points = begin_time:bin_size:end_time; % All the points to look at
numPoints = length(points); % How many points there are
call_points = zeros(numPoints,1); % Store the values
for win = 1:numPoints
    call_points(win) = call_points(win) + ...
        sum(call_latencies >= points(win) & call_latencies < (points(win)+bin_size) );
end
call_points = call_points/length(call_latencies); % Average call points per bin_size
%call_points = call_points/bin_size; % Get the Hz (per second)
plot(points+bin_size/2,call_points);
x_vals = points+bin_size/2;
end
 