# Field the oriented control of Induction motor

This repository has various text files explaining, the field-oriented control example from Simulink's Motor Control Blockset. It breaks down the implementation of sensorless FOC for an induction motor using the F23879D Delphino launchpad. Each component is explained step by step to help understand the practical aspects of FOC implementation.


### Example Simulink model of FOC explained


Simulink model of the sensorless Field Oriented Control (F.O.C.) of induction machine with F23879D delphino launchpad.

1. [HW_Interrupt](./Writings/HW_Interrupt.md)
2. [Serial Recieve](./Writings/Serial_Receive.md)
3. [Speed control](./Writings/Speed_control.md)
4. [Current Control](./Writings/Current_control.md)
5. [Inverter and motor](./Writings/InverterMotor.md)


![alt text](./images/image-6.png)

---

## Other useful information used for the project

## PCB design tutorials

- [Youtube series explaining PCB design](https://www.youtube.com/watch?v=DtPCK3qGakM&list=PLVg5xjDHQldd2SjGsXRB4atrrWZ9rLCe_)

- [National Instrument's official PCB design tutorial](https://knowledge.ni.com/KnowledgeArticleDetails?id=kA03q000000YH7MCAW&l=en-IN)


## ePWM docs

[ePWM](./Writings/ePWM.md)



---

### Acknowledgements

- [Vscode](https://code.visualstudio.com/) for writing markdown files and previewing them.
  - [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) extension for vscode.
  - [Github Copilot](https://copilot.github.com/) for helping me complete my code, thoughts and sentences.
- [Github](https://github.com)  hosting the documentation, and for version control.
- [ShareX](https://getsharex.com/) for taking screenshots and annotating them.

### Background Behind This Repository  
This repository represents the culmination of my final year capstone project, which focused on the field-oriented control (FOC) of induction motors. Our goal was to implement the system in hardware using an Intelligent Power Module (IPM). However, due to unforeseen challenges with the IPM, we were unable to complete the hardware implementation within the given timeline. Despite these setbacks, the experience proved to be an incredible learning journey.  

Initially, although I had a basic theoretical understanding of FOC, diving into its practical implementation felt overwhelming. However, the tight project deadlines pushed me to thoroughly explore the concept and work through its intricacies step by step. As part of the process, my friend Anabhayan encouraged me to document everything I learned, both to solidify my understanding and to share the knowledge with others.  

Documenting this journey not only gave me a deeper grasp of FOC but also served as the foundation for this repository. The explanations and breakdowns in these files were compiled to teach myself first and then simplify the concepts for others. Although the hardware implementation wasn't completed, the repository showcases what I learned and how I approached the challenge. I'm also profoundly grateful to my project guide and my friend Anabhayan for their encouragement, which kept me motivated throughout the process.

### Background Behind the YouTube Videos  
The explanations and documentation included in this repository later became the basis for my YouTube tutorials. These videos were an effort to share the knowledge I gained with a broader audience, making the intricate concepts of FOC more accessible and digestible.
