Make sure you have read the [HW\_Interrupt block](./HW\_Interrupt.md), as we will build upon it.

# SCI\_Rx\_INT()

![alt text](image-7.png)

Now we shall delve into the Serial Receive Block. This block will handle the function of obtaining data from the laptop or host computer regarding control inputs and updating the global variables, which will then be picked up by the control system to update the desired speed and other control inputs.

Let's double click and go in!

![alt text](image-8.png)

There's a lot to unpack here. Don't worry, follow the numbered references in the image as I explain.

1. At number **1**, placing that block defines our current system as a function, and we can determine when this entire system will trigger execution. As mentioned earlier, the Serial receive will only execute when the C2000 microcontroller detects any changes in the control inputs, such as altering the desired speed from the host computer or laptop. Therefore, this function doesn't need to run every single time step; it only needs to run if there are signals coming through the serial channel. This is why it is called an interrupt service routine, which will only execute when there is an interrupt. In our case, our interrupt is receiving something on our serial communication channel, specifically SCI module A (see: [HW\_interrupt block](./HW\_Interrupt.md) on how this interrupt is generated).
2. At number **2** in the image, the same stacked squares indicate that this will run differently in code generation and simulation mode.
3. At number **3**, it looks like stacked squares again, indicating that it has two different modes of operation, but not on code generation and simulation as we've seen earlier. Instead, these stacked squares indicate that it will run different subsystems depending on the data type it receives, such as fixed point and floating point.
4. At number **4**, as I mentioned earlier, the host computer may send different control inputs to the C2000 microcontroller. In this model, they have chosen four different control signals like speed reference, enabling the system, enabling FWC, and debug signals. These are the four signals that will be sent by the host computer. Additionally, there is a block called **unParse**, which, as the name implies, parses or unpacks the data into three different control signals, or the three different control signals are de-multiplexed.


### SCI_Rx (Codegen)

![alt text](image-9.png)

Here we see two subsystems, which have the exact same hardware block inside them and it gives its outputs to the port 1, just with a small modification in the block parameters in the data type column.

![alt text](image-10.png)

- What we have seen so far is just the interrupt generation, finally the data gets to a hardware specific block which is a CIRCV which actually receives the data and stores it in the serial buffer which will be read by the C2000 microcontroller.

### SCI_Rx (Simulation)

![alt text](image-11.png)

- Using the hardware serial reception block above was much easier. Now we have to emulate how the data will be received with all the nuances of data type conversion when running in a simulation environment is little more involved. 

- Here, we need to actually create how the data is transmitted serially from her host computer. So, for that, we have some blocks like step input constant. We need to convert it to proper data type and mux it, then again converting into proper data type.
 

- We have completed seeing what's inside **block 2**
![alt text](image-8.png)

- Now let's 


Let's go into