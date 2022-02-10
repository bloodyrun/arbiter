
module arbiter_16x16(
  input	       [15:0]	req,
  //input               ack,

  output logic [15:0]	grant,

  input		            clk,
  input		            rst_n
);

logic up_ack0, up_ack1, up_ack2, up_ack3;
logic [3:0] up_req;

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

sa_4x4 u_sa_4x4_2(
  .ack(up_ack2),
  .req(req[11:8]),

  .grant(grant[11:8]),
  .req0(up_req[2]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_3(
  .ack(up_ack3),
  .req(req[15:12]),

  .grant(grant[15:12]),
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

