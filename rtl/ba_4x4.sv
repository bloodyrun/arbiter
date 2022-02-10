module ba_4x4(
  input		            ack,
  input	       [3:0]	req,

  output logic [3:0]	grant,

  input		            clk,
  input		            rst_n
);


function  [3:0] priority_logic;
    input [3:0] in;
    input       en;
    reg   [3:0] out;
begin

    casez({en,in[0],in[1],in[2],in[3]})
      5'b0????:   begin out =  4'b0000; end
      5'b11???:   begin out =  4'b0001; end
      5'b101??:   begin out =  4'b0010; end
      5'b1001?:   begin out =  4'b0100; end
      5'b10001:   begin out =  4'b1000; end
      default: begin out = 4'b0000; end
    endcase
    priority_logic = out;
end
endfunction

logic   [3:0]   token, pout0, pout1, pout2, pout3;


always_ff@(posedge clk or negedge rst_n)
begin
  if(~rst_n) begin
    token <= 4'b0001;
  end else if(ack) begin
    token <= {token[2:0],token[3]};
  end
end


assign pout0 = priority_logic({req[0],req[1],req[2],req[3]},token[0]);
assign pout1 = priority_logic({req[1],req[2],req[3],req[0]},token[1]);
assign pout2 = priority_logic({req[2],req[3],req[0],req[1]},token[2]);
assign pout3 = priority_logic({req[3],req[0],req[1],req[2]},token[3]);

assign  grant[0] = pout0[0] | pout1[3] | pout2[2] | pout3[1] ;
assign  grant[1] = pout0[1] | pout1[0] | pout2[3] | pout3[2] ;
assign  grant[2] = pout0[2] | pout1[1] | pout2[0] | pout3[3] ;
assign  grant[3] = pout0[3] | pout1[2] | pout2[1] | pout3[0] ;

endmodule

