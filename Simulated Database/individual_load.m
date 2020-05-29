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
    for c1=0:trigger:(1/120)
        if 17<=sim1 && sim1<=24
            c1 = 0;
        end
            tic

            on_1 = ((1/60)*20)+c1;

            sim_on(sim1) = on_1;

            off_1 = on_1 + (cycle*100);

            sim_off(sim1) = off_1;

            
            set_param(sprintf('%s/%s',simulation,load_blocks(sim1)),'commented','off')

            set_param(sprintf('%s/%s',simulation,on_off_blocks(sim1)),'commented','off');

            sim(sprintf('%s',simulation));
            current = total_current;
            voltage = total_voltage;

            Ts = length(current)/sim_time;

            current = decimate(current,decimation);
            voltage = decimate(voltage,decimation);        

            label = string(simu_blocks(sim1));
            trigger_angle = (c1*60*180);
            label_new = cellstr(label);
            
            N_on = zeros(1,28);
            N_off = zeros(1,28);

            N_on(sim1) = on_1*Ts/decimation;
            
            N_off(sim1) = off_1*Ts/decimation;
            
            
            set_param(sprintf('%s/%s',simulation,load_blocks(sim1)),'commented','on');
            set_param(sprintf('%s/%s',simulation,on_off_blocks(sim1)),'commented','on'); 


            sim_on=50*ones(1,28);
            sim_off=sim_on;

            ativation_index = zeros(1,28);
            ativation_index(sim1)=1;
            

            save(sprintf('load_%d', count), 'label','current', 'voltage','N_on','N_off','ativation_index','sim_time','trigger_angle')

            count = count+1;
            toc
    end
end