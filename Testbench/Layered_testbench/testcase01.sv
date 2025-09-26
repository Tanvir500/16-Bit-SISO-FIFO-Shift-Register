‘include "environment.sv" 
 
program test(input int count, SISO_FIFO_if SF); 
  environment env; 
   
  class testcase01 extends transaction; 
    constraint c_s { 
       A inside {[0:65535]};  
      
      Load inside {[0:1]};  
      Left inside {[0:1]};     
      Din inside {[0:1]};  
    } 
  endclass:testcase01 
   
  initial begin 
    testcase01 testcase01handle; 
    testcase01handle=new(); 
    env=new(SF); 
 
    env.gen.g_trans=testcase01handle; 
 
    env.main(count); 
  end 
   
endprogram:test 
