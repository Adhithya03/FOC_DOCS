# Current control

This is where guts of FOC lies.

![alt text](image.png)

- As we can see in the above image there are 2 inputs to this Current control system, Namely

    - Idq_ref from the speed control system.
    - Feedback_sim signal from the inverter and motor system which is nothing but motor currents of Ia and Ib.

![alt text](image-1.png)


- When we go into the current control subsystem we see there are 7 blocks in total.

- As shown in the tree view (model browser) to the left of the image.

  - **Current Control**
    - HW_Inputs
    - Input Scaling
    - Control_System
    - Output Scaling
    - Inverter
    - Debug_signals
    - SCI_Tx

- Let's go through each of these blocks one by one.

---

## HW_Inputs

This block just reads motor's current Ia, and Ib from ADC_c and ADC_b respectively.

![alt text](image-2.png)


- Notice the stacked square icon the bottom left of the block, it means as we already said this block behaves differently in the real hardware and in the simulation mode.

**In simulation mode**
  - See the Port numbered 2 below it it's labelled as Feedback_sim, which is nothing but the motor currents Ia and Ib, so naturally when in simulation mode we get these current and forward straight away to the outputs.
  - And when we see the blocks inside we see just that.
  
  ![alt text](image-3.png)

**In code generation mode** (real hardware mode)
  - The signal which is Feedback_sim is useless, so it's not connected to anything.
  - Instead, the real motor currents are read from the ADCs and when we go inside the block we see just that 2 special blocks which are used to read the motor currents from the ADCs. 
  - ![alt text](image-4.png)
  
  **Closer look at the ADC block**
  - ![alt text](image-5.png)
    - **ADC Module C**: This refers to the specific Analog to Digital Converter (ADC) module being used on the F23879D launchpad. The C2000 series has multiple ADC modules (A, B, C, etc.), and in this case, ADC Module C is being used.

    - **ADC Resolution 12-bit (Single-ended input)**: This specifies the resolution of the ADC. A 12-bit resolution means the ADC can represent the analog input as one of 4096 different values (2^12). A single-ended input means the ADC is measuring the voltage difference between the input signal and ground, as opposed to differential input which measures the voltage difference between two input signals.

    - **SOC trigger number SOC0**: SOC stands for Start of Conversion. This is the event that triggers the ADC to start converting an analog signal to a digital one. SOC0 is the specific trigger event being used.

    - **SOC acquisition window 15**: This is the length of time the ADC will sample the analog signal before it starts conversion. The unit of time is typically in ADC clock cycles.

    - **SOC trigger source ePWM1_ADCSOCA**: This specifies the source that triggers the start of conversion (SOC). In this case, it's the ADCSOCA signal from the ePWM1 module.

    - **ADCINT will trigger SOCx No ADCINT**: ADCINT is an interrupt signal from the ADC. This line is saying that ADCINT is not being used to trigger the start of conversion (SOC).

    - **Sample time -1**: This specifies the rate at which the ADC samples the input signal. A value of -1 typically means that the sample time is inherited from the driving block.

    - **Data type uint16**: This is the data type of the digital output from the ADC. uint16 means it's an unsigned 16-bit integer.

    - **Post interrupt at EOC trigger**: EOC stands for End of Conversion. This line means that an interrupt will be generated when the ADC finishes converting the analog signal to a digital one.

## Input Scaling

![alt text](image-6.png)


We now move to the Input Scaling block, So this block has 3 inputs namely

1. Ia_ADC
2. Ib_ADC
3. VI_fb

new file for flux observer block

[Flux Observer](./Flux_Observer.md)