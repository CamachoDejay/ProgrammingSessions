function [out_val] = my_mean(vec)
%my_mean calculates the mean of all values in a vector.
%   We will explain this later

% check for precontidions
assert(isvector(vec),'input must be a vector')
sum_val = sum(vec);
n_elements = length(vec);
out_val = sum_val/n_elements;

end



