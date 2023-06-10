%% Script created by Dimitri van Well
clear;
clc;

Ts = 1/200; %sample rate (s)
t=-2:Ts:2; %time scale with increments at frequency
g1 = rectangularPulse(t); %g1 and g2 are seperate functions
g2 = cos(200*pi*t);

%Full function that is to be transformed
g3 = 2 .* g1 .* g2;

%Plotting just the function
subplot(2,1,1)
plot(t,g3)
axis([-.6 .6 -2.2 2.2])
xlabel(['Time (s) ' num2str(Ts) ' seconds'])
ylabel('Amplitude')
title('g(t)')
%Fast Fourier Transform
fFunc = fft(g3);
fs = 1/Ts;

fa = (0:length(fFunc)-1)*fs;


%Plot the transformed function
subplot(2,1,2)
plot(fa,abs(fFunc))
xlabel(['Frequency (Hz) @ ' num2str(fs) ' sample rate'])
ylabel('Magnitude')
title('Magnitude')
%% Comparison of the values found analytically
clear;
clc;

Ts = 1/200; %sample rate (s)
t=-2:Ts:2; %time scale with increments at frequency

g1 = rectangularPulse(t); %g1 and g2 are seperate functions
g2 = cos(200*pi*t);

G1 = fft(g1);
G2 = fft(g2);
G3 = conv(G1,G2);

G = 2 .* G3;
fs = 1/Ts;

fa = (0:length(G)-1)*fs;

n = 4;
qa = 2;
f0 = 1/64;
N0 = n/f0;
[Gp,Gm]=cart2pol(real(G),imag(G));
k=0:(N0 - 1);k=k';
fvec = k/(N0*f0);
w=2*pi*k/n;


subplot(2,1,1)
plot(fa,abs(G))
axis([-.6 .6 -2.2 2.2])
xlabel(['Time (s) ' num2str(fs) ' seconds'])
ylabel('Magnitude')
title('G(f)')


set(gca,'FontName','Times','FontSize',10);
subplot(211),f31a=stem(fvec(1:32),Gm(1:32),'b');grid;
title('Magnitude');xlabel('{\it{f}}Hz');ylabel('|{\it{G}}({\it{f}})|');
Gthy=1./(G+1i*2*pi*fvec);
[Gthyp,Gthym]=cart2pol(real(Gthy),imag(Gthy));
subplot(211),hold on; f31c=plot(fvec(1:32),Gthym(1:32),'k-');
set(f31a,'Linewidth',1);

clc;
%% Question 2.10-1 (a)
% Following the example in Sec 2.10.3 and numerically calculate the average
% power of the following signals:
% (a) The signal waveform of Figure P2.8-4(b)
% e^(-t/10) w/T0 (period) of 0 -> 2pi and an amplitude of 1
clc;
clear;
T0a = 2*pi;
coeffa = 1/T0a;
uBounda = T0a/2;
lBounda = -1*uBounda;
fa =@(t) exp(-t/5); %function squared ^2 (in doing so is the absolute value)
qa = coeffa * (integral(fa,lBounda,uBounda));
msga = ['Signal Power of (a) is ' num2str(qa) '(W).'];
disp(msga);

% (b) The function t^3 at amp -8 to 8 with a period of -2 to 2
T0b = 4;
coeffb = 1/T0b;
uBoundb = T0b/2;
lBoundb = -1*uBoundb;
fb =@(t) t.^6; %function squared ^2 (in doing so is the absolute value)
qb = coeffb * (integral(fb,lBoundb,uBoundb));
msgb = ['Signal Power of (b) is ' num2str(qb) '(W).'];
disp(msgb);

% (d) The func x(t)=-g(t)cos5pit in which g(t) = t^3
% NOTE the function from b has its value set as 0 at
% the period bounds -2 and 2 so the period would be the same
T0D = 4;
coeffD = 1/T0D;
uBoundD = T0D/2;
lBoundD = -1*uBoundD;
x = @(t) ((t.^3).*cos(5*pi*t)).^2;
qD = coeffD * (integral(x,lBoundD,uBoundD));
msgD = ['Signal Power of (d) is ' num2str(qD) '(W).'];
disp(msgD);
