// cla64_hier.v

module cla64_hier(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [15:0] Pblk, Gblk;
  wire [16:0] cbin;

  assign cbin[0] = cin;

  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
      xor #(2) (p[i], a[i], b[i]);
      and #(2) (g[i], a[i], b[i]);
    end
  endgenerate

  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_blk_pg
      and #(2) (Pblk[i], p[4*i], p[4*i+1], p[4*i+2], p[4*i+3]);
      wire t0, t1;
      and #(2) (t0, p[4*i+3], p[4*i+2], g[4*i+1]);
      and #(2) (t1, p[4*i+3], p[4*i+2], p[4*i+1], g[4*i]);
      or  #(2) (Gblk[i], g[4*i+3], p[4*i+3] & g[4*i+2], t0, t1);
    end
  endgenerate

  assign #(2) cbin[1] = Gblk[0] | (Pblk[0]&cin);
  assign #(2) cbin[2] = Gblk[1] | (Pblk[1]&Gblk[0]) | (Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[3] = Gblk[2] | (Pblk[2]&Gblk[1]) | (Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[4] = Gblk[3] | (Pblk[3]&Gblk[2]) | (Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[5] = Gblk[4] | (Pblk[4]&Gblk[3]) | (Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[6] = Gblk[5] | (Pblk[5]&Gblk[4]) | (Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[7] = Gblk[6] | (Pblk[6]&Gblk[5]) | (Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[8] = Gblk[7] | (Pblk[7]&Gblk[6]) | (Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[9] = Gblk[8] | (Pblk[8]&Gblk[7]) | (Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[10] = Gblk[9] | (Pblk[9]&Gblk[8]) | (Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[11] = Gblk[10] | (Pblk[10]&Gblk[9]) | (Pblk[10]&Pblk[9]&Gblk[8]) | (Pblk[10]&Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[12] = Gblk[11] | (Pblk[11]&Gblk[10]) | (Pblk[11]&Pblk[10]&Gblk[9]) | (Pblk[11]&Pblk[10]&Pblk[9]&Gblk[8]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[13] = Gblk[12] | (Pblk[12]&Gblk[11]) | (Pblk[12]&Pblk[11]&Gblk[10]) | (Pblk[12]&Pblk[11]&Pblk[10]&Gblk[9]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Gblk[8]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[14] = Gblk[13] | (Pblk[13]&Gblk[12]) | (Pblk[13]&Pblk[12]&Gblk[11]) | (Pblk[13]&Pblk[12]&Pblk[11]&Gblk[10]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Gblk[9]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Gblk[8]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[15] = Gblk[14] | (Pblk[14]&Gblk[13]) | (Pblk[14]&Pblk[13]&Gblk[12]) | (Pblk[14]&Pblk[13]&Pblk[12]&Gblk[11]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Gblk[10]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Gblk[9]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Gblk[8]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);
  assign #(2) cbin[16] = Gblk[15] | (Pblk[15]&Gblk[14]) | (Pblk[15]&Pblk[14]&Gblk[13]) | (Pblk[15]&Pblk[14]&Pblk[13]&Gblk[12]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Gblk[11]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Gblk[10]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Gblk[9]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Gblk[8]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Gblk[7]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Gblk[6]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Gblk[5]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Gblk[4]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Gblk[3]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Gblk[2]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Gblk[1]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Gblk[0]) | (Pblk[15]&Pblk[14]&Pblk[13]&Pblk[12]&Pblk[11]&Pblk[10]&Pblk[9]&Pblk[8]&Pblk[7]&Pblk[6]&Pblk[5]&Pblk[4]&Pblk[3]&Pblk[2]&Pblk[1]&Pblk[0]&cin);

  assign cout = cbin[16];

  cla4 block0  (.a(a[3:0]),    .b(b[3:0]),    .cin(cbin[0]),  .sum(sum[3:0]),    .cout());
  cla4 block1  (.a(a[7:4]),    .b(b[7:4]),    .cin(cbin[1]),  .sum(sum[7:4]),    .cout());
  cla4 block2  (.a(a[11:8]),   .b(b[11:8]),   .cin(cbin[2]),  .sum(sum[11:8]),   .cout());
  cla4 block3  (.a(a[15:12]),  .b(b[15:12]),  .cin(cbin[3]),  .sum(sum[15:12]),  .cout());
  cla4 block4  (.a(a[19:16]),  .b(b[19:16]),  .cin(cbin[4]),  .sum(sum[19:16]),  .cout());
  cla4 block5  (.a(a[23:20]),  .b(b[23:20]),  .cin(cbin[5]),  .sum(sum[23:20]),  .cout());
  cla4 block6  (.a(a[27:24]),  .b(b[27:24]),  .cin(cbin[6]),  .sum(sum[27:24]),  .cout());
  cla4 block7  (.a(a[31:28]),  .b(b[31:28]),  .cin(cbin[7]),  .sum(sum[31:28]),  .cout());
  cla4 block8  (.a(a[35:32]),  .b(b[35:32]),  .cin(cbin[8]),  .sum(sum[35:32]),  .cout());
  cla4 block9  (.a(a[39:36]),  .b(b[39:36]),  .cin(cbin[9]),  .sum(sum[39:36]),  .cout());
  cla4 block10 (.a(a[43:40]),  .b(b[43:40]),  .cin(cbin[10]), .sum(sum[43:40]),  .cout());
  cla4 block11 (.a(a[47:44]),  .b(b[47:44]),  .cin(cbin[11]), .sum(sum[47:44]),  .cout());
  cla4 block12 (.a(a[51:48]),  .b(b[51:48]),  .cin(cbin[12]), .sum(sum[51:48]),  .cout());
  cla4 block13 (.a(a[55:52]),  .b(b[55:52]),  .cin(cbin[13]), .sum(sum[55:52]),  .cout());
  cla4 block14 (.a(a[59:56]),  .b(b[59:56]),  .cin(cbin[14]), .sum(sum[59:56]),  .cout());
  cla4 block15 (.a(a[63:60]),  .b(b[63:60]),  .cin(cbin[15]), .sum(sum[63:60]),  .cout());

endmodule
