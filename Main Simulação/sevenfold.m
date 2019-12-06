% Code Written by Hellen C Ancelmo 
% Universidade Tecnol�gica Federal do Paran�
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDR� EUG�NIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.



cd('C:\Users\USUARIO\Documents\Simulacoes\Vetores Rand')

% Vetor de Combina��o de Disparo de 3 cargas
load('50_comb_7_cargas')
cargas = y;

% Vetor de Combina��o de Angulo de Disparo 
% [1 2 3] -> Referente ao Label de Combina��o -> [0 1/240 1/120]
% Primeira combina��o sempre [1 1 ..]
load('10_comb_disp_7_cargas')
disp = y;
% Label de Combina��o dos angulos de disparo
label_disp = [0 1/240 1/120];


count = 2985;

for i=1:length(cargas)
    sim1 = cargas(i,1);
    sim2 = cargas(i,2);
    sim3 = cargas(i,3);
    sim4 = cargas(i,4);
    sim5 = cargas(i,5);
    sim6 = cargas(i,6);
    sim7 = cargas(i,7);
    
    for j=1:length(disp)
        c1 = disp(j,1);
        c1 = label_disp(c1);
        c2 = disp(j,2);
        c2 = label_disp(c2);
        c3 = disp(j,3);
        c3 = label_disp(c3);
        c4 = disp(j,4);
        c4 = label_disp(c4);
        c5 = disp(j,5);
        c5 = label_disp(c5);
        c6 = disp(j,6);
        c6 = label_disp(c6);
        c7 = disp(j,7);
        c7 = label_disp(c7);
                if 17<=sim1 && sim1<=24
                    c1 = 0;
                end
                if 17<=sim2 && sim2<=24
                    c2 = 0;
                end
                if 17<=sim3 && sim3<=24
                    c3 = 0;
                end
                if 17<=sim4 && sim4<=24
                    c4 = 0;
                end
                if 17<=sim5 && sim5<=24
                    c5 = 0;
                end
                if 17<=sim6 && sim6<=24
                    c6 = 0;
                end
                if 17<=sim7 && sim7<=24
                    c7 = 0;
                end

            
                tic

                on_1 = ((1/60)*20)+c1;
                on_2 = ((1/60)*120)+c2;
                on_3 = ((1/60)*220)+c3;
                on_4 = ((1/60)*320)+c4;
                on_5 = ((1/60)*420)+c5;
                on_6 = ((1/60)*520)+c6;
                on_7 = ((1/60)*620)+c7;

                sim_on(sim1) = on_1;
                sim_on(sim2) = on_2;
                sim_on(sim3) = on_3;
                sim_on(sim4) = on_4;
                sim_on(sim5) = on_5;
                sim_on(sim6) = on_6;
                sim_on(sim7) = on_7;

                off_1 = on_1 + (ciclo*700);
                off_2 = on_2 + (ciclo*700);
                off_3 = on_3 + (ciclo*700);
                off_4 = on_4 + (ciclo*700);
                off_5 = on_5 + (ciclo*700);
                off_6 = on_6 + (ciclo*700);
                off_7 = on_7 + (ciclo*700);

                sim_off(sim1) = off_1;
                sim_off(sim2) = off_2;
                sim_off(sim3) = off_3;
                sim_off(sim4) = off_4;
                sim_off(sim5) = off_5;
                sim_off(sim6) = off_6;
                sim_off(sim7) = off_7;

                cd('C:\Users\USUARIO\Documents\Simulacoes')

                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim1)),'commented','off')
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim2)),'commented','off')
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim3)),'commented','off')
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim4)),'commented','off')
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim5)),'commented','off')
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim6)),'commented','off')
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim7)),'commented','off')

                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim1)),'commented','off');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim2)),'commented','off');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim3)),'commented','off');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim4)),'commented','off');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim5)),'commented','off');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim6)),'commented','off');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim7)),'commented','off');

                sim('Sim_Total_2');
                corrente = corrente_total;
                tensao = tensao_total;

                Ts = length(corrente)/t_total;


                corrente = decimate(corrente,70);
                tensao = decimate(tensao,70);        

                label = string(simu_1(sim1) + '+' + simu_1(sim2) + '+' + simu_1(sim3)+ '+' + simu_1(sim4)+ '+' + simu_1(sim5)+ '+' + simu_1(sim6)+ '+' + simu_1(sim7));
                angulo_disparo = [(c1*60*180);(c2*60*180); (c3*60*180); (c4*60*180); (c5*60*180); (c6*60*180); (c7*60*180)] ;

                N_on_1 = on_1*Ts/70;
                N_on_2 = on_2*Ts/70;
                N_on_3 = on_3*Ts/70;
                N_on_4 = on_4*Ts/70;
                N_on_5 = on_5*Ts/70;
                N_on_6 = on_6*Ts/70;
                N_on_7 = on_7*Ts/70;

                N_off_1 = off_1*Ts/70;
                N_off_2 = off_2*Ts/70;
                N_off_3 = off_3*Ts/70;
                N_off_4 = off_4*Ts/70;
                N_off_5 = off_5*Ts/70;
                N_off_6 = off_6*Ts/70;
                N_off_7 = off_7*Ts/70;

                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim1)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim2)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim3)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim4)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim5)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim6)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_cargas(sim7)),'commented','on');

                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim1)),'commented','on'); 
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim2)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim3)),'commented','on'); 
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim4)),'commented','on'); 
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim5)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim6)),'commented','on');
                set_param(sprintf('Sim_Total_2/%s',blocos_on_off(sim7)),'commented','on');


                sim_on=50*ones(1,28);
                sim_off=sim_on;        

                indice_ativacao = zeros(1,28);
                indice_ativacao(sim1)=1;
                indice_ativacao(sim2)=1;
                indice_ativacao(sim3)=1;
                indice_ativacao(sim4)=1;
                indice_ativacao(sim5)=1;
                indice_ativacao(sim6)=1;
                indice_ativacao(sim7)=1;


                N_on = zeros(1,28);
                N_off = zeros(1,28);

                N_on(sim1)=N_on_1;
                N_on(sim2)=N_on_2;
                N_on(sim3)=N_on_3;
                N_on(sim4)=N_on_4;
                N_on(sim5)=N_on_5;
                N_on(sim6)=N_on_6;
                N_on(sim7)=N_on_7;

                N_off(sim1)=N_off_1;
                N_off(sim2)=N_off_2;
                N_off(sim3)=N_off_3;
                N_off(sim4)=N_off_4;
                N_off(sim5)=N_off_5;
                N_off(sim6)=N_off_6;
                N_off(sim7)=N_off_7;


                cd('C:\Users\USUARIO\Documents\Simulacoes\Dados Simula��es Set')

                save(sprintf('carga_%d', count), 'label','corrente', 'tensao','N_on','N_off','indice_ativacao','t_total','angulo_disparo')

                count = count+1;
                toc
    end
end
