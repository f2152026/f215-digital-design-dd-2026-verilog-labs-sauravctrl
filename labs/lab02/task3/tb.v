// tb.v
// Self-checking testbench for comp2.v

module tb;

  reg  [1:0] A;
  reg  [1:0] B;
  wire       GT;
  wire       LT;
  wire       EQ;

  comp2 DUT (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i, j;
  reg exp_GT, exp_LT, exp_EQ;
  integer errors = 0;

  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i[1:0];
        B = j[1:0];
        #5;
        
        exp_GT = (A > B);
        exp_LT = (A < B);
        exp_EQ = (A == B);
        
        if ((GT !== exp_GT) || (LT !== exp_LT) || (EQ !== exp_EQ)) begin
          $display("ERROR at time %0t: A=%b B=%b | DUT (GT:%b LT:%b EQ:%b) | EXP (GT:%b LT:%b EQ:%b)", 
                    $time, A, B, GT, LT, EQ, exp_GT, exp_LT, exp_EQ);
          errors = errors + 1;
        end
      end
    end
    
    if (errors == 0)
      $display("SUCCESS: All tests passed!");
    else
      $display("FAILED: %0d errors found.", errors);
      
    $finish;
  end

endmodule