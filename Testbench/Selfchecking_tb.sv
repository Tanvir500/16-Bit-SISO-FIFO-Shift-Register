module tb_SISO_FIFO_ShiftRegister; 
    reg Clk; 
    reg Load; 
    reg Left; 
    reg Din; 
    reg [15:0] A; 
    wire Dout; 
    wire [15:0] register; 
    reg [15:0] expected_register; 
    reg expected_Dout; 

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
        Load = 0; Left = 0; Din = 0; A = 16'h0000; 
        expected_register = 16'h0000; expected_Dout = 0; 
  //Parallel Load test 
        Load = 1; A = 16'hA5A5;  
        expected_register = 16'hA5A5; 
        #10;  
               Load = 0; 
 $display("At time %0t | Load: %b, Left: %b, Din: %b",$time, DUT.Load, DUT.Left, 
DUT.Din); 
        if (DUT.register !== expected_register) 
            $display("ERROR: Register mismatch at time %0t | Expected: %b, Got: %b", 
$time, expected_register, DUT.register); 
        else 
            $display("CORRECT: Register match at time %0t | Expected: %b, Got: %b", 
$time, expected_register, DUT.register); 
        // Right shift test 
        Left = 0; Din = 1;  
            repeat (3) begin 
            #10; 
            expected_Dout = expected_register[0];  
            expected_register = {Din, expected_register[15:1]};  
  $display("At time %0t | Load: %b, Left: %b, Din: %b",$time, DUT.Load, 
DUT.Left, DUT.Din); 
            if (DUT.register !== expected_register) 
                $display("ERROR: Register mismatch at time %0t | Expected: %b, Got: 
%b", $time, expected_register, DUT.register); 
            else 
                $display("CORRECT: Register match at time %0t | Expected: %b, Got: 
%b", $time, expected_register, DUT.register); 
            if (Dout !== expected_Dout) 
                $display("ERROR: Dout mismatch at time %0t | Expected: %b, Got: %b", 
$time, expected_Dout, Dout); 
            else 
                $display("CORRECT: Dout match at time %0t | Expected: %b, Got: %b", 
$time, expected_Dout, Dout); 
        end 
        // Left shift test 
   
        Left = 1; Din = 0;  
        repeat (3) begin 
            #10;  
            expected_Dout = expected_register[15]; 
            expected_register = {expected_register[14:0], Din};  
     $display("At time %0t | Load: %b, Left: %b, Din: %b",$time, DUT.Load, 
DUT.Left, DUT.Din); 

            if (DUT.register !== expected_register) 
                $display("ERROR: Register mismatch at time %0t | Expected: %b, Got: 
%b", $time, expected_register, DUT.register); 
            else 
                $display("CORRECT: Register match at time %0t | Expected: %b, Got: 
%b", $time, expected_register, DUT.register); 
            if (Dout !== expected_Dout) 
                $display("ERROR: Dout mismatch at time %0t | Expected: %b, Got: %b", 
$time, expected_Dout, Dout); 
            else 
                $display("CORRECT: Dout match at time %0t | Expected: %b, Got: %b", 
$time, expected_Dout, Dout); 
            end 
       Load = 1; A = 16'hABCD;  
        expected_register = 16'hABCD; 
        #10;  
               Load = 0; 
 $display("At time %0t | Load: %b, Left: %b, Din: %b",$time, DUT.Load, DUT.Left, 
DUT.Din); 
        if (DUT.register !== expected_register) 
            $display("ERROR: Register mismatch at time %0t | Expected: %b, Got: %b", 
$time, expected_register, DUT.register); 
        else 
            $display("CORRECT: Register match at time %0t | Expected: %b, Got: %b", 
$time, expected_register, DUT.register); 
   
       // Again Left shift test  
        Left = 1; Din = 0;  
        repeat (3) begin 
            #10;  
            expected_Dout = expected_register[15]; 
            expected_register = {expected_register[14:0], Din};  
     $display("At time %0t | Load: %b, Left: %b, Din: %b",$time, DUT.Load, 
DUT.Left, DUT.Din); 
           
            if (DUT.register !== expected_register) 
                $display("ERROR: Register mismatch at time %0t | Expected: %b, Got: 
%b", $time, expected_register, DUT.register); 
            else 
                $display("CORRECT: Register match at time %0t | Expected: %b, Got: 
%b", $time, expected_register, DUT.register); 
 
            if (Dout !== expected_Dout) 
                $display("ERROR: Dout mismatch at time %0t | Expected: %b, Got: %b", 
$time, expected_Dout, Dout); 
            else 
                $display("CORRECT: Dout match at time %0t | Expected: %b, Got: %b", 
$time, expected_Dout, Dout); 
        end 
        $display("All tests completed."); 
    end 

      initial begin 
          $dumpfile("dump.vcd"); 
          $dumpvars; 
          #120; 
          $finish; 
      end 
      endmodule 
