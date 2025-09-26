class monitor; 
  mailbox mon2sb; 
  virtual SISO_FIFO_if.MONITOR SF; 
  transaction m_trans; 
  event driven; 
   
  function new(mailbox mon2sb, virtual SISO_FIFO_if.MONITOR SF, event driven); 
    this.mon2sb=mon2sb; 
    this.SF=SF; 
    this.driven=driven; 
  endfunction 
   
  task main(input int count); 
    @(driven); 
   
    repeat(count) begin 
      @(SF.mon_cb); 
      m_trans=new(); 
      @(posedge SF.Clk); 
      m_trans.Load=SF.mon_cb.Load; 
      m_trans.Left=SF.mon_cb.Left; 
      m_trans.Din=SF.mon_cb.Din; 
      m_trans.A=SF.mon_cb.A; 
      m_trans.Dout=SF.mon_cb.Dout; 
      m_trans.register=SF.mon_cb.register; 
      mon2sb.put(m_trans); 
    end 
  endtask:main 
   
endclass:monitor 
