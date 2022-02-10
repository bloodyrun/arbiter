`timescale 1ns/1ps

module testbench;

//clock reset
bit clk, rst_n;

initial begin
    clk=0;
end

always
begin
    #(1000.0/100.0/2) clk = ~clk;
end

//test variables
bit [31:0]   request_bus;
bit [3:0]    grant_4x4;
bit [7:0]    grant_8x8;
bit [15:0]   grant_16x16;
bit [31:0]   grant_32x32;

initial
begin
  request_bus = 0;

  rst_n = 1;
  #100;
  @(posedge clk);
  rst_n = 0;
  @(posedge clk);
  rst_n = 1;
  
  @(posedge clk);
  #1;
  request_bus = 32'hFFFF_FFFF;//$random;
  repeat(32)@(posedge clk);
  #1;
  request_bus = 0;

    #1000
    $finish;
end

/////////////////
// arbiter 4x4 //
/////////////////
arbiter_4x4 u_arbiter_4x4(
  .req(request_bus[3:0]),

  .grant(grant_4x4),

  .clk,
  .rst_n
);


/////////////////
// arbiter 8x8 //
/////////////////
arbiter_8x8_type0 u_arbiter_8x8_t0(
  .req(request_bus[7:0]),

  .grant(),

  .clk,
  .rst_n
);

arbiter_8x8_type1 u_arbiter_8x8_t1(
  .req(request_bus[7:0]),

  .grant(),

  .clk,
  .rst_n
);



///////////////////
// arbiter 16x16 //
///////////////////
arbiter_16x16 u_arbiter_16x16(
  .req(request_bus[15:0]),

  .grant(),

  .clk,
  .rst_n
);


///////////////////
// arbiter 32x32 //
///////////////////
arbiter_32x32 u_arbiter_32x32(
  .req(request_bus[31:0]),

  .grant(),

  .clk,
  .rst_n
);



initial
begin
    $display("==start==");
    #1000;
    $display("==end==");
    $finish;
end

initial
begin
    $fsdbDumpfile("testbench.fsdb");
    $fsdbDumpvars(0, testbench);
    #1000;
    $finish;
end

endmodule

