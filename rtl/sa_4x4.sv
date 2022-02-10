
module sa_4x4(
  input		            ack,
  input	       [3:0]	req,

  output logic [3:0]	grant,
  output logic          req0,

  input		            clk,
  input		            rst_n
);

logic   [3:0]   grant_ba;

ba_4x4 u_ba_4x4(
  .ack,
  .req,

  .grant(grant_ba),

  .clk,
  .rst_n
);

assign  req0 = req[0] | req[1] | req[2] | req[3];
assign  grant[0] = ack & grant_ba[0];
assign  grant[1] = ack & grant_ba[1];
assign  grant[2] = ack & grant_ba[2];
assign  grant[3] = ack & grant_ba[3];

endmodule

