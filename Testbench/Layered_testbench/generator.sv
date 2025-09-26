‘include "transaction.sv" 
 
class generator; 
  mailbox gen2driv; 
  transaction g_trans; 
   
  function new(mailbox gen2driv); 
    this.gen2driv=gen2driv; 
  endfunction 
   
  task main(input int count); 
    repeat(count) begin 
      g_trans=new(); 
      g_trans=new g_trans;  
      assert(g_trans.randomize()); 
      gen2driv.put(g_trans); 
    end 
  endtask:main 
   
endclass:generator 
