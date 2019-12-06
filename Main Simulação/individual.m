% Code Written by Hellen C Ancelmo 
% Universidade Tecnológica Federal do Paraná
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDRÉ EUGÊNIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.


count = 1;
for sim1=1:28
    for c1=0:disparo:(1/120)
        if 17<=sim1 && sim1<=24
            c1 = 0;
        end
            tic

            on_1 = ((1/60)*20)+c1;

            sim_on(sim1) = on_1;

            off_1 = on_1 + (ciclo*100);

            sim_off(sim1) = off_1;

            
            
            set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim1)),'commented','off')

            set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim1)),'commented','off');

            sim(sprintf('%s',simulacao));
            corrente = corrente_total;
            tensao = tensao_total;

            Ts = length(corrente)/t_total;


            corrente = decimate(corrente,decim);
            tensao = decimate(tensao,decim);        

            label = string(simu_1(sim1));
            angulo_disparo = (c1*60*180);
            label_new = cellstr(label);
            
            N_on = zeros(1,28);
            N_off = zeros(1,28);

            N_on(sim1) = on_1*Ts/decim;
            
            N_off(sim1) = off_1*Ts/decim;
            
            

            set_param(sprintf('%s/%s',simulacao,blocos_cargas(sim1)),'commented','on');
            set_param(sprintf('%s/%s',simulacao,blocos_on_off(sim1)),'commented','on'); 


            sim_on=50*ones(1,28);
            sim_off=sim_on;

            indice_ativacao = zeros(1,28);
            indice_ativacao(sim1)=1;
            

            save(sprintf('carga_%d', count), 'label','corrente', 'tensao','N_on','N_off','indice_ativacao','t_total','angulo_disparo')

            count = count+1;
            toc
    end
end