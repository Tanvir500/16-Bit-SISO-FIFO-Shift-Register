module SISO_FIFO_ShiftRegister ( 
    input         Clk,            
    input         Load,           
    input         Left,    
    input         Din,           
    input  [15:0] A,              
    output    reg    Dout, 
   output reg[15:0] register 
); 
  
 
    always @(posedge Clk)  
      begin 
        if (Load)  
          begin 
            register <= A; 
          end  
 
        else  
          begin 
            if (Left)  
              begin 
                Dout <= (register[15]); 
                register <= {register[14:0], Din};          
              end  
 
            else  
              begin 
                Dout <= register[0]; 
                register <= {Din, register[15:1]};               
              end 
          end 
       end 
 
endmodule
