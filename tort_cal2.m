function [mean_amp_norm, MI] = tort_cal2(data,phase_freq, amp_freq, position, AA, area_name)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% outputs
% MeanAmp = amplitude distribution per phase bin
% MI = tort index of modulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Use the routine below to look at specific pairs of frequency ranges:

Pf1 = phase_freq(1);
Pf2 = phase_freq(2);
Af1 = amp_freq(1);
Af2 = amp_freq(2);

[MI,MeanAmp] = ModIndex_v1(data,Pf1,Pf2,Af1,Af2,position);
mean_amp_norm = [MeanAmp,MeanAmp]/sum(MeanAmp);
% figure();
% bar(10:20:720,[MeanAmp,MeanAmp]/sum(MeanAmp),'k')
% xlim([0 720])
% ylim([0.01 0.1])
% set(gca,'xtick',0:360:720)
% xlabel('Phase (Deg)')
% ylabel('Amplitude')
% title({sprintf('%s', area_name), sprintf('%s phse of %d-%dHz to amp of %d-%dHz; MI = %s' , AA, Pf1, Pf2, Af1, Af2, num2str(MI))})
% % title(['MI = ' num2str(MI)])
end


