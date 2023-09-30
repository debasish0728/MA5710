% Define the edge-enhancing diffusion function
function result_image = eed(f, ref, tensor, dt, niter)
    result_image= f; % Initialize the result with the noisy image
    
    for i = 1:niter
        % Calculate gradients
        [Dx, Dy] = gradient(result_image);
        
      
        Gx = tensor(:, :, 1, 1) .* Dx + tensor(:, :, 1, 2) .* Dy;
        Gy = tensor(:, :, 2, 1) .* Dx + tensor(:, :, 2, 2) .* Dy;
        
        % Calculate divergence of the diffusion tensor
        divG = divergence(Gx, Gy);
        
        % Update the image using the edge-enhancing diffusion equation
        result_image = result_image + dt * (divG - result_image + ref);
    end
end
