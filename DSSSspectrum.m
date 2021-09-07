% EE252,Advanced digital communication systems 
% Student: An Vo
% -------------------------------------------------------------------------
% Plot DSSS spectrum
% ---------------------------------
a = 1; T=1;N=3;
D=100;
fT = -15:1/D:15;
len=length(fT);
zero_index=15*D+1;

%% Spectrum of PN sequence Sc
Sc=zeros(1,len);
Sc(zero_index)=1/N^2;
for j=-15:-1
  Sc(zero_index+j*D)=((N+1)/N^2)*sinc(-j/N)^2;
end
for j=1:15
  Sc(zero_index+j*D)=((N+1)/N^2)*sinc(-j/N)^2;
end

%% Spectrum of SRRC data pulse Sb
for i=1:len
    if abs( fT(i) ) <= (1-a)/2, Sb(i) = T;
    elseif abs( fT(i) ) > (1-a)/2 && abs( fT(i) ) <= (1+a)/2
        Sb(i) = (T/2)*( 1 + cos( (pi/a)*(abs(fT(i)) - (1-a)/2) ) );
    else, Sb(i)=0; end
end

%% Spectrum of DSSS signal (Convolution of Sc and Sb)
conv_result=conv(Sc,Sb);
Ss=conv_result((len+1)/2:(3*len-1)/2);

%% Plot them
plot(fT,Sb,'b','LineWidth',1.5);hold on;
plot(fT,Sc,'black','LineWidth',1.5);
plot(fT,Ss,'r','LineWidth',3),grid on, xlabel('Normalized frequency, fT');
legend("Spectrum of SRRC data pulse Sb","Spectrum of PN sequence Sc",...
    "Spectrum of DSSS signal Ss")



