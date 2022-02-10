module arbiter_4x4(
  input	       [3:0]	req,
  //input               ack,

  output logic [3:0]	grant,

  input		            clk,
  input		            rst_n
);

logic up_ack0, up_ack1;
logic [1:0] up_req;

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


root_sa_2x2 u_root_sa_2x2_0(
  .req(up_req),

  .ack({up_ack1,up_ack0}),

  .clk,
  .rst_n
);

endmodule

