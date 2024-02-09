## Sensorless FOC ACIM Model Walkthrough

*alt text: image.png*

* **Important Note:**  This model undergoes transformation from block diagram --> C code --> machine code before executing on a C2000 microcontroller.

### Exploring the 'HW_Interrupt' Block

*alt text: image-1.png*

The stacked squares icon in the 'HW_Interrupt' block signals different behaviors in:

* **Simulation Mode:** Activated when you click the green 'Run' button within Simulink.
* **Code Generation Mode:**  Employed when creating C code specifically intended for the C2000 microcontroller.

Simulink offers a mix of hardware-specific blocks (for deployment) and general simulation tools, prompting us to select accordingly.

*alt text: image-3.png*

Within 'HW_Interrupt', we discover two sub-subsystems dedicated to code generation and simulation.  It's worth noting that none of the blocks have a direct link to 'HW_INT Port 1'; Simulink handles this routing based on our actions.

### Simulation Subsystem

*alt text: image-4.png*

Inside the simulation subsystem:

* **f() ADCINT1:** An interrupt service routine (ISR) set off by the actual  ADC (Analog-to-Digital Converter).  For simplicity, think of the ADC as measuring motor currents.

* **f() SCI_Rx_int:** This ISR reacts when we make adjustments from our laptop (e.g., setting a target motor speed). It temporarily halts other operations, reads incoming serial communication, and modifies control inputs as needed. 

* **Key Point:** Pretend you're the C2000 microcontroller – "receiving" data implies  getting it from the computer.

### Code-gen Subsystem

*alt text: image-5.png*

* **HWI_ADCB1_INT:**  Similar in function to the simulation ISR, but tailored for hardware. The C2000 possesses several ADC modules; 'ADC B1' is responsible for this particular interrupt.

* **HWI_SCIA_RX_INT:** We've opted to transmit control signals to the C2000 via the SCI-A channel.   Consequently, data arriving on SCI-A activates this interrupt, forwarding changes to the embedded control system.

**Ready to dissect another block? Let me know!** 
