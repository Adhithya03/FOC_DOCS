
![alt text](..\images\writings_image-6.png)


We now move to the Input Scaling block, So this block has 3 inputs namely

1. Ia_ADC
2. Ib_ADC
3. VI_fb

And 3 outputs namely
1. Iab_meas_PU
2. POS_PU
3. Speed_PU


![alt text](..\images\writings_image-7.png)

This block does 2 this mainly
1. Data type conversion of received signals from ADCs.
2. Estimation of the stator flux angle (position) and speed of the motor. (since we are doing sensorless i.e. we only measure the motor currents and not the rotor position and speed) 

#### 1. Current Measurements

- This block is rather simple compared to next block (Flux Observer) which we will see later.

- Now into the current measurements block

![alt text](..\images\writings_image-8.png)

- We the 2 inputs Ia_ADC and Ib_ADC are converted to int32 and subtracted from Ia_offset and Ib_offset respectively.

- The Ia_offset and Ib_offset are calibrated by us. 

- The subtracted values goes to `DataType` block. We shall see what this block does.

![alt text](..\images\writings_image-9.png)

- There are 3 gain blocks where the input values are multipled by 
  - 1. Get ADC voltage  target.ADC_Vref /target.ADC_MaxCount
    - Where target.ADC_Vref = 3.3V and target.ADC_MaxCount = 4096 for our case.
  - 2. Get Currents 1/inverter.ISenseVoltPerAmp
    - inverter.ISenseVoltPerAmp = inverter.ISenseVoltPerAmp * inverter.ADCGain
  - 3. PU_Conversion 1/PU_System.I_base of our motor.


#### 2. Position and Speed measurements

![alt text](..\images\writings_image-10.png)


- Let's just recap what signal is entering this block.

  - VI_fb is the motor voltage and current both in $\alpha \beta$ frame of reference.
  - With the help of these signals we can estimate the rotor position and speed of the motor.

![alt text](..\images\writings_image-11.png)

- As we said both voltages and currents come through port 1 shown in the image above. 
- These go through high pass filter for removing low frequency noise.
  - Filter coeff. of this highpass filter is calcuated thusly can be found in `mcb_acim_foc_sensorless_f2879d_data.m` file and is as 
  - $\text{Filter coeff.} = \frac{2\pi T_s f_{cutoff}}{2\pi T_s f_{cutoff} + 1}$
- This filtered signals are then fed to the `Flux Observer` block which estimates stator flux position. This is an in-built block in the simulink library. If you want to know more about this block you can read about it [here](./Flux_Observer.md)

- The estimated stator flux position is then fed to the `Speed Estimation` block which estimates the speed of the motor $\omega$ this is also an in-built block in the simulink library. If you want to know more about this block you can read about it [here](./Speed_Estimation.md)

- The estimated speed goes through low pass filter to remove high frequency noise, and the filter parameters are as follows

```matlab
% IIR Filter for speed
IIR_filter_speed.type           = 'Low-pass';
IIR_filter_speed.min_speed      = 50; %rpm
IIR_filter_speed.f_cutoff       = IIR_filter_speed.min_speed*acim.p/(120/2); %Hz
IIR_filter_speed.coefficient    = 2*pi*Ts*IIR_filter_speed.f_cutoff/(2*pi*Ts*IIR_filter_speed.f_cutoff + 1);
IIR_filter_speed.time_const     = 1/(2*pi*IIR_filter_speed.f_cutoff);
IIR_filter_speed.delay_ss       = 4*IIR_filter_speed.time_const;
```

- Now as you see in the image above the estimated stator flux's speed is subtracted with slip speed to get the rotor speed.
  - Let's look at an example to understand this better.
    - Say Stator speed  = 1pu,
    - Slip speed = 0.1 pu (we know this from slip speed estimation block we will see next)
    - Rotor speed = 1 - 0.1 = 0.9 pu
  - This is how we get the rotor speed.
- Then we are dividing my pole pairs to get the mechanical speed of the motor from electrical speed.
