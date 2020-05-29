# SIMULATED DATABASE

The codes in this repository are explained in these papers: 

H. C. Ancelmo et al., "A New Simulated Database for Classification Comparison in Power Signature Analysis," 2019 20th International Conference on Intelligent System Application to Power Systems (ISAP), New Delhi, India, 2019, pp. 1-7, doi: 10.1109/ISAP48318.2019.9065943

# Files

* motor_parameters.mat -> contains the parameters of the universal motor
* 5_comb_trig_3_loads.mat -> contains 5 combination triggers to 3 loads in the same waveform
* 5_comb_trig_4_loads.mat -> contains 5 combination triggers to 4 loads in the same waveform
* 5_comb_trig_5_loads.mat -> contains 5 combination triggers to 5 loads in the same waveform
* 10_comb_trig_6_loads.mat -> contains 10 combination triggers to 7 loads in the same waveform
* 10_comb_trig_7_laods.mat -> contains 10 combination triggers to 7 loads in the same waveform
* 30_comb_2_loads.mat -> contains 30 combination laods to 2 loads in the same waveform
* 30_comb_3_loads.mat -> contains 30 combination laods to 3 loads in the same waveform
* 30_comb_4_loads.mat -> contains 30 combination laods to 4 loads in the same waveform
* 30_comb_5_loads.mat -> contains 30 combination laods to 5 loads in the same waveform
* 50_comb_6_laods.mat -> contains 50 combination laods to 6 loads in the same waveform
* 50_comb_7_loads.mat -> contains 50 combination laods to 7 loads in the same waveform

# Algorithms
* main_simu.m -> The main algorithm, in this file all parameters of circuits and motor are loaded. 
    - Parameters
        - You can change the values of resistor, inductor and capacitor of each circuit.
    - Simulink Blocks
        - Each block of simulink scenario is loaded.
        - The voltage and current labels are defined.
    - Database Type
        - You can choose the scenario of simulation: Ideal, with leakege inductance and with leakege inductance and harmonic. Just uncomment the chosen scenario.
    - Blocks of Simulink
      - Comment and uncomment blocks of simulink in order to make simulation efficient.
    - Database Parameters
      - You can change the cycle, step trigger and decimation rate.
    - Combination Loads
      - You can choose the combination loads in the same waveform. Just uncommento the chosen comination.
      - You can change de total time of simulation in sim_time
      
* individual_load.m -> algorithm that performs and save all individual loads.
* dobule_laod.m -> algorithm that performs all possible combinations of loads with 2 loads in the same waveform using 30 combination triggers.
* triple_load.m -> algorithm that performs 30 combinations of loadswith 3 loads in the same waveform using 5 combination triggers.
* fourfold_load.m -> algorithm that performs 30 combinations of loads with 4 loads in the same waveform using 5 combination triggers.
* quintuple_load.m -> algorithm that performs 30 combinations of loads with 5 loads in the same waveform using 5 combination triggers.
* sixfold_load.m -> algorithm that performs 50 combinations of loads with 6 loads in the same waveform using 10 combination triggers.
* sevenfold_load.m -> algorithm that performs 50 combinations of loads with 7 loads in the same waveform using 10 combination triggers.
