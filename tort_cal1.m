function [position, Comodulogram, Comodulogram_swap] = tort_cal1(data, nbin, PhaseFreqVector, AmpFreqVector,PhaseFreq_BandWidth, AmpFreq_BandWidth, AA, area_name)
%UNTITLED2 Summary of this function goes here
%% output
% Comodulogram = comodulogram for the data
% Comodulogram_swap = comodulogram for data where half of the data points are randomly swapped    
%% Define phase bins

nbin = 18; % number of phase bins
position=zeros(1,nbin); % this variable will get the beginning (not the center) of each phase bin (in rads)
winsize = 2*pi/nbin;
for j=1:nbin 
    position(j) = -pi+(j-1)*winsize; 
end

%% Filtering and Hilbert transform

'CPU filtering'
data_length = length(data.trial{1,1})
% data_length = length(data);

Comodulogram=single(zeros(length(PhaseFreqVector),length(AmpFreqVector)));
AmpFreqTransformed = zeros(length(AmpFreqVector), data_length);
PhaseFreqTransformed = zeros(length(PhaseFreqVector), data_length);


for ii=1:length(AmpFreqVector)
    
    freq_A1 = [];
%     Af1 = AmpFreqVector(ii);
    %%%%%%%%%%
    %%% if using hilbert
    %%%%%%%%%%
    
%     Af2=Af1+AmpFreq_BandWidth(ii);

%%%%%%%%
%%% if not using hilbert
%%%%%%%%%%
%     Af2=Af1+AmpFreq_BandWidth;

    Af1 = AmpFreqVector(ii, 1);
    Af2 = AmpFreqVector(ii, 2);

    
%     AmpFreq=eegfilt(data.trial{1, 1}  ,data.fsample,Af1,Af2, 0 ,2); % filtering
%     AmpFreqTransformed(ii, :) = abs(hilbert(AmpFreq)); % getting the amplitude envelope
%     AmpFreqTransformed_swap(ii, :) = [AmpFreqTransformed(ii, round(size(AmpFreqTransformed(ii, :), 2)/2) + 1:end) AmpFreqTransformed(ii, 1: round(size(AmpFreqTransformed(ii, :), 2)/2))];

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%% if using hilbert transform
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [ freq_A1] = prepoc_hilbert_PAC_v2(data, [Af1 Af2], 'abs' );
    if length(data.trial) == 1
        AmpFreqTransformed(ii, :) = freq_A1.powspctrm;
        AmpFreqTransformed_swap(ii, :) = [freq_A1.powspctrm(round(size(freq_A1.powspctrm, 2)/2) + 1:end) freq_A1.powspctrm(1: round(size(freq_A1.powspctrm, 2)/2))];
      
    else
    AmpFreqTransformed(ii, :) = squeeze(mean(freq_A1.powspctrm  , 1))';
    pwspctm = squeeze(mean(freq_A1.powspctrm  , 1))';
    AmpFreqTransformed_swap(ii, :) = [pwspctm(round(size(pwspctm, 2)/2) + 1:end) pwspctm(1: round(size(pwspctm, 2)/2))];

    end
    
end

for jj=1:length(PhaseFreqVector)
    freq_A1 = [];
%     Pf1 = PhaseFreqVector(jj);
        %%%%%%%%%%
    %%% if using hilbert
    %%%%%%%%%%
    

%     Pf2 = Pf1 + PhaseFreq_BandWidth(jj);

        %%%%%%%%%%
    %%% if using hilbert
    %%%%%%%%%%
%     Pf2 = Pf1 + PhaseFreq_BandWidth;
    

    Pf1 = PhaseFreqVector(jj, 1);
    Pf2 = PhaseFreqVector(jj, 2);

    
%     PhaseFreq=eegfilt(data.trial{1, 1}  ,data.fsample,Pf1,Pf2, 0, 2); % filtering 
%     PhaseFreqTransformed(jj, :) = angle(hilbert(PhaseFreq)); % getting the phase time series
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%% if using hilbert transform
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [freq_A1] = prepoc_hilbert_PAC_v2(data, [Pf1 Pf2], 'angle' );
        if length(data.trial) == 1
        PhaseFreqTransformed(jj, :) = freq_A1.powspctrm;
    else
    PhaseFreqTransformed(jj, :) = squeeze(circ_mean(freq_A1.powspctrm  , [], 1))';
        end
end


%% Compute MI and comodulogram

'Comodulation loop'

counter1=0;
for ii=1:length(PhaseFreqVector)
counter1=counter1+1;
% 
%     Pf1 = PhaseFreqVector(ii);
        %%%%%%%
        %% if using hilbert
        %%%%%%%
%     Pf2 = Pf1+PhaseFreq_BandWidth(ii);
    
            %%%%%%%
        %% if NOT using hilbert
        %%%%%%%
%       Pf2 = Pf1+PhaseFreq_BandWidth;

    Pf1 = PhaseFreqVector(ii, 1);
    Pf2 = PhaseFreqVector(ii, 2);
% 
    counter2=0;
    for jj=1:length(AmpFreqVector)
    counter2=counter2+1;
    
%         Af1 = AmpFreqVector(jj);
        %%%%%%%
        %% if using hilbert
        %%%%%%%
%         Af2 = Af1+AmpFreq_BandWidth(jj);
        %%%%%%%
        %% if NOT using hilbert
        %%%%%%%
%         Af2 = Af1+AmpFreq_BandWidth;

        Af1 = AmpFreqVector(jj, 1);
        Af2 = AmpFreqVector(jj, 2);

    
        [MI, MeanAmp]=ModIndex_v2(PhaseFreqTransformed(ii, :), AmpFreqTransformed(jj, :), position);
        [MI_swap, MeanAmp]=ModIndex_v2(PhaseFreqTransformed(ii, :), AmpFreqTransformed_swap(jj, :), position);

        Comodulogram(counter1,counter2)= MI;
        Comodulogram_swap(counter1,counter2)= MI_swap;

    end
end




end

