function [data_out_perm] = prepoc_hilbert_PAC(data_raw, frequencyranges, final_ouput )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if length(data_raw.trial) == 1 
    dat_out =[];
    for i = 1:size(frequencyranges,1)
    cfg = [];
    cfg.bpfilter = 'yes';
    cfg.bpfreq = [frequencyranges(i, 1) frequencyranges(i, 2)];
    cfg.bpfilttype = 'fir';
    cfg.hilbert = final_ouput;
    data_freq = ft_preprocessing(cfg, data_raw);

    dat_out(1, i, :) = data_freq.trial{1, 1}  ;

    end
    data_out_perm.powspctrm = dat_out;
    data_out_perm.label = data_raw.label;
    data_out_perm.dimord = 'chan_freq_time';
    data_out_perm.time = data_freq.time{1, 1};
    data_out_perm.freq = frequencyranges(:, 2)';
    data_out_perm.label2 = data_raw.label2;
    data_out_perm.elec = data_raw.elec;
%     data_out_perm.cumtapcnt = ones(size(data_out_perm.powspctrm, 1), size(data_out_perm.powspctrm, 2));

else


    
dat_out=[]; 
for i = 1:size(frequencyranges,1)
cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = [frequencyranges(i, 1) frequencyranges(i, 2)];
cfg.bpfilttype = 'but';
% cfg.bpfiltord     = 4;
% cfg.bpfiltdir = 'twopass';
%  
cfg.hilbert = final_ouput;
data_freq = ft_preprocessing(cfg, data_raw);

dat_out(:, i, :, :) = fieldtrip2mat_epochs(data_freq);

end

data_out_perm.powspctrm =  permute(dat_out, [4, 1, 2, 3]);


data_out_perm.label = data_raw.label;
data_out_perm.dimord = 'rpt_chan_freq_time';
data_out_perm.time = data_freq.time{1, 1};
data_out_perm.freq = frequencyranges(:, 2)';
data_out_perm.cumtapcnt = ones(size(data_out_perm.powspctrm, 1), size(data_out_perm.powspctrm, 3));
data_out_perm.label2 = data_raw.label2;
data_out_perm.elec = data_raw.elec;



end
end


