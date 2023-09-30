% Calculate the diffusion tensor
function tensor = calculateDiffusionTensor(image)
    [Ix, Iy] = gradient(image);
    tensor = zeros(size(image, 1), size(image, 2), 2, 2);
    
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            % Calculate the normalized diffusion tensor
            G = [Ix(i, j); Iy(i, j)] * [Ix(i, j), Iy(i, j)];
            tensor(i, j, :, :) = G / (norm(G) + 1e-6); 
        end
    end
end