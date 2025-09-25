# 16-Bit-SISO-FIFO-Shift-Register

The 16-bit Serial-In Serial-Out (SISO) FIFO Shift Register is a fundamental component in digital systems, widely used in communication systems, data processing units, and memory management. This project implements a versatile shift register that allows both parallel and serial data handling, enabling efficient data storage and transfer operations. 
In this project, the shift register can perform three key operations: 
1. Parallel Load: The entire 16-bit data can be loaded simultaneously when the ‘Load’ signal is asserted. 
2. Left Shift: When the ‘Left’ control signal is high, the data shifts left by one position, with new bits entering from the least significant bit (LSB). 
3. Right Shift: When the ‘Left’ control signal is low, the data shifts right by one position, with new bits entering from the most significant bit (MSB). 
The clock (‘Clk’) ensures synchronous operation, and the serial input (‘Din’) provides flexibility in serial data transfer. The serial output (‘Dout’) is used to transmit the last shifted bit, making the design suitable for FIFO (First-In-First-Out) operations.
