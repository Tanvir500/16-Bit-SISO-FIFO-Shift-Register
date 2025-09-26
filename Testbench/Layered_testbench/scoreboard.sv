class scoreboard; 
  mailbox driv2sb; 
  mailbox mon2sb; 
   
  transaction d_trans; 
  transaction m_trans; 
   bit [15:0] temp;  
    
  real in_type [8]='{default: 64'b0}; 
  real Pass [8]='{default: 64'b0}; 
  real Fail [8]='{default: 64'b0}; 
  real in_per [8],fail_per [8], pass_per [8];  
  logic [2:0] in_concat; 
   
   
  function new(mailbox driv2sb, mon2sb); 
    this.driv2sb=driv2sb; 
    this.mon2sb=mon2sb; 
  endfunction 
   
  task main(input int count); 
    $display("------------------Scoreboard Test Starts--------------------"); 
    repeat(count) begin 
      m_trans=new(); 
      mon2sb.get(m_trans); 
      report(); 
       
      in_concat = {d_trans.Load,d_trans.Left,d_trans.Din}; 
      if (m_trans.register != d_trans.register) 
        begin 
          $display("time=%d  A = %b   Failed : Load=%d Left=%d  Din=%d Expected_Dout=%d  
Resulted_Dout=%d Expected_register=%b  
Resulted_register=%b",$time,d_trans.A,d_trans.Load,d_trans.Left,d_trans.Din,d_trans.D
 out,m_trans.Dout,d_trans.register,m_trans.register); 
 
        if(in_concat==3'b000) 
            Fail[0]=Fail[0]+1; 
          else if(in_concat==3'b001) 
            Fail[1]=Fail[1]+1; 
          else if(in_concat==3'b010) 
            Fail[2]=Fail[2]+1; 
          else if(in_concat==3'b011) 
            Fail[3]=Fail[3]+1; 
          else if(in_concat==3'b100) 
            Fail[4]=Fail[4]+1; 
          else if(in_concat==3'b101) 
            Fail[5]=Fail[5]+1; 
          else if(in_concat==3'b110) 
            Fail[6]=Fail[6]+1; 
          else if(in_concat==3'b111) 
            Fail[7]=Fail[7]+1; 
         
         
        end 
        else  
          begin 
            $display("time=%d  A = %b   Passed : Load=%d Left=%d  Din=%d 
Expected_Dout=%x  Resulted_Dout=%d Expected_register=%b  
Resulted_register=%b",$time,d_trans.A,d_trans.Load,d_trans.Left,d_trans.Din,d_trans.D
 out,m_trans.Dout,d_trans.register,m_trans.register); 

            if(in_concat==3'b000) 
            Pass[0]=Pass[0]+1; 
          else if(in_concat==3'b001) 
            Pass[1]=Pass[1]+1; 
          else if(in_concat==3'b010) 
            Pass[2]=Pass[2]+1; 
          else if(in_concat==3'b011) 
            Pass[3]=Pass[3]+1; 
          else if(in_concat==3'b100) 
            Pass[4]=Pass[4]+1; 
          else if(in_concat==3'b101) 
            Pass[5]=Pass[5]+1; 
          else if(in_concat==3'b110) 
            Pass[6]=Pass[6]+1; 
          else if(in_concat==3'b111) 
            Pass[7]=Pass[7]+1; 
           
           
          end 
       
    end 
     
    in_per[0]=(in_type[0]*100)/count; 
    in_per[1]=(in_type[1]*100)/count; 
    in_per[2]=(in_type[2]*100)/count; 
    in_per[3]=(in_type[3]*100)/count; 
    in_per[4]=(in_type[4]*100)/count; 
    in_per[5]=(in_type[5]*100)/count; 
    in_per[6]=(in_type[6]*100)/count; 
    in_per[7]=(in_type[7]*100)/count; 
     
    pass_per[0]=(Pass[0]*100)/in_type[0]; 
    pass_per[1]=(Pass[1]*100)/in_type[1]; 
    pass_per[2]=(Pass[2]*100)/in_type[2]; 
    pass_per[3]=(Pass[3]*100)/in_type[3]; 
    pass_per[4]=(Pass[4]*100)/in_type[4]; 
    pass_per[5]=(Pass[5]*100)/in_type[5]; 
    pass_per[6]=(Pass[6]*100)/in_type[6]; 
    pass_per[7]=(Pass[7]*100)/in_type[7]; 
     
    fail_per[0]=(Fail[0]*100)/in_type[0]; 
    fail_per[1]=(Fail[1]*100)/in_type[1]; 
    fail_per[2]=(Fail[2]*100)/in_type[2]; 
    fail_per[3]=(Fail[3]*100)/in_type[3]; 
    fail_per[4]=(Fail[4]*100)/in_type[4]; 
    fail_per[5]=(Fail[5]*100)/in_type[5]; 
    fail_per[6]=(Fail[6]*100)/in_type[6]; 
    fail_per[7]=(Fail[7]*100)/in_type[7]; 

         $display("\n\n------------------Displaying Covergae Results-------------------
\n\n"); 
     
    $display("Case-Type 1: {Load,Left,Din}='000'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[0],in_per[0],pass_per[0],fail_per[0]); 
    $display("Case-Type 2: {Load,Left,Din}='001'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[1],in_per[1],pass_per[1],fail_per[1]); 
    $display("Case-Type 3: {Load,Left,Din}='010'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[2],in_per[2],pass_per[2],fail_per[2]); 
    $display("Case-Type 4: {Load,Left,Din}='011'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[3],in_per[3],pass_per[3],fail_per[3]); 
    $display("Case-Type 5: {Load,Left,Din}='100'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[4],in_per[4],pass_per[4],fail_per[4]); 
    $display("Case-Type 6: {Load,Left,Din}='101'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[5],in_per[5],pass_per[5],fail_per[5]); 
    $display("Case-Type 7: {Load,Left,Din}='110'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[6],in_per[6],pass_per[6],fail_per[6]); 
    $display("Case-Type 8: {Load,Left,Din}='111'=%0.0f cases with percentage=%f.Pass 
rate=%f,Fail rate=%f",in_type[7],in_per[7],pass_per[7],fail_per[7]); 
     
     
     
    $display("\n\n------------------Scoreboard Test Ends--------------------\n"); 
  endtask:main 
   
  task report(); 
    
      d_trans=new(); 
    driv2sb.get(d_trans); 
     
      if (d_trans.Load)  
          begin 
            d_trans.register = d_trans.A; 
            temp = d_trans.register; 
           end  
        else  
          begin 
 
            if (d_trans.Left)  
              begin 
                d_trans.Dout = temp[15]; 
                d_trans.register = {temp[14:0], d_trans.Din}; 
 
               temp = d_trans.register; 
              end  
            else  
              begin 
 
                d_trans.Dout = temp[0]; 
                d_trans.register = {d_trans.Din,temp[15:1]}; 
               temp = d_trans.register; 
      end 
end 
      in_concat={d_trans.Load,d_trans.Left,d_trans.Din}; 
    if(in_concat==3'b000) 
      in_type[0]=in_type[0]+1; 
    else if(in_concat==3'b001) 
      in_type[1]=in_type[1]+1; 
    else if(in_concat==3'b010) 
      in_type[2]=in_type[2]+1; 
    else if(in_concat==3'b011) 
      in_type[3]=in_type[3]+1; 
    else if(in_concat==3'b100) 
      in_type[4]=in_type[4]+1; 
    else if(in_concat==3'b101) 
      in_type[5]=in_type[5]+1; 
    else if(in_concat==3'b110) 
      in_type[6]=in_type[6]+1; 
    else if(in_concat==3'b111) 
      in_type[7]=in_type[7]+1; 
    
    endtask:report 
             
endclass:scoreboard 
