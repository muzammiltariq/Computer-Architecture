module extractor(
	input [31:0]instruction,
	output reg [63:0] imm_data
);
reg [11:0]new;
always@* begin
if (instruction[5:4] == 2'b10 || 2'b11)
	assign new = {instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
else if (instruction[5:4] == 2'b00)
	assign new = instruction[31:20];
else if (instruction[5:4] == 2'b01)
	assign new = {instruction[31:25],instruction[11:7]};

end

always@*
  begin 
    imm_data <= $unsigned(new);
  end
 
endmodule 