# ARM PROJECT

Our project is based on synthesizing the verilog code of **Cortex M0 Processor** and implementing the Hex Code generated from **Keil Simulator** on **Artrix 7 Basys 3 FPGA Board**.


## Objectives:
- Interfacing AHB-LITE system bus with the Processor
- Writing an assembly code and generation of hex code file for the memory module of AHB-LITE using Keil simulator.
- Using the hex code as input, displaying the output in terms of
	> VIO (Virtual Input/Output) 
  
	> ILA (Integrated Logic Analyzer)
  
	> LEDs on the FPGA
  
- Using the timer code available in the given module that should count from 0000 to FFFF and displaying the timer values on 7-segment display on FPGA.
- Writing a code of factorial in Keil and show the output on the FPGA using LEDs.

## Block Diagram of the Hardware Module
![Block Diagram of the Hardware Module](Project/images/block.jpeg)

## Schematics
- ## LED:

![LED](Project/images/sch_led.jpeg)
- ## VIO and ILA:

![VIO and ILA](Project/images/sch_vio.jpeg)
- ## 7 Segement Display:

![7_Segement_Display](Project/images/sch_7seg.jpeg)

## Results:
- ## VIO output at RESET:

![VIO output at RESET](Project/images/VIO_reset.jpeg)
- ## VIO output at RESET disabled:

![VIO output at RESET disabled](Project/images/VIO.jpeg)
- ## ILA output:

![ILA output](Project/images/ILA.jpeg)
- ## LED output on FPGA:

![LED output on FPGA](Project/images/led.jpeg)
- ## 7 Segment display:

![7 Segment display](Project/images/7seg.jpeg)
- ## 7_Segment_Display when RESET:

![7_Segment_Display when RESET](Project/images/7seg_reset.jpeg)

## Description & Problems Faced:
- We tried displaying 2 values on hardware by giving some delay in the assembly code which had a loop that ran a counter. But, all the three means to display the output showed only the first value. 
- We also wrote an assembly code of factorial and tried implementing the generated hex code on FPGA using LEDs but it didn't work.
- The functionality of timer could not be incorporated in the 7 segment assembly code which resulted in a random value on the 7 segment display of FPGA when RESET is removed.

## Conclusion:
We understood the basics behind AHB-LITE system bus and successfully interfaced it with the core of the processor. We also synthesized the verilog codes and generated bitstream to get it running on the FPGA. The problem that we found was, the decoder in the memory of AHB_LITE could not decipher the LOOPs in assembly. That's why the results we obtained were static in nature. We also couldn't incorporate the concept of delay.



