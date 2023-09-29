function [y] = plotfft( x,FS )
% plot the single side amplitude spectrum of x(t)
% x:the original signal
% FS: the sampling frequency
% y: the discrete fourier transform of x(t)

x = x-mean(x);
xlen = max(size(x));
t = (0:xlen-1)/FS;
x = x(:)';
figure;
plot(t,x);
grid on;
xlabel('time/s');
ylabel('amp/mv');
title('time domain of the signal');
figure;
NFFT = 2^nextpow2(xlen);
y = fft(x,NFFT)/xlen;
f = FS/2*linspace(0,1,NFFT/2+1);
plot(f,2*abs(y(1:NFFT/2+1)));
title('frequency domain of the signal');
xlabel('frequency (Hz)');
ylabel('|y(f)|');
end

