// tb.v -- self-checking testbench for lut
module tb;
  reg  [2:0] t_sel;
  wire [7:0] t_dout;
  integer i, errors;

  lut #(.WIDTH(8), .DEPTH(8)) DUT (.sel(t_sel), .dout(t_dout));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i; #5;
      if (t_dout !== i*i) begin
        $display("FAIL sel=%0d got=%0d exp=%0d", i, t_dout, i*i);
        errors = errors + 1;
      end
    end
    if (errors == 0) $display("SUCCESS: 8/8 passed"); else $display("FAILED: %0d errors", errors);
    $finish;
  end

  initial $monitor($time, " sel=%b | dout=%d", t_sel, t_dout);
endmodule
