# SCI_tx

![alt text](..\images\writings_image-29.png)

The debug signals [Debug_signals](./Debug_signals.md) are sent to the SCI Tx block. 

# In Simulation mode
![alt text](..\images\writings_image-30.png)

In simulation mode we don't need to send the debug signals to the SCI Tx block. So we use a terminator block to terminate the signals.  


# Hardware (code generation) mode

![alt text](..\images\writings_image-31.png)

Only when this code is running on the C2000 we need to send the data from the controller to host PC. 

> The blocks seems grayed out because the default mode in simulink is simulation mode.

### Data_Condition_Tx

![alt text](..\images\writings_image-32.png)

Notice a stacked squares icons, which means it has 2 different sybsystems and not according to the simlation or code generation mode. but according to the data type. one with float and fixed point data types.

![alt text](..\images\writings_image-33.png)


#### Float data type
![alt text](..\images\writings_image-34.png)

We are just routing the data to an inbuilt block in simulink called `Byte Pack` 

The Byte Pack block in MATLAB Simulink is used to pack multiple input data into a single output vector of a specified data type. This is particularly useful in communication systems where data needs to be transmitted in a compact form to save bandwidth or improve efficiency. 

In the context of SCI (Serial Communication Interface) serial communication transmission from an embedded hardware (like the C2000 microcontroller) to a host PC (like a laptop), the Byte Pack block can be used to pack the data that needs to be transmitted from the microcontroller to the PC. This packed data can then be sent over the SCI protocol.

Let's break down the parameters:

- **Output port (packed) data type uint32**: This specifies the data type of the output vector. In this case, it is uint32, which is an unsigned 32-bit integer. This means that the packed data will be represented as a 32-bit integer.

- **Input port data types (cell array) {'single'}**: This specifies the data type of the input data that needs to be packed. In this case, it is 'single', which is a single-precision floating-point number. This means that the data that is being packed is represented as single-precision floating-point numbers.

- **Byte alignment >...4**: This parameter specifies the alignment of the packed bytes. In this case, it is 4, which means that the packed bytes are aligned to 4-byte boundaries. This can be important for systems that require specific byte alignment for efficient data handling.

In summary, this block takes in single-precision floating-point numbers, packs them into a 32-bit unsigned integer according to a 4-byte alignment, and outputs this packed data. This packed data can then be transmitted over the SCI protocol from the C2000 microcontroller to the laptop.


#### Fixed point data type
In this series of conversions, the data is first processed through the "Data Type Conversion" block where it is converted to a fixed-point data type (fixdt(1,32,28)). This block ensures that the Real World Values (RWV) of the input and output are equal.

The "fixdt(1,32,28)" data type indicates that the data is signed (1), has a word length of 32 bits, and a fraction length of 28 bits. This means that the data can represent values from -2^31 to 2^31-1 with a precision of 2^-28.

The parameters also indicate that the block uses the simplest integer rounding mode, which rounds towards the nearest integer, or towards zero if the number is exactly halfway between two integers.

The output of this block is then passed to the "Data Type Conversion3" block. Here, the data is converted to an unsigned 32-bit integer (uint32). This block ensures that the Stored Integer (SI) values of the input and output are equal.

The parameters also indicate that the block uses the simplest integer rounding mode and will saturate on integer overflow. This means that if the input value exceeds the maximum representable value of the uint32 data type, the output will be set to the maximum representable value (2^32-1).

In summary, the data is first converted to a fixed-point data type with a specific word and fraction length, and then it is converted to an unsigned 32-bit integer. This series of conversions might be used to prepare the data for transmission over a communication interface that requires data to be in a specific format.

### Data_Logging

![alt text](..\images\writings_image-37.png)


Let's go through the Simulink model and understand the purpose of each block and the overall functionality of the system:

1. Data_Log (Inport)
2. If block (with if/elseif/else condition)
3. Counter Limited block (not explicitly labeled in the diagram, but it can be inferred from the condition in the If block that it counts from 0 to 599)
4. Width block (Constant)
5. Three Action Subsystem blocks labeled as Start, End, and Data
6. Three Merge blocks
7. Two Outports labeled as SCI_Tx_Data and SCI_Tx

Now, let's re-analyze the model with the Counter Limited block in mind:

1. The Data_Log block is the input to the system, providing the data that needs to be logged or monitored.

2. The If block processes the input data based on the condition provided (if u1 == 0, elseif u1 == 599, else). This logic is applied to the output of a Counter Limited block, which increments its value with each simulation step until it reaches the upper limit of 599, then it resets.

3. The Counter Limited block is not explicitly shown, but it is implied by the If block's conditions. This block is likely used to control the timing of the data transmission, possibly by indexing through an array of data or managing the pacing of data packets.

4. The Width block provides a constant value (0 in this case), which might be used to set the width of the data or as a control signal for the Action Subsystem blocks.

5. The three Action Subsystem blocks (Start, End, and Data) are configured to perform specific actions based on the condition evaluated by the If block. They likely prepare the data for transmission, signal the start and end of the data packet, or manipulate the data in some other way before it is sent out.

   - The Start block is likely responsible for initializing or preparing the communication for data transmission.
   - The End block could be used to signal the termination of data transmission or to clean up after the data has been sent.
   - The Data block is probably where the data to be transmitted is processed or formatted.

6. The Merge blocks combine the outputs from the Action Subsystem blocks into single streams for transmission.

7. The two Outports, SCI_Tx_Data and SCI_Tx, are the outputs of the system. SCI_Tx_Data likely carries the serialized data to be transmitted, while SCI_Tx may carry control signals or iteration counts associated with the data transmission.

The Counter Limited block plays a crucial role in determining when certain actions within the Action Subsystem blocks are triggered, such as starting, ending, or processing data for transmission. The If block uses the count value to determine which action to execute. The system is designed to manage the flow of serial data from the hardware to the host computer, with the counter providing a mechanism for managing the sequence of operations.

### Do..while block.

![alt text](..\images\writings_image-36.png)

![alt text](..\images\writings_image-35.png)