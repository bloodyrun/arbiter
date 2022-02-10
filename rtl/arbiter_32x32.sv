
module arbiter_32x32(
  input	       [31:0]	req,
  //input               ack,

  output logic [31:0]	grant,

  input		            clk,
  input		            rst_n
);

logic up_ack0, up_ack1, up_ack2, up_ack3;
logic [7:0] req_lv1, ack_lv1;
logic [1:0] up_req, up_ack;

sa_4x4 u_sa_4x4_lv1_0(
  .ack(ack_lv1[0]),
  .req(req[3:0]),

  .grant(grant[3:0]),
  .req0(req_lv1[0]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_1(
  .ack(ack_lv1[1]),
  .req(req[7:4]),

  .grant(grant[7:4]),
  .req0(req_lv1[1]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_2(
  .ack(ack_lv1[2]),
  .req(req[11:8]),

  .grant(grant[11:8]),
  .req0(req_lv1[2]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_3(
  .ack(ack_lv1[3]),
  .req(req[15:12]),

  .grant(grant[15:12]),
  .req0(req_lv1[3]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_4(
  .ack(ack_lv1[4]),
  .req(req[19:16]),

  .grant(grant[19:16]),
  .req0(req_lv1[4]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_5(
  .ack(ack_lv1[5]),
  .req(req[23:20]),

  .grant(grant[23:20]),
  .req0(req_lv1[5]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_6(
  .ack(ack_lv1[6]),
  .req(req[27:24]),

  .grant(grant[27:24]),
  .req0(req_lv1[6]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv1_7(
  .ack(ack_lv1[7]),
  .req(req[31:28]),

  .grant(grant[31:28]),
  .req0(req_lv1[7]),

  .clk,
  .rst_n
);

//level 2 4x4 merge
sa_4x4 u_sa_4x4_lv2_0(
  .ack(up_ack[0]),
  .req(req_lv1[3:0]),

  .grant(ack_lv1[3:0]),
  .req0(up_req[0]),

  .clk,
  .rst_n
);

sa_4x4 u_sa_4x4_lv2_1(
  .ack(up_ack[1]),
  .req(req_lv1[7:4]),

  .grant(ack_lv1[7:4]),
  .req0(up_req[1]),

  .clk,
  .rst_n
);

// root 

root_sa_2x2 u_root_sa_2x2_0(
  .req(up_req),

  .ack(up_ack),

  .clk,
  .rst_n
);

endmodule

