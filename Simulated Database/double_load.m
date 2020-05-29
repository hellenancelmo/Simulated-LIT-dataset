% Code Written by Hellen C Ancelmo 
% Universidade Tecnológica Federal do Paraná
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDRÉ EUGÊNIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.


load('30_trig_2_loads')
loads_combination = y;

count = 1;

for i=1:length(loads_combination)
    sim_1 = loads_combination(i,1);
    sim_2 = loads_combination(i,2);
    for c1=0:trigger:(1/120)
        for c2=0:trigger:(1/120)
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

            off_1 = on_1 + (cycle*200);
            off_2 = on_2 + (cycle*200);

            sim_off(sim_1) = off_1;
            sim_off(sim_2) = off_2;

            set_param(sprintf('%s/%s',simulation,load_blocks(sim_1)),'commented','off')
            set_param(sprintf('%s/%s',simulation,load_blocks(sim_2)),'commented','off')

            set_param(sprintf('%s/%s',simulation,on_off_blocks(sim_1)),'commented','off');
            set_param(sprintf('%s/%s',simulation,on_off_blocks(sim_2)),'commented','off');

            sim(sprintf('%s',simulation));
            
            current = total_current;
            voltage = total_voltage;;

            Ts = length(current)/sim_time;

            
            current = decimate(current,decimation);
            voltage = decimate(voltage,decimation); 
            
            
            label = string(simu_blocks(sim_1) + '+' + simu_blocks(sim_2));
            trigger_angle = [(c1*60*180);(c2*60*180)] ;

            N_on_1 = on_1*Ts/decimation;
            N_on_2 = on_2*Ts/decimation;
            
            N_off_1 = off_1*Ts/decimation;
            N_off_2 = off_2*Ts/decimation;

            set_param(sprintf('%s/%s',simulation,load_blocks(sim_1)),'commented','on');
            set_param(sprintf('%s/%s',simulation,load_blocks(sim_2)),'commented','on');
            
            set_param(sprintf('%s/%s',simulation,on_off_blocks(sim_1)),'commented','on'); 
            set_param(sprintf('%s/%s',simulation,on_off_blocks(sim_2)),'commented','on'); 


            sim_on=50*ones(1,28);
            sim_off=sim_on;        
           
            ativation_index = zeros(1,28);
            ativation_index(sim_1)=1;
            ativation_index(sim_2)=1;
            
            
            N_on = zeros(1,28);
            N_off = zeros(1,28);
            
            N_on(sim_1)=N_on_1;
            N_on(sim_2)=N_on_2;
            
            N_off(sim_1)=N_off_1;
            N_off(sim_2)=N_off_2;
            
            save(sprintf('load_%d', count), 'label','current', 'voltage','N_on','N_off','ativation_index','sim_time','trigger_angle')

            count = count+1;
            toc
        end
    end
end