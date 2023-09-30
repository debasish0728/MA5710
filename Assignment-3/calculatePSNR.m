% Define the PSNR calculation function
function psnr = calculatePSNR(original, enhanced,r)
    % Calculate the mean squared error
    mse = mean((original(:) - enhanced(:)).^2);
    
    % Calculate PSNR in decibels
    psnr = 10 * log10(r^2 / mse);
end