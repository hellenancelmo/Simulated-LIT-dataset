% Code Written by Hellen C Ancelmo 
% Universidade Tecnológica Federal do Paraná
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDRÉ EUGÊNIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.


% Vetor de Combinação de Disparo de 3 cargas
load('30_comb_3_cargas')
cargas = y;


% Vetor de Combinação de Angulo de Disparo 
% [1 2 3] -> Referente ao Label de Combinação
% Primeira combinação sempre [1 1 1]
load('5_comb_disp_3_cargas')
disp = y;
% Label de Combinação dos angulos de disparo
label_disp = [0 1/240 1/120];

count = 355;
teste = 1;
for i=1:length(cargas)
    sim1 = cargas(i,1);
    sim2 = cargas(i,2);
    sim3 = cargas(i,3);
 
    for j=1:length(disp)
        c1 = disp(j,1);
        c1 = label_disp(c1);
        c2 = disp(j,2);
        c2 = label_disp(c2);
        c3 = disp(j,3);
        c3 = label_disp(c3);
                if 17<=sim1 && sim1<=24
                    c1 = 0;
                end
                if 17<=sim2 && sim2<=24
                    c2 = 0;
                end
                if 17<=sim3 && sim3<=24
                    c3 = 0;
                end

                tic

                on_1 = ((1/60)*20)+c1;
                on_2 = ((1/60)*120)+c2;
                on_3 = ((1/60)*220)+c3;

                sim_on(sim1) = on_1;
                sim_on(sim2) = on_2;
                sim_on(sim3) = on_3;

                off_1 = on_1 + (ciclo*300);
                off_2 = on_2 + (ciclo*300);
                off_3 = on_3 + (ciclo*300);

                sim_off(sim1) = off_1;
                sim_off(sim2) = off_2;
                sim_off(sim3) = off_3;


                set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim1)),'commented','off')
                set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim2)),'commented','off')
                set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim3)),'commented','off')

                set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim1)),'commented','off');
                set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim2)),'commented','off');
                set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim3)),'commented','off');

                sim(sprintf('%s',simulacao));
                corrente = corrente_total;
                tensao = tensao_total;

                Ts = length(corrente)/t_total;


                corrente = decimate(corrente,decim);
                tensao = decimate(tensao,decim);        

                label = string(simu_1(sim1) + '+' + simu_1(sim2) + '+' + simu_1(sim3));
                angulo_disparo = [(c1*60*180);(c2*60*180); (c3*60*180)] ;

                N_on_1 = on_1*Ts/decim;
                N_on_2 = on_2*Ts/decim;
                N_on_3 = on_3*Ts/decim;

                N_off_1 = off_1*Ts/decim;
                N_off_2 = off_2*Ts/decim;
                N_off_3 = off_3*Ts/decim;

                set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim1)),'commented','on');
                set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim2)),'commented','on');
                set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim3)),'commented','on');

                set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim1)),'commented','on'); 
                set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim2)),'commented','on');
                set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim3)),'commented','on'); 


                sim_on=50*ones(1,28);
                sim_off=sim_on;        

                indice_ativacao = zeros(1,28);
                indice_ativacao(sim1)=1;
                indice_ativacao(sim2)=1;
                indice_ativacao(sim3)=1;


                N_on = zeros(1,28);
                N_off = zeros(1,28);

                N_on(sim1)=N_on_1;
                N_on(sim2)=N_on_2;
                N_on(sim3)=N_on_3;

                N_off(sim1)=N_off_1;
                N_off(sim2)=N_off_2;
                N_off(sim3)=N_off_3;

            
                save(sprintf('carga_%d', count), 'label','corrente', 'tensao','N_on','N_off','indice_ativacao','t_total','angulo_disparo')

                count = count+1;
                toc
    end
end
