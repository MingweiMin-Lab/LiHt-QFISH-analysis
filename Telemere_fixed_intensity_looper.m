clearvars

h = load('\\172.19.245.39\minlab_data\Groupfolder\Microscope\Gryffindor\CMOS\cmos.mat');
cmos = h.cmos;
width = size(cmos,1); 
heigth = size(cmos,2);
biasAll = ones(width,heigth,4);

h = load('\\172.19.245.39\minlab_data\Groupfolder\Microscope\Gryffindor\illumination_bias\Gryf_DAPI-20x-Fluorescein_2uM.mat');
biasAll(:,:,1) = h.bias;
% h = load('\\172.19.245.39\minlab_data\Groupfolder\Microscope\Gryffindor\illumination_bias\Gryf_cy3_595_20x_220122.mat');
% biasAll(:,:,2) = h.bias;
h = load('\\172.19.245.39\minlab_data\Groupfolder\Microscope\Gryffindor\illumination_bias\Gryf_FITC_20x_211122.mat');
biasAll(:,:,2) = h.bias;
% h = load('\\172.19.245.39\minlab_data\Groupfolder\Microscope\Gryffindor\illumination_bias\Gryf_cy5_20x_20220725.mat');
% biasAll(:,:,4) = h.bias;

nd2Path = '\\172.19.245.39\minlab_image1\Qingyang\20250225_telomere_timelapse\fixed_telomere\20250228_131311_529\';
nuc_maskPath = '\\172.19.245.39\minlab_image1\Qingyang\20250225_telomere_timelapse\prepro\nuc_mask\';
real_telomerePath = '\\172.19.245.39\minlab_image1\Qingyang\20250225_telomere_timelapse\prepro\telomere_imopen_signal\';
telomere_mask_outPath = '\\172.19.245.39\minlab_image1\Qingyang\20250225_telomere_timelapse\prepro\telomere_mask\';
cell_infor_outPath = 'E:\test\';

row = 5;
col = 10;
site = 1;
telomere_channel = 2;

d = combvec_mm(row,col,site);
% p = parpool(6);
for i = 1:size(d,1)
    row = d(i,1);
    col = d(i,2);
    site = d(i,3); 
    obj = dot_signal_TimelessM;
    obj = initiate(obj,'row', row,...
        'col',col,...
        'site',site,...
        'bias',biasAll,...
        'cmos', cmos,...
        'fileType','nd2',...
        'imagePath',nd2Path,...
        'maskPath', nuc_maskPath,...
        'outPath', cell_infor_outPath);
    obj = telomere_SignalExtract(obj,real_telomerePath,telomere_mask_outPath,telomere_channel);
end
% delete(p)