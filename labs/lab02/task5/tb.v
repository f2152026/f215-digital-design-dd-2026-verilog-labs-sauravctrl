// tb.v -- self-checking testbench for alu.v
module tb;
  reg  [3:0] a, b;
  reg        op;
  wire [3:0] result;
  reg  [3:0] exp;
  integer i, j, errors, total;

  alu DUT (.a(a), .b(b), .op(op), .result(result));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  task check;
    begin
      #5;
      exp = op ? (a - b) : (a + b);
      total = total + 1;
      if (result !== exp) begin
        $display("FAIL t=%0t a=%0d b=%0d op=%b got=%0d exp=%0d", $time, a, b, op, result, exp);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    errors = 0; total = 0;
    // same operands, switch op
    a = 5; b = 3; op = 0; check;
    op = 1; check;
    op = 0; check;
    // exhaustive, operands changing
    for (i = 0; i < 16; i = i + 1)
      for (j = 0; j < 16; j = j + 1) begin
        a = i; b = j; op = 0; check;
        op = 1; check;
      end
    $write("%0d/%0d passed", total - errors, total);
    if (errors == 0) $display(" -- SUCCESS"); else $display(" -- FAILED (%0d errors)", errors);
    $finish;
  end
endmodule
