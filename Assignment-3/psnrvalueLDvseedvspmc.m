clc
clear all

input_image = imread('cameraman.tif');
input_image = im2double(input_image); % Normalize intensity values

% Add noise to create a noisy image
noisy_image = imnoise(input_image, 'gaussian', 0, 0.01);

% Parameters for diffusion methods
timestep = 0.1; % Timestep size used in numerical approximation
niter = 150; % Number of iterations

% Perform Linear Diffusion
linear_diffusion_image = linearDiffusiontest(noisy_image, timestep, niter);

% Perform PMC (Perona-Malik Anisotropic Diffusion)
lambda_pmc = 0.001;
alpha_pmc = 2.7;
w_pmc = exp(4 * alpha_pmc / 9);
pmc_image = pmc(noisy_image,input_image, lambda_pmc, timestep, niter,1, w_pmc,1);

% Perform Edge-Enhancing Diffusion (EED)
ref_eed = input_image;
tensor_eed = calculateDiffusionTensor(noisy_image);
eed_image = eed(noisy_image, ref_eed, tensor_eed, timestep, niter);

% Calculate PSNR values for each enhanced image
r=4;
psnr_linear_diffusion = calculatePSNR(input_image, linear_diffusion_image,r);
psnr_pmc = calculatePSNR(input_image, pmc_image,r);
psnr_eed = calculatePSNR(input_image, eed_image,r);

% Display PSNR values
fprintf('PSNR for Linear Diffusion: %.2f dB\n', psnr_linear_diffusion);
fprintf('PSNR for PMC: %.2f dB\n', psnr_pmc);
fprintf('PSNR for EED: %.2f dB\n', psnr_eed);