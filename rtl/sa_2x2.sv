
module sa_2x2(
  input		            ack,
  input	       [1:0]	req,

  output logic [1:0]	grant,
  output logic          req0,

  input		            clk,
  input		            rst_n
);

logic   [1:0]   grant_ba;

ba_2x2 u_ba_2x2(
  .ack,
  .req,

  .grant(grant_ba),

  .clk,
  .rst_n
);

assign  req0 = req[0] | req[1];
assign  grant[0] = ack & grant_ba[0];
assign  grant[1] = ack & grant_ba[1];

endmodule

