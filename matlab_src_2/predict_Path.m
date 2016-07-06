% of a single bird
function predict_Path(heading_array)

symbols = zeros(size(heading_array));

% convert heading data into codebook
for i = 1:length(heading_array)
    
    symbols(i) = map_Heading_to_Grid(heading_array(i));
    
end

trans_matrix = build_Markov_Chain(symbols);