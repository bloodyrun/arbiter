//`define ARBITER_8X8_TYPE0
//`define ARBITER_8X8_TYPE1

module arbiter_8x8_type0(
  input	       [7:0]	req,
  //input               ack,

  output logic [7:0]	grant,

  input		            clk,
  input		            rst_n
);

logic up_ack0, up_ack1;
logic [1:0] up_req;

sa_4x4 u_sa_4x4_0(
  .ack(up_ack0),
  .req(req[3:0]),

  .grant(grant[3:0]),
  .req0(up_req[0]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_1(
  .ack(up_ack1),
  .req(req[7:4]),

  .grant(grant[7:4]),
  .req0(up_req[1]),

  .clk,
  .rst_n
);


root_sa_2x2 u_root_sa_2x2_0(
  .req(up_req),

  .ack({up_ack1,up_ack0}),

  .clk,
  .rst_n
);

endmodule

