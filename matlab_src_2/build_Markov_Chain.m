function trans_matrix = build_Markov_Chain(symbols)

num_nodes = length(unique(symbols));

trans_matrix = zeros(num_nodes, num_nodes);

for i = 1:length(symbols)-1
    trans_matrix(symbols(i), symbols(i+1)) = trans_matrix(symbols(i), symbols(i+1)) + 1;
    
end

for j = 1:num_nodes
    trans_matrix(j, :) = trans_matrix(j, :) ./ sum(trans_matrix(j, :));   
end
