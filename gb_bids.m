% GB_BIDS   This script convertes the raw data to BIDS format

% Initialization
% --------------

clc
clear vars
close all
dbstop if error

% Directories 
% -----------

% Add SPM 12, JSONLAB and dicm2nii to Matlab path
addpath('~/Dropbox/gabor_bandit/code/spm12')
addpath(genpath('~/Dropbox/gb_fmri/utilities/JSONLAB'))
addpath(genpath('~/Dropbox/gb_fmri/utilities/dicm2nii'))

% fMRI data
src_dir_fMRI = '~/Documents/gb_fmri_data/raw_data'; 
subj_dirs_fMRI = {'ccnb_7848'};

% BIDS directory
bids_dir = '~/Documents/gb_fmri_data/BIDS/ds_xxx';

% TODO: nochmal checken ob wir das auch brauchen                                                
bids_rn = 'README_bids_data.md';

% Subject specific run numbering
subj_runs = {[1 2 3 4 5 6 7]};

% Create main BIDS folder
if exist(bids_dir, 'dir')
    rmdir(bids_dir,'s')
    mkdir(bids_dir)
else
    mkdir(bids_dir)
end

% BIDS object 
% -----------

% Bids variables
bids_vars = [];
bids_vars.src_dir_fMRI = src_dir_fMRI; 
bids_vars.bids_dir = bids_dir;
bids_vars.bids_rn = bids_rn;
bids_vars.num_subs = 1;

% Bids object instance
bids = gb_bidsobj(bids_vars);

% BIDS conversion
% ---------------

% Cycle over participants
for i = 1:1 %numel(subj_dirs_beh)
    
    % Update participant infor
    bids.s = i; 
    bids.subj_dir_fMRI = subj_dirs_fMRI{i}; 
    bids.run = subj_runs{i}; 
    
    % Subject-wise BIDS conversion
    bids.bids_conv_part();
    
end

% Add group-level supplementary information 
% -----------------------------------------

bids.bids_suppl();
