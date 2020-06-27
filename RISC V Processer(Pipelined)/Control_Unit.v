module Control_Unit(
	input [6:0] Opcode,
	input [2:0] funct3,
	output reg [1:0]ALUOp,
	output reg BranchEq,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,BranchGt
);

always@(*)
begin
	case(Opcode)
		7'b0110011:
		begin
			ALUOp = 2'b10;
			ALUSrc = 1'b0;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemWrite = 1'b0;
			BranchEq = 1'b0;
            BranchGt = 1'b0;
		end
		7'b0000011:
		begin
			ALUOp = 2'b00;
			ALUSrc = 1'b1;
			MemtoReg = 1'b1;
			RegWrite = 1'b1;
			MemRead = 1'b1;
			MemWrite = 1'b0;
			BranchEq = 1'b0;
            BranchGt = 1'b0;			
		end
		7'b0100011:
		begin
			ALUOp = 2'b00;
			ALUSrc = 1'b1;
			MemtoReg = 1'bx; // MemtoReg is not used in this code
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemWrite = 1'b1;
			BranchEq = 1'b0;
            BranchGt = 1'b0;
		end
		7'b1100011:
		begin
			ALUOp = 2'b01;
			ALUSrc = 1'b0;
			MemtoReg = 1'bx; // MemtoReg is not used in this code
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemWrite = 1'b0;
			BranchEq = 1'b0;
            BranchGt = 1'b0;
		end
		7'b0010011:
		begin
			ALUOp = 2'b00;
			ALUSrc = 1'b1;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b1;
			MemWrite = 1'b0;


			if (funct3 == 3'b000)
                begin
                    BranchEq = 1'b1;
                    BranchGt = 1'b0;
                end
            else
                begin
                    BranchEq = 1'b0;
                    BranchGt = 1'b1;
                end
		end
	endcase
end 
endmodule 