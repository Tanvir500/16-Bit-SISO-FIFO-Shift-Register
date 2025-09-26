interface SISO_FIFO_if(input Clk); 
  logic Load; 
  logic Left; 
  logic Din; 
  logic [15:0] A; 
  logic Dout; 
  logic [15:0] register; 
   
  clocking driver_cb @(negedge Clk); 
    default input #1 output #1; 
    output Load,Left,Din,A; 
  endclocking 
   
  clocking mon_cb @(negedge Clk); 
    default input #1 output #1; 
    input Load,Left,Din,A; 
    input Dout,register; 
  endclocking 
   
  modport DRIVER (clocking driver_cb, input Clk); 
  modport MONITOR (clocking mon_cb, input Clk); 
endinterface 
