class driver; 
  mailbox gen2driv, driv2sb; 
  virtual SISO_FIFO_if.DRIVER SISO_FIFO_if; 
  transaction d_trans; 
  event driven; 
   
  function new(mailbox gen2driv,mailbox driv2sb , virtual SISO_FIFO_if.DRIVER 
SISO_FIFO_if, event driven); 
    this.gen2driv=gen2driv;   
    this.SISO_FIFO_if=SISO_FIFO_if; 
    this.driven=driven; 
    this.driv2sb=driv2sb; 
  endfunction 
 
  task main(input int count); 
    repeat(count) begin 
      d_trans=new(); 
      gen2driv.get(d_trans); 
      @(SISO_FIFO_if.driver_cb); 
 
      SISO_FIFO_if.driver_cb.Load <= d_trans.Load; 
      SISO_FIFO_if.driver_cb.Left <= d_trans.Left; 
      SISO_FIFO_if.driver_cb.Din <= d_trans.Din; 
      SISO_FIFO_if.driver_cb.A <= d_trans.A; 
 
      driv2sb.put(d_trans); 
      -> driven; 
    end 
       
  endtask:main 
   
endclass:driver 
