function [plot_com] = plot_comodulogram(confi, comodulogram_A1, AA)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
PhaseFreqVector     = confi.PhaseFreqVector;
AmpFreqVector       = confi.AmpFreqVector;
PhaseFreq_BandWidth = confi.PhaseFreq_BandWidth;
AmpFreq_BandWidth   = confi.AmpFreq_BandWidth;
color_axis          = confi.color_axis;
area_name           = confi.area_name;
toi                 = confi.toi;
figure();
como_avg = squeeze(nanmean(comodulogram_A1, 1));

%%%%%%%%%%%%%%%
%% if using Tort method
%%%%%%%%%%%%%%%

% plot_com = contourf(PhaseFreqVector+PhaseFreq_BandWidth/2,AmpFreqVector+AmpFreq_BandWidth/2,como_avg',30,'lines','none')


%%%%%
%% if using hilbert method
%%%%%%
plot_com = contourf(PhaseFreqVector(:, 2)-PhaseFreq_BandWidth/2, AmpFreqVector(:, 2)-AmpFreq_BandWidth/2,como_avg',30,'lines','none')

% pp = contourf(x_in, y_in,Comodulogram',30,'lines','none')
set(gca,'fontsize',14)
ylabel('Amplitude Frequency (Hz)')
xlabel('Phase Frequency (Hz)')
xlim([confi.xlimit(1) confi.xlimit(2)])
ylim([confi.ylimit(1) confi.ylimit(2)])

caxis(color_axis)
colorbar

title(sprintf('%s: %s; %.2f to %.2f secs', AA, area_name, toi(1), toi(2)));

end

