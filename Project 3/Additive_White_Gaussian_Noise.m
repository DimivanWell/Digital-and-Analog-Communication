% || Introduction to Communication Theory ||
% Author: Dimitri van Well
% ID: GJ7192
% !!!NOTES: Variables are unique to each part of the project. They have
% beeen established within a structure for the respective part. Hitting run
% on the script will successfully run the entire script!!!
clear;
clc;
%% Part 1: White Gaussian Noise
%Part 1(a)
clear;
clc;
%  Generate white gaussian nosie n(t) with noise power, Pn
%    (a) Pn=10mW => .01
part1A.fs = 10e2; %sample frequency
part1A.t = -1:1/part1A.fs:1; %sample rate
part1A.Pn = .01; %noise power
part1A.x = randn(1,max(size(part1A.t))); %random noise variable generation
part1A.n = sqrt(part1A.Pn) * part1A.x; %Random sample by Noise Power 
figure(1)
plot(part1A.t,part1A.n);      
title('n(t) w/ Pn=10mW');
xlabel('Time');
ylim([-1 1]); ylabel('Amplitude');

%__________________________________________________________________________
%Part 1(b)
%    (b) Pn=60mW => .06
part1B.fs = 10e2; %sample frequency
part1B.t = -1:1/part1B.fs:1; %sample rate
part1B.Pn = .06; %noise power
part1B.x = randn(1,max(size(part1B.t))); %random noise variable generation
part1B.n = sqrt(part1B.Pn) * part1B.x; %Random sample by Noise Power
figure(2)
plot(part1B.t,part1B.n);      
title('n(t) w/ Pn=60mW');
xlabel('Time');
ylim([-1 1]); ylabel('Amplitude');
%__________________________________________________________________________
% Compare the two noise graphs
figure(3)
plot(part1B.t,part1B.n);

hold on;

plot(part1A.t,part1A.n);
title('Both n(t) graphs');
xlabel('Time');
ylim([-1 1]); ylabel('Amplitude');
legnd = legend('60mW','10mW');
title(legnd,'Pn value');
%__________________________________________________________________________


%% Part 2: Additive Noise; using signal g(t) is reveived with n(t).
%Using g(t) from P2.1-5, combined with n(t) to formulate r(t).

part2.fs = 10e2;
part2.t = -4:1/part2.fs:4;

% Generate the g(t) message
part2.g=((part2.t+4).^3).*[(heaviside(part2.t+4))-(heaviside(part2.t+2))] - ((-part2.t).^3).*[(heaviside(part2.t+2))-(heaviside(part2.t-2))] + ((part2.t-4).^3).*[(heaviside(part2.t-2))-(heaviside(part2.t-4))];

part2.pwr = rms(part2.g)^2; %This was used as check for the signal power that was calculated by hand

% Generate the n(t), Gaussian Noise, message
part2.X = randn(1,max(size(part2.t)));

% Power Value and SNR, Pn needs to be set so that SNR = 93 = 92 + 1 = last
% 2 digits of id + 1
part2.Pn = (64/7)/93; %it is otherwise 93 = Ps/Pn
    %this puts the noise power roughly at 98.3mW

part2.n = sqrt(part2.Pn) * part2.X;

% Calculating r(t)
part2.r = part2.g + part2.n;

figure(4)

subplot(1,2,1);
plot(part2.t,part2.g);
title('g(t)');
xlabel('Time');
ylabel('Amplitude');

subplot(1,2,2);
plot(part2.t,part2.r);
title('r(t)');
xlabel('Time');
ylabel('Amplitude');

figure(5)
plot(part2.t,part2.r);
hold on
plot(part2.t,part2.g);
title('r(t) (g(t) w/noise)');
xlabel('Time');
ylabel('Amplitude');
