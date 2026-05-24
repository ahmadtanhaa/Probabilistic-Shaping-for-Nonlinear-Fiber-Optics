% Reproduce Figs. 2 and 3 of:
% "On the Impact of Probabilistic Shaping on Fiber Nonlinearities," ICEE 2022.
% A. Tanha, H. Rabbani, and L. Beygi,

% Scenario I: probabilistic shaping is applied only to the channel of
% interest (COI). Interfering WDM channels remain uniform 16-QAM.

clear; clc; close all;
rng(1);

if ~exist('results','dir')
    mkdir('results');
end

%% Paper settings
params.gamma = 1.3;                      % Nonlinearity coefficient [1/W/km]
params.beta2 = 21.6;                     % Dispersion coefficient [ps^2/km]
params.alpha = 0.22;                     % Fiber loss coefficient [dB/km]
params.PdBm = 5;                         % Input launch power [dBm]
params.BaudRate = 32;                    % Symbol rate [GBaud]
params.ChSpacing = 1.05*params.BaudRate; % WDM channel spacing [GHz]
params.N = 1e6;                          % Monte-Carlo integration points
params.lambda = 1550e-9;                 % Laser wavelength [m]
params.Nf = 5.5;                         % EDFA noise figure [dB]
params.c = 3e8;                          % Speed of light [m/s]
params.h = 6.626e-34;                    % Planck constant [J.s]
params.Nspan = 1:10;                     % Number of spans
params.L = 80;                           % Span length [km]
params.n_ch = 9;                         % Number of WDM channels

%% 16-QAM shaping moments for P1, P2, P3, and P4
kur_COI  = [1.32 1.4937 1.6084 1.6787];
kur3_COI = [1.96 2.6273 3.1472 3.5095];
kur_INT  = 1.32;                         % Uniform 16-QAM interfering channels

[SCI, XCI, MCI, NLI, SNR_eff, SER, distance] = compute_metrics(params, kur_COI, kur3_COI, kur_INT);

%% Paper-style plot settings
blue   = [0.0000 0.4470 0.7410];
red    = [0.8500 0.3250 0.0980];
yellow = [1.0000 1.0000 0.0000];
purple = [0.4940 0.1840 0.5560];
green  = [0.0000 1.0000 0.0000];
line_width = 1.2;
figure_position = [100 100 430 330];

%% Fig. 2(a): SCI over distance
fig = figure('Color','w','Name','Fig. 2(a) - Scenario I SCI');
set(fig,'Units','pixels','Position',figure_position);
plot(distance,SCI(1,:),'-', 'Color',blue,   'LineWidth',line_width); hold on;
plot(distance,SCI(2,:),'--','Color',red,    'LineWidth',line_width);
plot(distance,SCI(3,:),':', 'Color',yellow, 'LineWidth',line_width);
plot(distance,SCI(4,:),'-.','Color',purple, 'LineWidth',line_width);
grid on; box on;
xlim([80 800]); ylim([0 3000]);
set(gca,'XTick',[200 400 600 800],'FontName','Times New Roman','FontSize',10);
xlabel('Distance [km]');
ylabel('SCI [W^{-2}]');
title('(a) SCI over distance','FontWeight','bold');
legend('P_1','P_2','P_3','P_4','Location','best');
saveas(fig,'results/fig2a_scenario1_SCI.fig');
print(fig,'results/fig2a_scenario1_SCI.png','-dpng','-r300');

%% Fig. 2(b): XCI over distance
fig = figure('Color','w','Name','Fig. 2(b) - Scenario I XCI');
set(fig,'Units','pixels','Position',figure_position);
plot(distance,XCI(1,:),'-','Color',yellow,'LineWidth',line_width);
grid on; box on;
xlim([80 800]); ylim([0 4000]);
set(gca,'XTick',[200 400 600 800],'FontName','Times New Roman','FontSize',10);
xlabel('Distance [km]');
ylabel('XCI [W^{-2}]');
title('(b) XCI over distance','FontWeight','bold');
legend('P_1 - P_4','Location','best');
saveas(fig,'results/fig2b_scenario1_XCI.fig');
print(fig,'results/fig2b_scenario1_XCI.png','-dpng','-r300');

%% Fig. 2(c): MCI over distance
fig = figure('Color','w','Name','Fig. 2(c) - Scenario I MCI');
set(fig,'Units','pixels','Position',figure_position);
plot(distance,MCI(1,:),'-','Color',green,'LineWidth',line_width);
grid on; box on;
xlim([80 800]); ylim([0 600]);
set(gca,'XTick',[200 400 600 800],'FontName','Times New Roman','FontSize',10);
xlabel('Distance [km]');
ylabel('MCI [W^{-2}]');
title('(c) MCI over distance','FontWeight','bold');
legend('P_1 - P_4','Location','best');
saveas(fig,'results/fig2c_scenario1_MCI.fig');
print(fig,'results/fig2c_scenario1_MCI.png','-dpng','-r300');

%% Fig. 3(a): NLI over distance
fig = figure('Color','w','Name','Fig. 3(a) - Scenario I NLI');
set(fig,'Units','pixels','Position',figure_position);
plot(distance,NLI(1,:),'-', 'Color',blue,   'LineWidth',line_width); hold on;
plot(distance,NLI(2,:),'--','Color',red,    'LineWidth',line_width);
plot(distance,NLI(3,:),':', 'Color',yellow, 'LineWidth',line_width);
plot(distance,NLI(4,:),'-.','Color',purple, 'LineWidth',line_width);
grid on; box on;
xlim([80 800]); ylim([0 8000]);
set(gca,'XTick',[200 400 600 800],'FontName','Times New Roman','FontSize',10);
xlabel('Distance [km]');
ylabel('NLI [W^{-2}]');
title('(a) NLI over distance','FontWeight','bold');
legend('P_1','P_2','P_3','P_4','Location','best');
saveas(fig,'results/fig3a_scenario1_NLI.fig');
print(fig,'results/fig3a_scenario1_NLI.png','-dpng','-r300');

%% Fig. 3(b): Effective SNR over distance
fig = figure('Color','w','Name','Fig. 3(b) - Scenario I Effective SNR');
set(fig,'Units','pixels','Position',figure_position);
plot(distance,SNR_eff(1,:),'-', 'Color',blue,   'LineWidth',line_width); hold on;
plot(distance,SNR_eff(2,:),'--','Color',red,    'LineWidth',line_width);
plot(distance,SNR_eff(3,:),':', 'Color',yellow, 'LineWidth',line_width);
plot(distance,SNR_eff(4,:),'-.','Color',purple, 'LineWidth',line_width);
grid on; box on;
xlim([80 800]); ylim([10 25]);
set(gca,'XTick',[200 400 600 800],'FontName','Times New Roman','FontSize',10);
xlabel('Distance [km]');
ylabel('SNR_{eff} [dB]');
title('(b) Effective SNR over distance','FontWeight','bold');
legend('P_1','P_2','P_3','P_4','Location','best');
saveas(fig,'results/fig3b_scenario1_SNR_eff.fig');
print(fig,'results/fig3b_scenario1_SNR_eff.png','-dpng','-r300');

%% Fig. 3(c): SER over distance
fig = figure('Color','w','Name','Fig. 3(c) - Scenario I SER');
set(fig,'Units','pixels','Position',figure_position);
plot(distance,SER(1,:),'-', 'Color',blue,   'LineWidth',line_width); hold on;
plot(distance,SER(2,:),'--','Color',red,    'LineWidth',line_width);
plot(distance,SER(3,:),':', 'Color',yellow, 'LineWidth',line_width);
plot(distance,SER(4,:),'-.','Color',purple, 'LineWidth',line_width);
grid on; box on;
xlim([80 800]); ylim([0 0.25]);
set(gca,'XTick',[200 400 600 800],'FontName','Times New Roman','FontSize',10);
xlabel('Distance [km]');
ylabel('SER');
title('(c) SER over distance','FontWeight','bold');
legend('P_1','P_2','P_3','P_4','Location','best');
saveas(fig,'results/fig3c_scenario1_SER.fig');
print(fig,'results/fig3c_scenario1_SER.png','-dpng','-r300');

%% Local computation functions
function [SCI, XCI, MCI, NLI, SNR_eff, SER, distance] = compute_metrics(params, kur_COI, kur3_COI, kur_INT)
P = 10^((params.PdBm-30)/10);
Nm = floor(params.n_ch/2)+1;
nP = numel(kur_COI);
nD = numel(params.Nspan);

SCI = zeros(nP,nD);
XCI = zeros(nP,nD);
MCI = zeros(nP,nD);
ASE = zeros(1,nD);

PD_norm = 0;
P0 = 1;
alpha_norm = params.alpha/10*log(10);
TP = 1000/params.BaudRate;
beta2_norm = params.beta2/(TP^2);
ChSpacing_norm = params.ChSpacing/params.BaudRate;

for i = 1:nD
    [gn_chi1,chi11,chi21,chi13,chi23,chi14,chi24,chi34] = calc_interChannel( ...
        params.n_ch, params.gamma, beta2_norm, alpha_norm, params.Nspan(i), ...
        params.L, PD_norm, P0, 1, 1, params.N, ChSpacing_norm);

    ASE(i) = params.h*params.c*10^(params.Nf/10)*params.BaudRate*1e9* ...
        params.Nspan(i)*(exp(alpha_norm*params.L)-1)/params.lambda;

    for p = 1:nP
        NLIN = chi11 + (kur_INT-2)*chi21 + chi13 + (kur_INT-2)*chi23 + ...
            chi14 + (kur_COI(p)-2)*chi24 + ...
            (kur3_COI(p)-9*kur_COI(p)+12)*chi34 + gn_chi1;

        XPM = 2*sum(NLIN(:,Nm,Nm,2)) - 2*NLIN(Nm,Nm,Nm,2);
        XCI(p,i) = XPM + NLIN(Nm-1,Nm,Nm,3) + NLIN(Nm,Nm+1,Nm,1) + ...
            NLIN(Nm,Nm-1,Nm,3) + NLIN(Nm+1,Nm,Nm,1) + ...
            NLIN(Nm,Nm,Nm,1) + NLIN(Nm,Nm,Nm,3) + ...
            NLIN(Nm-1,Nm-1,Nm,3) + NLIN(Nm+1,Nm+1,Nm,1);

        SCI(p,i) = NLIN(Nm,Nm,Nm,2);
        MCI(p,i) = sum(sum(sum(NLIN(:,:,Nm,:)))) - SCI(p,i) - XCI(p,i);
    end
end

NLI = SCI + XCI + MCI;
noise_var = abs(P^3*NLI) + ASE;
noise_std = sqrt(noise_var);

constellation_energy = [10 7.7156 6.5385 5.8919];
ser_factor = [0.75 0.821388888888889 0.8581712962962965 0.8783796296296296];
SER = zeros(size(NLI));

for p = 1:nP
    dmin = 2*sqrt((P/2)/constellation_energy(p));
    Pe = ser_factor(p)*2*qfunc_local(dmin./noise_std(p,:));
    SER(p,:) = 1 - (1-Pe).^4;
end

SNR_eff = 10*log10(P./(ASE + P^3*NLI));
distance = params.Nspan*params.L;
end

function y = qfunc_local(x)
y = 0.5*erfc(x/sqrt(2));
end
