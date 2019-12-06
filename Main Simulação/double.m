% Code Written by Hellen C Ancelmo 
% Universidade Tecnológica Federal do Paraná
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDRÉ EUGÊNIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.


load('30_comb_2_cargas')
cargas = y;

count = 85;
teste = 1;
for i=1:length(cargas)
    sim_1 = cargas(i,1);
    sim_2 = cargas(i,2);
    for c1=0:disparo:(1/120)
        for c2=0:disparo:(1/120)
            if 17<=sim_1 && sim_1<=24
                c1 = 0;
            end
            if 17<=sim_2 && sim_2<=24
                c2 = 0;
            end
        
            tic

            on_1 = ((1/60)*20)+c1;
            on_2 = ((1/60)*120)+c2;

            sim_on(sim_1) = on_1;
            sim_on(sim_2) = on_2;

            off_1 = on_1 + (ciclo*200);
            off_2 = on_2 + (ciclo*200);

            sim_off(sim_1) = off_1;
            sim_off(sim_2) = off_2;

            set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim_1)),'commented','off')
            set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim_2)),'commented','off')

            set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim_1)),'commented','off');
            set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim_2)),'commented','off');

            sim(sprintf('%s',simulacao));
            
            corrente = corrente_total;
            tensao = tensao_total;

            Ts = length(corrente)/t_total;

            
            corrente = decimate(corrente,decim);
            tensao = decimate(tensao,decim); 
            
            
            label = string(simu_1(sim_1) + '+' + simu_1(sim_2));
            angulo_disparo = [(c1*60*180);(c2*60*180)] ;

            N_on_1 = on_1*Ts/decim;
            N_on_2 = on_2*Ts/decim;
            
            N_off_1 = off_1*Ts/decim;
            N_off_2 = off_2*Ts/decim;

            set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim_1)),'commented','on');
            set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim_2)),'commented','on');
            
            set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim_1)),'commented','on'); 
            set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim_2)),'commented','on'); 


            sim_on=50*ones(1,28);
            sim_off=sim_on;        
           
            indice_ativacao = zeros(1,28);
            indice_ativacao(sim_1)=1;
            indice_ativacao(sim_2)=1;
            
            
            N_on = zeros(1,28);
            N_off = zeros(1,28);
            
            N_on(sim_1)=N_on_1;
            N_on(sim_2)=N_on_2;
            
            N_off(sim_1)=N_off_1;
            N_off(sim_2)=N_off_2;
            
            vetor_ind_on(teste,:) = N_on;
            vetor_ind_off(teste,:) = N_off;
            teste = teste+1;
            save(sprintf('carga_%d', count), 'label','corrente', 'tensao','N_on','N_off','indice_ativacao','t_total','angulo_disparo')

            count = count+1;
            toc
        end
    end
end