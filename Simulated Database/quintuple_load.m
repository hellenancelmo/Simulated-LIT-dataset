% Code Written by Hellen C Ancelmo 
% Universidade Tecnol�gica Federal do Paran�
% E-Mail: hellen@alunos.utfpr.edu.br


% ANCELMO, H. C. ; MULINARI, B. M. ; POTTKER, F. ; LAZZARETTI, ANDR� EUG�NIO ; 
% OROSKI, E. ; BAZZO, T. ; LIMA, C. R. E. ; LINHARES, R. R. ; RENAUX, D. P. B. ; 
% GAMBA, A. . A New Simulated Database for Classification Comparison in Power 
% Signature Analysis. In: 20th International Conference on Intelligent Systems 
% Applications to Power Systems, 2019, New Delhi. 20th International Conference 
% on Intelligent Systems Applications to Power Systems, 2019.



load('30_comb_5_loads')
loads_combination = y;

load('5_comb_trig_5_loads')
trig = y;

trigger_label = [0 1/240 1/120];


count = 1;

for i=1:length(loads_combination)
    sim1 = loads_combination(i,1);
    sim2 = loads_combination(i,2);
    sim3 = loads_combination(i,3);
    sim4 = loads_combination(i,4);
    sim5 = loads_combination(i,5);

    for j=1:length(trig)
        c1 = trig(j,1);
        c1 = trigger_label(c1);
        c2 = trig(j,2);
        c2 = trigger_label(c2);
        c3 = trig(j,3);
        c3 = trigger_label(c3);
        c4 = trig(j,4);
        c4 = trigger_label(c4);
        c5 = trig(j,5);
        c5 = trigger_label(c5);

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

                tic

                on_1 = ((1/60)*20)+c1;
                on_2 = ((1/60)*120)+c2;
                on_3 = ((1/60)*220)+c3;
                on_4 = ((1/60)*320)+c4;
                on_5 = ((1/60)*420)+c5;

                sim_on(sim1) = on_1;
                sim_on(sim2) = on_2;
                sim_on(sim3) = on_3;
                sim_on(sim4) = on_4;
                sim_on(sim5) = on_5;
                
                off_1 = on_1 + (cycle*500);
                off_2 = on_2 + (cycle*500);
                off_3 = on_3 + (cycle*500);
                off_4 = on_4 + (cycle*500);
                off_5 = on_5 + (cycle*500);

                sim_off(sim1) = off_1;
                sim_off(sim2) = off_2;
                sim_off(sim3) = off_3;
                sim_off(sim4) = off_4;
                sim_off(sim5) = off_5;
                
   
                
                set_param(sprintf('%s/%s',simulation,load_blocks(sim1)),'commented','off')
                set_param(sprintf('%s/%s',simulation,load_blocks(sim2)),'commented','off')
                set_param(sprintf('%s/%s',simulation,load_blocks(sim3)),'commented','off')
                set_param(sprintf('%s/%s',simulation,load_blocks(sim4)),'commented','off')
                set_param(sprintf('%s/%s',simulation,load_blocks(sim5)),'commented','off')

                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim1)),'commented','off');
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim2)),'commented','off');
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim3)),'commented','off');
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim4)),'commented','off');
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim5)),'commented','off');

                sim(sprintf('%s',simulation));
                
                current = total_current;
                voltage = total_voltage;

                Ts = length(current)/sim_time;


                current = decimate(current,decimation);
                voltage = decimate(voltage,decimation);        
                
                label = string(simu_blocks(sim1) + '+' + simu_blocks(sim2) + '+' + simu_blocks(sim3)+ '+' + simu_blocks(sim4)+ '+' + simu_blocks(sim5));
                trigger_angle = [(c1*60*180);(c2*60*180); (c3*60*180); (c4*60*180); (c5*60*180)] ;

                N_on_1 = on_1*Ts/decimation;
                N_on_2 = on_2*Ts/decimation;
                N_on_3 = on_3*Ts/decimation;
                N_on_4 = on_4*Ts/decimation;
                N_on_5 = on_5*Ts/decimation;

                N_off_1 = off_1*Ts/decimation;
                N_off_2 = off_2*Ts/decimation;
                N_off_3 = off_3*Ts/decimation;
                N_off_4 = off_4*Ts/decimation;
                N_off_5 = off_5*Ts/decimation;

                set_param(sprintf('%s/%s',simulation,load_blocks(sim1)),'commented','on');
                set_param(sprintf('%s/%s',simulation,load_blocks(sim2)),'commented','on');
                set_param(sprintf('%s/%s',simulation,load_blocks(sim3)),'commented','on');
                set_param(sprintf('%s/%s',simulation,load_blocks(sim4)),'commented','on');
                set_param(sprintf('%s/%s',simulation,load_blocks(sim5)),'commented','on');

                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim1)),'commented','on'); 
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim2)),'commented','on');
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim3)),'commented','on'); 
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim4)),'commented','on'); 
                set_param(sprintf('%s/%s',simulation,on_off_blocks(sim5)),'commented','on');


                sim_on=50*ones(1,28);
                sim_off=sim_on;        

                ativation_index = zeros(1,28);
                ativation_index(sim1)=1;
                ativation_index(sim2)=1;
                ativation_index(sim3)=1;
                ativation_index(sim4)=1;
                ativation_index(sim5)=1;


                N_on = zeros(1,28);
                N_off = zeros(1,28);

                N_on(sim1)=N_on_1;
                N_on(sim2)=N_on_2;
                N_on(sim3)=N_on_3;
                N_on(sim4)=N_on_4;
                N_on(sim5)=N_on_5;

                N_off(sim1)=N_off_1;
                N_off(sim2)=N_off_2;
                N_off(sim3)=N_off_3;
                N_off(sim4)=N_off_4;
                N_off(sim5)=N_off_5;
                

                save(sprintf('load_%d', count), 'label','current', 'voltage','N_on','N_off','ativation_index','sim_time','trigger_angle')

                count = count+1;
                toc
    end
end
