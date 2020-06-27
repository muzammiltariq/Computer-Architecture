module Forwarding_Unit(
    input [4:0] ID_EX_rs1, ID_EX_rs2,
	input [4:0] EX_MEM_rd,
	input EX_MEM_RegWrite,
	input [4:0] MEM_WB_rd,
	input MEM_WB_RegWrite,
	output reg [1:0] Forward_A, Forward_B

);
always @(*)
begin
	if (EX_MEM_RegWrite == 1 && EX_MEM_rd != 0 && EX_MEM_rd == ID_EX_rs1)
		begin
			Forward_A = 2'b10;
		end
	else if (MEM_WB_RegWrite == 1 && MEM_WB_rd != 0 && MEM_WB_rd == ID_EX_rs1 && !(EX_MEM_RegWrite == 1 && EX_MEM_rd != 0 && EX_MEM_rd != ID_EX_rs1))
		begin
			Forward_A = 2'b01;
		end
	else
		begin
			Forward_A = 2'b00;
		end
	if (EX_MEM_RegWrite == 1 && EX_MEM_rd != 0 && EX_MEM_rd == ID_EX_rs2)
		begin
			Forward_B = 2'b10;
		end
	else if (MEM_WB_RegWrite == 1 && MEM_WB_rd != 0 && MEM_WB_rd == ID_EX_rs2 && !(EX_MEM_RegWrite == 1 && EX_MEM_rd != 0 && EX_MEM_rd != ID_EX_rs2))
		begin
			Forward_B = 2'b01;
		end
	else 
		begin
			Forward_B = 2'b00;
		end
end
endmodule