clc
clear all

a = imread('cameraman.tif'); % Reading the image
a = im2double(a); % Normalizing the intensity values to lie between 0 and 1

ref = a;
add_noise = imnoise(a, 'gaussian', 0, 0.01); % Adding Gaussian noise with mean 0 and variance 0.01
timestep = 0.2; % Timestep size used in numerical approximation
Niter = 60; % Number of iterations

% Calculate the diffusion tensor
tensor = calculateDiffusionTensor(add_noise);

% Implement edge-enhancing diffusion
b = eed(add_noise, ref, tensor, timestep, Niter);

% Display the original and enhanced images by eed
figure;
subplot(1, 2, 1);
imshow(add_noise);
title('Noisy Image');
subplot(1, 2, 2);
imshow(b);
title('Enhanced Image by eed');




