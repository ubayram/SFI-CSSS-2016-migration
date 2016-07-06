% Author: Ulya Bayram
% ulyabayram@gmail.com
% inputs: longitude data array
%           latitude data array
%           bird id's that are being modeled
%           heights data of birds if it exists (~='nan')
%           heading direction of each bird, ranges from [0, 360] degrees
%           date is the year-month-day data
%           time is the hour:minute:second:ms data of gps tracking moment
function findFlightSpeed(data_long, data_lat, bird_ids, heights, heading, date_, time_)

length = size(data_long, 1);

if length ~= size(heights, 1) || length ~= size(heading, 1)
    
    error('Data size mismatch!');
    
end

% perform speed analysis of each bird separately

birds = unique(bird_ids);

for i = 1:size(birds, 1)
   
    current_bird = birds(i);
    index_ = find(bird_ids == current_bird);
    
    % these current_* are all arrays, containing all data belonging to
    % current bird with current_bird id
    % time-wise, data is already in order
    current_long = data_long(index_);
    current_lat = data_lat(index_);
    current_height = heights(index_);
    current_heading = heading(index_);
    current_date = date_(index_);
    curent_time = time_(index_);
end