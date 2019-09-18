%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THESIS IMAGE GENERATOR - EXAMPLE                                        %
% Authors:  Mattia Giurato (mattia.giurato@polimi.it)                     %
% Date: 31/07/2019                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars
close all
clc

%% Data to be plotted in a figure
time = 0:0.1:2*pi;
omega_1 = sin(time);
omega_2 = sin(2*time);

%% Figure settings
FIG_NAME = 'sample_figure';

FIGURE_POSITION = [0, 0, 640,480];
TITLE_FONT_SIZE = 14.0;
LABEL_FONT_SIZE = 14.0;
LEGEND_FONT_SIZE = 14.0;

YL_SHIFT = [-0.06, 0.5, 0];

Y_LIM = [-1.1,+1.1];
Y_TIKS = Y_LIM(1):0.5:Y_LIM(2);

X_LIM = [time(1),time(end)];
X_TIKS = X_LIM(1):2:X_LIM(2);

DOWNSAMPLE_FACTOR = 1; 
%used to reduce by a factor DOWNSAMPLE_FACTOR the number of plotted points, 
%useful if the figure contains many lines and the figure can become heavy

%% Create figure
f_omega = figure('Position', FIGURE_POSITION);
hold on
plot(downsample(time, DOWNSAMPLE_FACTOR), downsample(omega_1, DOWNSAMPLE_FACTOR), '-')
plot(downsample(time, DOWNSAMPLE_FACTOR), downsample(omega_2, DOWNSAMPLE_FACTOR), '--')
hold off
grid on
box on
ylim(Y_LIM)
yticks(Y_TIKS)
xlim(X_LIM)
xticks(X_TIKS)
lgd = legend('$\omega_1$','$\omega_2$');
set(lgd, 'Interpreter', 'latex', 'Fontsize', LEGEND_FONT_SIZE, 'Orientation', 'horizontal', 'Location', 'southeast', 'Location', 'Best')
yl = ylabel('Angular velocity $\left[rad/s\right]$', 'Interpreter', 'latex', 'fontsize', LABEL_FONT_SIZE);
set(yl, 'Units', 'Normalized', 'Position', YL_SHIFT)
xlabel('Time $\left[s\right]$', 'Interpreter', 'latex', 'fontsize', LABEL_FONT_SIZE)
%title('Sample image', 'Interpreter', 'latex', 'fontsize', TITLE_FONT_SIZE) % do not put title in document, just in presentations

%% Make figures folder
ORIGINAL_PATH = pwd;
FIGURES_FOLDER_NAME = 'figures';
FIG_FIGURES_FOLDER_NAME = 'fig';
COMPRESSED_FIGURES_FOLDER_NAME = 'pdf_compressed';
ORIGINAL_FIGURES_FOLDER_NAME = 'pdf_original';

FIGURES_DESTINATION_PATH = strcat([ORIGINAL_PATH, filesep, FIGURES_FOLDER_NAME]);
FIG_FIGURES_DESTINATION_PATH = strcat([FIGURES_DESTINATION_PATH, filesep, FIG_FIGURES_FOLDER_NAME]);
COMPRESSED_FIGURES_DESTINATION_PATH = strcat([FIGURES_DESTINATION_PATH, filesep, COMPRESSED_FIGURES_FOLDER_NAME]);
ORIGINAL_FIGURES_DESTINATION_PATH = strcat([FIGURES_DESTINATION_PATH, filesep, ORIGINAL_FIGURES_FOLDER_NAME]);

if ~exist(FIGURES_DESTINATION_PATH, 'dir')
    mkdir(FIGURES_DESTINATION_PATH);
    mkdir(FIG_FIGURES_DESTINATION_PATH);
    mkdir(COMPRESSED_FIGURES_DESTINATION_PATH);
    mkdir(ORIGINAL_FIGURES_DESTINATION_PATH);
    
    cd(FIGURES_DESTINATION_PATH)
else
    disp('Destination folder already exist!!')
    overwrite_flag = input('Would you like to over-write plots? (y/n): ','s');
    if ~strcmpi(overwrite_flag,'y')
        cd(ORIGINAL_PATH)
        disp('STOPPED')
        return
    end
    
    cd(FIGURES_DESTINATION_PATH)
end

saveas(f_omega, FIG_NAME, 'pdf');
system(strcat(['pdfcrop ', FIG_NAME, '.pdf',' ', FIG_NAME, '.pdf']));
saveas(f_omega, FIG_NAME, 'fig');

%% Back to the original path
cd(ORIGINAL_PATH)

%% Final suggestion
if ismac
    % Code to run on Mac platform
elseif isunix
    system('./pdf_compresser.sh');
elseif ispc
    system('pdf_compresser.sh');
else
    disp('Platform not supported')
end

%% END OF CODE