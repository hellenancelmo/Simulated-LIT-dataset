% Code Written by Hellen C Ancelmo 
% Universidade Tecnológica Federal do Paraná
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDRÉ EUGÊNIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.

clear all
close all
warning off
clc


%% ---------------------Parameters--------------------- %%

% Universal Motor
load('parametros_motor')

wmo_1 = 1500*(2*pi)/60; 
wmo_2 = 1200*(2*pi)/60; 
wmo_3 = 1000*(2*pi)/60;
wmo_4 = 800*(2*pi)/60; 

% Full Brigde
C21 = 100e-6;
R21 = 2e3;
C22 = 100e-6;
R22 = 1e3;
C23 = 220e-6;
R23 = 500;
C24 = 330e-6;
R24 = 300;

% Resistor
R31 = 2.5;
R32 = 5;
R33 = 8;
R34 = 10;

% Resistor and Inductor
R41 = 10;
L41 = 10e-3;
R42 = 20;
L42 = 10e-3;
R43 = 30;
L43 = 10e-3;
R44 = 30;
L44 = 100e-3;

% Thyristor R
R51 = 10;
R52 = 12;
R53 = 15;
R54 = 20;
Valpha5 = 60;

% Thyristor RL
R61 = 10;
L61 = 1e-3;
R62 = 5;
L62 = 1e-3;
R63 = 30;
L63 = 1e-3;
R64 = 105;
L64 = 1e-3;
Valpha6 = 60;

% Diode R
R71 = 5;
R72 = 10;
R73 = 20;
R74 = 50;

%% ---------------------Simulink Blocks--------------------- %%

simu_1 = ["Motor_1" "Motor_2" "Motor_3" "Motor_4" "Ponte_1" "Ponte_2" "Ponte_3" "Ponte_4" "Circuito_R_1" "Circuito_R_2" "Circuito_R_3" "Circuito_R_4" ...
         "Circuito_RL_1" "Circuito_RL_2" "Circuito_RL_3" "Circuito_RL_4" "Retificador_R_1" "Retificador_R_2" "Retificador_R_3" "Retificador_R_4"...
         "Retificador_RL_1" "Retificador_RL_2" "Retificador_RL_3" "Retificador_RL_4" "Diodo_1" "Diodo_2" "Diodo_3" "Diodo_4"];



label_corrente = ["corrente_motor_1" "corrente_motor_2" "corrente_motor_3" "corrente_motor_4" "corrente_ponte_1" "corrente_ponte_2" "corrente_ponte_3'" "corrente_ponte_4" ...
                  "corrente_r_1" "corrente_r_2" "corrente_r_3" "corrente_r_4" "corrente_rl_1" "corrente_rl_2" "corrente_rl_3" "corrente_rl_4" ...
                  "corrente_tiristor_r_1" "corrente_tiristor_r_2" "corrente_tiristor_r_3" "corrente_tiristor_r_4" ...
                  "corrente_tiristor_rl_1" "corrente_tiristor_rl_2" "corrente_tiristor_rl_3" "corrente_tiristor_rl_4"...
                  "corrente_diodo_1" "corrente_diodo_2" "corrente_diodo_3" "corrente_diodo_4"];
                
label_tensao = ["tensao_motor_1" "tensao_motor_2" "tensao_motor_3" "tensao_motor_4" "tensao_ponte_1" "tensao_ponte_2" "tensao_ponte_3" "tensao_ponte_4" ...
                "tensao_r_1" "tensao_r_2" "tensao_r_3" "tensao_r_4" "tensao_rl_1" "tensao_rl_2" "tensao_rl_3" "tensao_rl_4"...
                "tensao_tiristor_r_1" "tensao_tiristor_r_2" "tensao_tiristor_r_3" "tensao_tiristor_r_4" ...
                "tensao_tiristor_rl_1" "tensao_tiristor_rl_2" "tensao_tiristor_rl_3" "tensao_tiristor_rl_4" ...
                "tensao_diodo_1" "tensao_diodo_2" "tensao_diodo_3" "tensao_diodo_4"];
                
blocos_cargas = ["MOTOR_UNIVERSAL_1" "MOTOR_UNIVERSAL_2" "MOTOR_UNIVERSAL_3" "MOTOR_UNIVERSAL_4" "PONTE_DIODO_1" "PONTE_DIODO_2" ...
                "PONTE_DIODO_3" "PONTE_DIODO_4" "R_1" "R_2" "R_3" "R_4" "RL_1" "RL_2" "RL_3" "RL_4" "TIRISTOR_R_1" "TIRISTOR_R_2" ...
                "TIRISTOR_R_3" "TIRISTOR_R_4" "TIRISTOR_RL_1" "TIRISTOR_RL_2" "TIRISTOR_RL_3" "TIRISTOR_RL_4" "DIODO_1" ...
                "DIODO_2" "DIODO_3" "DIODO_4"];
blocos_on_off = ["ON_OFF_1" "ON_OFF_2" "ON_OFF_3" "ON_OFF_4" "ON_OFF_5" "ON_OFF_6" "ON_OFF_7" "ON_OFF_8" "ON_OFF_9" "ON_OFF_10" ...
                "ON_OFF_11" "ON_OFF_12" "ON_OFF_13" "ON_OFF_14" "ON_OFF_15" "ON_OFF_16" "ON_OFF_17" "ON_OFF_18" "ON_OFF_19" "ON_OFF_20" ...
                "ON_OFF_21" "ON_OFF_22" "ON_OFF_23" "ON_OFF_24" "ON_OFF_25" "ON_OFF_26" "ON_OFF_27" "ON_OFF_28"];


%% ---------------------Database Type--------------------- %%

% % Ideal Scenario
simulacao = 'Sim_Ideal';

% % Scenario with leakege inductance
% simulacao = 'Sim_Induct';

% Scenario with leakege inductance and harmonic 
% simulacao = 'Sim_Induct_Harmon';


%% ---------------------Blocks of Simulink--------------------- %%

for i=1:28
set_param(sprintf('%s/%s',simulacao,blocos_cargas(i)),'commented','on'); 
set_param(sprintf('%s/%s',simulacao,blocos_on_off(i)),'commented','on'); 
end    

%% ---------------------Database Parameters--------------------- %%

num_cargas = 28;
sim_on=50*ones(1,num_cargas);
sim_off=sim_on;  

ciclo = 1/60;
disparo = 1/240;
decim = 65;

                
%% ---------------------One Load in the same waveform--------------------- %%

% t_total = 2.5;
% 
% run('individual')

%% ---------------------Two Loads in the same waveform--------------------- %%
% t_total = 6;
% 
% run('double')


%% ---------------------Three Loads in the same waveform--------------------- %%

% t_total = 10;
% 
% run('triple')
%% ---------------------Four Loads in the same waveforms--------------------- %%
% 
% t_total = 13;
% 
% run('fourfold')
%% ---------------------Five Loads in the same waveform--------------------- %%

t_total = 16;
% 
% run('quintuple')

%% ---------------------Six Loads in the same waveform--------------------- %%
% 
% t_total = 20;
% 
% run('sixfold')
%% ---------------------Seven Loads in the same waveform--------------------- %%
% t_total = 25;
% 
% run('sevenfold')

%% --------------------- Blocks of Simulink --------------------- %%
for i=1:28
set_param(sprintf('%s/%s',simulacao,blocos_cargas(i)),'commented','off'); 
set_param(sprintf('%s/%s',simulacao, blocos_on_off(i)),'commented','off'); 
end 
