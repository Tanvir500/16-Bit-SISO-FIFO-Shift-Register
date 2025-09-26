‘include "testcase01.sv" 
‘include "interface.sv" 
 
module testbench; 
  bit Clk; 
  initial begin 
    Clk = 0; 
    forever #5 Clk =~Clk; 
  end 
   
  int count=30; 
   
  SISO_FIFO_if SF(Clk); 
   
  test test01(count,SF); 
  
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars; 
  end 
   
  SISO_FIFO_ShiftRegister DUT ( 
    .Clk(SF.Clk), 
    .Load(SF.Load), 
    .Left(SF.Left), 
    .Din(SF.Din), 
    .A(SF.A), 
    .Dout(SF.Dout), 
    .register(SF.register) 
  ); 
  
endmodule 
