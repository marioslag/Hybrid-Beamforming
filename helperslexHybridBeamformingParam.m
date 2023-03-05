function paramHybridBF = helperslexHybridBeamformingParam

Ns=2;          % Number of signal stream 
M=16;          % M-QAM, M=16, the QAM modulator is 16-QAM
Nt = 64;       % Number of Tx antenna array elements 
NtRF = 4;      % Number of Tx RF chains 
Nr = 16;       % Number of Rx antenna array elements
NrRF = 4;      % Number of Rx RF chains
SNR=2;         % SNR of the MIMO channel(linear)
NTxSym=1000;   % Number of symbols for an estimated MIMO channel

c = 3e8;             % Speed of light
fc = 28e9;           % Carrier frequency 
lambda = c/fc;       % Wavelength 

txarray = phased.URA([sqrt(Nt) sqrt(Nt)],lambda/2);
rxarray = phased.URA([sqrt(Nr) sqrt(Nr)],lambda/2);
txpos = getElementPosition(txarray)/lambda;              
rxpos = getElementPosition(rxarray)/lambda;  

Ngrid=2^3;  % each dimension has 8 bins
datxangle=80/(Ngrid);  % Tx azimuth resolution = range / angle points.  Range from -40 degree to 40 degree
detxangle=40/(Ngrid);  % Tx elevation resolutiuoin = range /angle points. Range from -20 to 20 degree 
darxangle=120/(Ngrid);  % Rx azimuth resolution = range / angle points    Range -60 to 60 degree 
derxangle=80/(Ngrid);  % Rx elevation resolutiuoin = range /angle points Range from -40 to 40 degree 

%Create the discrete search angles for Frf base vector search 

txangF=zeros(2,(Ngrid+1)^2); 
rxangW=zeros(2,(Ngrid+1)^2); 

for i1=1:Ngrid+1
    for i2=1:Ngrid+1
        n=(i1-1)*(Ngrid+1)+i2;
        txangF(1,n)=-40+(i1-1)*datxangle;
        txangF(2,n)=-20+(i2-1)*detxangle;
        
        rxangW(1,n)= -60+(i1-1)*darxangle;
        rxangW(2,n)= -40+(i2-1)*derxangle;
    end
end

paramHybridBF.Ns = Ns;
paramHybridBF.M = M;
paramHybridBF.Nt = Nt;
paramHybridBF.Nr = Nr;
paramHybridBF.NtRF = NtRF;
paramHybridBF.NrRF = NrRF;
paramHybridBF.SNR = SNR;
paramHybridBF.NTxSym = NTxSym;
paramHybridBF.c = c;
paramHybridBF.fc = fc;
paramHybridBF.lambda = lambda;
paramHybridBF.TxPos = txpos;
paramHybridBF.RxPos = rxpos;
paramHybridBF.TxAngF = txangF;
paramHybridBF.RxAngW = rxangW;

assignin('base','paramHybridBF',paramHybridBF)




