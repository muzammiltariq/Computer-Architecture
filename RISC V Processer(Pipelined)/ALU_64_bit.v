module ALU_64_bit(
	input [63:0]a,
	input [63:0]b,
	input [3:0]AluOp,
	output reg [63:0]Result,
	output reg Zero,
	output reg Great
);

wire abar,bbar;
reg mux1out,mux2out;
assign abar = ~a;
assign bbar = ~b;

always @*
begin
	if (AluOp[3] == 0)
		mux1out = a;
	else if (AluOp[3] == 1)
		mux1out = abar;
end
always @*
begin
	if (AluOp[2] == 0)
		mux2out = b;
	else if (AluOp[2] == 1)
		mux2out = bbar;
end

always @(*)
begin
	begin
		case(AluOp)
		4'b0000: begin
			Result = mux1out & mux2out;
				end
		4'b0001: begin 
			Result = mux1out | mux2out;
				end
		4'b0010:begin
			Result = mux1out + mux2out;
				end
		4'b0110:begin
			Result = mux1out + mux2out;
				end
		4'b1100: begin 
			Result = mux1out & mux2out;
				end
			endcase 
	end
	if (64'd0 == Result)
		begin
			Zero = 1'b1;
			
		end
	else
		begin
			Zero = 1'b0;

		end
	if (Result > 64'd0)  // a>b a-b>0
		begin
			Great = 1'b1;
		end
	else
		begin
			Great = 1'b0;
		end
	
end
endmodule 