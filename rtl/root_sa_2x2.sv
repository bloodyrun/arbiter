module root_sa_2x2(
  input	       [1:0]	req,

  output logic [1:0]	ack,

  input		            clk,
  input		            rst_n
);


function  [1:0] priority_logic;
    input [1:0] in;
    input       en;
    reg   [1:0] out;
begin

    casez({en,in[0],in[1]})
      3'b0??:   begin out =  2'b00; end
      3'b11?:   begin out =  2'b01; end
      3'b101:   begin out =  2'b10; end
      default: begin out = 2'b00; end
    endcase
    priority_logic = out;
end
endfunction

logic   [1:0]   token, pout0, pout1;


always_ff@(posedge clk or negedge rst_n)
begin
  if(~rst_n) begin
    token <= 2'b01;
  end else /*if(ack) */begin
    token <= {token[0],token[1]};
  end
end


assign pout0 = priority_logic({req[0],req[1]},token[0]);
assign pout1 = priority_logic({req[1],req[0]},token[1]);

assign  ack[0] = pout0[0] | pout1[1] ;
assign  ack[1] = pout0[1] | pout1[0] ;

endmodule

