module tb_SISO_FIFO_ShiftRegister; 
 
    // Testbench signals 
    reg Clk; 
    reg Load; 
    reg Left; 
    reg Din; 
    reg [15:0] A; 
    wire Dout; 
    wire [15:0] register; 
 
 
    SISO_FIFO_ShiftRegister DUT ( 
        .Clk(Clk), 
        .Load(Load), 
        .Left(Left), 
        .Din(Din), 
        .A(A), 
       .Dout(Dout), 
       .register(register) 
    ); 
 
    initial begin 
        Clk = 0; 
        forever #5 Clk = ~Clk; 
    end 
initial begin 
     
      $monitor("Time: %t | Clk: %b | A: %b | Load: %d | Left: %d | Din: %d | Dout: %d 
| Register: %b",$time,Clk, A, Load, Left, Din, Dout, register); 
 
        Load = 0; Left = 0; Din = 0; A = 16'h0000; 
         
        Load = 1; A = 16'hA5A5;  
        #10; 

                Load = 0; 
 
        // Right shift test 
        Left = 0; Din = 1;  
     
      repeat (2) begin 
            #10;     
        end 
 
        // Left shift test 
    
        Left = 1; Din = 0;  
       
 
      repeat (2) begin 
            #10;  
         
        end 
       Load = 1; A = 16'hABCD;  
        #10;  
        
        Load = 0; 
  
       // Again Left shift test  
     
        Left = 1; Din = 0;  
      repeat (2) begin 
            #10;    
        end 
    end 
 
    initial begin 
        $dumpfile("dump.vcd"); 
        $dumpvars; 
        #77; 
 
      $display("All tests completed."); 
        $finish; 
    end 
 
endmodule 
