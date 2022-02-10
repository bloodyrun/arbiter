//`define ARBITER_8X8_TYPE1

module arbiter_8x8_type1(
  input	       [7:0]	req,
  //input               ack,

  output logic [7:0]	grant,

  input		            clk,
  input		            rst_n
);

logic up_ack0, up_ack1, up_ack2, up_ack3;
logic [3:0] up_req;

sa_2x2 u_sa_2x2_0(
  .ack(up_ack0),
  .req(req[1:0]),

  .grant(grant[1:0]),
  .req0(up_req[0]),

  .clk,
  .rst_n
);

sa_2x2 u_sa_2x2_1(
  .ack(up_ack1),
  .req(req[3:2]),

  .grant(grant[3:2]),
  .req0(up_req[1]),

  .clk,
  .rst_n
);

sa_2x2 u_sa_2x2_2(
  .ack(up_ack2),
  .req(req[5:4]),

  .grant(grant[5:4]),
  .req0(up_req[2]),

  .clk,
  .rst_n
);

sa_2x2 u_sa_2x2_3(
  .ack(up_ack3),
  .req(req[7:6]),

  .grant(grant[7:6]),
  .req0(up_req[3]),

  .clk,
  .rst_n
);

root_sa_4x4 u_root_sa_4x4_0(
  .req(up_req),

  .ack({up_ack3,up_ack2,up_ack1,up_ack0}),

  .clk,
  .rst_n
);

endmodule

