module Processor(
    input clk, reset

);

wire [63:0] PC_Out_p; wire [63:0] PC_4_Adder_p; wire [63:0] MUX_Branch_p; wire [31:0] Instruction_p; 
wire [2:0] funct3_p; wire [6:0] funct7_p; 
//IF_ID

wire [31:0] IF_ID_Instruction_p;
wire [6:0] IF_ID_opcode_p; wire [4:0] IF_ID_rs1_p; wire [4:0] IF_ID_rs2_p; wire [4:0] IF_ID_rd_p;
wire [63:0] IF_ID_ReadData1_p; wire [63:0] IF_ID_ReadData2_p; wire [63:0] IF_ID_imm_data_p; wire [63:0] IF_ID_PC_Out_p; 
wire IF_ID_ALUSrc_p; wire [1:0] IF_ID_ALUOp_p;
wire IF_ID_MemRead_p; wire IF_ID_MemWrite_p; wire IF_ID_RegWrite_p; wire IF_ID_MemtoReg_p; 
wire IF_ID_BranchEq_p;wire IF_ID_BranchGt_p;
//ID_EX

wire [3:0] ID_EX_Instruction_p;
wire [4:0] ID_EX_rd_p; wire [4:0] ID_EX_rs2_p; wire [4:0] ID_EX_rs1_p;
wire [63:0] ID_EX_imm_data_p; wire [63:0] ID_EX_ReadData2_p; wire [63:0] ID_EX_ReadData1_p; wire [63:0] ID_EX_PC_Out_p;
wire ID_EX_ALUSrc_p; wire [1:0] ID_EX_ALUOp_p;
wire ID_EX_MemRead_p; wire ID_EX_MemWrite_p; wire ID_EX_RegWrite_p; wire ID_EX_MemtoReg_p;

wire ID_EX_BranchEq_p;wire ID_EX_BranchGt_p;wire ID_EX_Zero_p;wire ID_EX_Great_p;

wire [3:0] ID_EX_Operation_p;
wire [1:0] ID_EX_Forward_A_p; wire [1:0] ID_EX_Forward_B_p;
wire [63:0] ID_EX_Adder_Branch_p;
wire [63:0] ID_EX_MUX_to_Adder_p; wire [63:0] ID_EX_MUX_ForwardA_p; wire [63:0] ID_EX_MUX_ForwardB_p;
wire [63:0] ID_EX_ALU_Main_p;


//EX_MEM
wire [4:0] EX_MEM_rd_p;		
wire [63:0] EX_MEM_MUX_out_p;
wire [63:0] EX_MEM_ALU_Main_p;
wire [63:0] EX_MEM_Adder_Branch_p;
wire [63:0] EX_MEM_Read_Data_p;
wire [63:0] MUX_BranchG_p;

wire EX_MEM_MemRead_p; wire EX_MEM_MemWrite_p; wire EX_MEM_RegWrite_p; wire EX_MEM_MemtoReg_p;

wire EX_MEM_BranchEq_p;wire EX_MEM_BranchGt_p;wire EX_MEM_Zero_p;wire EX_MEM_Great_p;

//MEM_WB
wire [4:0] MEM_WB_rd_p;
wire [63:0] MEM_WB_ALU_Main_p; wire [63:0] MEM_WB_Read_Data_p;
wire MEM_WB_RegWrite_p; wire MEM_WB_MemtoReg_p;
wire [63:0] MEM_WB_MUX_out_p;


//Initalising modules

Program_Counter PC_p
(
	.clk(clk),
	.reset(reset),
	.PC_In(MUX_BranchG_p),
	.PC_Out(PC_Out_p)
);

Instruction_Memory Inst_Mem_p
(
	.Inst_Address(PC_Out_p),
	.Instruction(Instruction_p)
);

parser Inst_Par_p
(
	.instruction(IF_ID_Instruction_p),
	.opcode(IF_ID_opcode_p),
	.rd(IF_ID_rd_p),
	.funct3(funct3_p),
	.rs1(IF_ID_rs1_p),
	.rs2(IF_ID_rs2_p),
	.funct7(funct7_p)
);

registerFile registers_p
(
	.clk(clk),
	.reset(reset),
	.WriteData(MEM_WB_MUX_out_p),
	.rs1(IF_ID_rs1_p),
	.rs2(IF_ID_rs2_p),
	.rd(MEM_WB_rd_p),
	.RegWrite(MEM_WB_RegWrite_p),
	.ReadData1(IF_ID_ReadData1_p),
	.ReadData2(IF_ID_ReadData2_p)
);

extractor extract_p
(
	.instruction(IF_ID_Instruction_p),
	.imm_data(IF_ID_imm_data_p)
);

Control_Unit CU_p
(
	.funct3(funct3_p),
	.Opcode(IF_ID_opcode_p),
	.BranchEq(IF_ID_BranchEq_p),
	.BranchGt(IF_ID_BranchGt_p),
	.MemRead(IF_ID_MemRead_p),
	.MemtoReg(IF_ID_MemtoReg_p),
	.ALUOp(IF_ID_ALUOp_p),
	.MemWrite(IF_ID_MemWrite_p),
	.ALUSrc(IF_ID_ALUSrc_p),
	.RegWrite(IF_ID_RegWrite_p)
);

ALU_Control ALU_C_p
(
	.ALUOp(ID_EX_ALUOp_p),
	.Funct(ID_EX_Instruction_p),
	.Operation(ID_EX_Operation_p)
);

Data_Memory DM_p
(
	.clk(clk),
	.MemWrite(EX_MEM_MemWrite_p),
	.MemRead(EX_MEM_MemRead_p),
	.Mem_Addr(EX_MEM_ALU_Main_p),
	.Write_Data(EX_MEM_MUX_out_p),
	.Read_Data(EX_MEM_Read_Data_p)
);

Adder ALU_PC_4_p
(
	.a(PC_Out_p),
	.b(64'd4),
	.out(PC_4_Adder_p)
);

Adder ALU_Branch_p
(
	.a(ID_EX_PC_Out_p),
	.b(ID_EX_imm_data_p << 1),
	.out(ID_EX_Adder_Branch_p)
);

ALU_64_bit ALU_Main_p
(
	.a(ID_EX_MUX_ForwardA_p),
	.b(ID_EX_MUX_to_Adder_p),
	.AluOp(ID_EX_Operation_p),
	.Result(ID_EX_ALU_Main_p),
	.Zero(ID_EX_Zero_p),
	.Great(ID_EX_Great_p)
);

mux MUX_B_p
(
	.a(PC_4_Adder_p),
	.b(EX_MEM_Adder_Branch_p),
	.sel(EX_MEM_BranchEq_p & EX_MEM_Zero_p),
	.data_out(MUX_Branch_p)
);

mux MUX_BG_p
(
	.a(MUX_Branch_p),
	.b(EX_MEM_Adder_Branch_p),
	.sel(EX_MEM_BranchGt_p & EX_MEM_Great_p),
	.data_out(MUX_BranchG_p)
);

mux MUX_ID_EX_p
(
	.a(ID_EX_MUX_ForwardA_p),
	.b(ID_EX_imm_data_p),
	.sel(ID_EX_ALUSrc_p),
	.data_out(ID_EX_MUX_to_Adder_p)
);

mux MUX_MEM_WB_p
(
	.a(MEM_WB_ALU_Main_p),
	.b(MEM_WB_Read_Data_p),
	.sel(MEM_WB_MemtoReg_p),
	.data_out(MEM_WB_MUX_out_p)
);

mux_4_by_2 MUX_ForwardA_p
(
	.a(ID_EX_ReadData1_p),
	.b(MEM_WB_MUX_out_p),
	.c(EX_MEM_ALU_Main_p),
	.d(64'd0),
	.sel(ID_EX_Forward_A_p),
	.data_out(ID_EX_MUX_ForwardA_p)
);

mux_4_by_2 MUX_ForwardB_p
(
	.a(ID_EX_ReadData2_p),
	.b(MEM_WB_MUX_out_p),
	.c(EX_MEM_ALU_Main_p),
	.d(64'd0),
	.sel(ID_EX_Forward_B_p),
	.data_out(ID_EX_MUX_ForwardB_p)
);

Forwarding_Unit FU_p
(
	.ID_EX_rs1(ID_EX_rs1_p),
	.ID_EX_rs2(ID_EX_rs2_p),
	.EX_MEM_rd(EX_MEM_rd_p),
	.EX_MEM_RegWrite(EX_MEM_RegWrite_p),
	.MEM_WB_rd(MEM_WB_rd_p),
	.MEM_WB_RegWrite(MEM_WB_RegWrite_p),
	.Forward_A(ID_EX_Forward_A_p),
	.Forward_B(ID_EX_Forward_B_p)
);

//Initalising registers
IF_ID IF_ID_p
(
	.clk(clk),
	.reset(reset),
	.instruction(Instruction_p),
	.PC_Out(PC_Out_p),

	.IF_ID_instruction(IF_ID_Instruction_p),
	.IF_ID_PC_Out(IF_ID_PC_Out_p)
);
ID_EX ID_EX_p
(
	.clk(clk),
	.reset(reset),
	.IF_ID_instruction({IF_ID_Instruction_p[30], IF_ID_Instruction_p[14:12]}),
	.IF_ID_rd(IF_ID_rd_p), 
	.IF_ID_rs1(IF_ID_rs1_p),
	.IF_ID_rs2(IF_ID_rs2_p),
	.IF_ID_imm_data(IF_ID_imm_data_p),
	.IF_ID_ReadData2(IF_ID_ReadData2_p),
	.IF_ID_ReadData1(IF_ID_ReadData1_p),
	.IF_ID_PC_Out(IF_ID_PC_Out_p),
	.IF_ID_ALUSrc(IF_ID_ALUSrc_p),
	.IF_ID_ALUOp(IF_ID_ALUOp_p),

	.IF_ID_BranchEq(IF_ID_BranchEq_p),
	.IF_ID_BranchGt(IF_ID_BranchGt_p),

	.IF_ID_MemRead(IF_ID_MemRead_p),
	.IF_ID_MemWrite(IF_ID_MemWrite_p),
	.IF_ID_RegWrite(IF_ID_RegWrite_p),
	.IF_ID_MemtoReg(ID_EX_MemtoReg_p),

	.ID_EX_instruction(ID_EX_Instruction_p),
	.ID_EX_rd(ID_EX_rd_p),
	.ID_EX_rs2(ID_EX_rs2_p),
	.ID_EX_rs1(ID_EX_rs1_p),
	.ID_EX_imm_data(ID_EX_imm_data_p),
	.ID_EX_ReadData2(ID_EX_ReadData2_p),
	.ID_EX_ReadData1(ID_EX_ReadData1_p),
	.ID_EX_PC_Out(ID_EX_PC_Out_p),
	.ID_EX_ALUSrc(ID_EX_ALUSrc_p),
	.ID_EX_ALUOp(ID_EX_ALUOp_p),

	.ID_EX_BranchEq(ID_EX_BranchEq_p),
	.ID_EX_BranchGt(ID_EX_BranchGt_p),
	
	.ID_EX_MemRead(ID_EX_MemRead_p),
	.ID_EX_MemWrite(ID_EX_MemWrite_p),
	.ID_EX_RegWrite(ID_EX_RegWrite_p),
	.ID_EX_MemtoReg(ID_EX_MemtoReg_p)
);

EX_MEM EX_MEM_p
(
	.clk(clk),
	.reset(reset),
	.ID_EX_rd(ID_EX_rd_p),
	.ID_EX_MUX_FB(ID_EX_MUX_ForwardA_p),
	.ID_EX_ALU(ID_EX_ALU_Main_p),
	.ID_EX_Adder(ID_EX_Adder_Branch_p),
	.ID_EX_MemRead(ID_EX_MemRead_p),
	.ID_EX_MemWrite(ID_EX_MemWrite_p),
	.ID_EX_RegWrite(ID_EX_RegWrite_p),
	.ID_EX_MemtoReg(ID_EX_MemtoReg_p),

	.ID_EX_BranchGt(ID_EX_BranchEq_p),
	.ID_EX_BranchEq(ID_EX_BranchEq_p),
	.ID_EX_Zero(ID_EX_Zero_p),
	.ID_EX_Great(ID_EX_Great_p),

	.EX_MEM_Rd(EX_MEM_rd_p),
	.EX_MEM_MUX_FB(EX_MEM_MUX_out_p),
	.EX_MEM_ALU(EX_MEM_ALU_Main_p),

	.EX_MEM_BranchEq(EX_MEM_BranchEq_p),
	.EX_MEM_BranchGt(EX_MEM_BranchGt_p),
	.EX_MEM_Zero(EX_MEM_Zero_p),
	.EX_MEM_Great(EX_MEM_Great_p),

	.EX_MEM_Adder(EX_MEM_Adder_Branch_p),
	.EX_MEM_MemRead(EX_MEM_MemRead_p),
	.EX_MEM_MemWrite(EX_MEM_MemWrite_p),
	.EX_MEM_RegWrite(EX_MEM_RegWrite_p),
	.EX_MEM_MemtoReg(EX_MEM_MemtoReg_p)
);
	
MEM_WB MEM_WB_p
(
	.clk(clk),
	.reset(reset),
	.EX_MEM_rd(EX_MEM_rd_p),
	.EX_MEM_ALU(EX_MEM_ALU_Main_p),
	.EX_MEM_Read_Data(EX_MEM_Read_Data_p),
	.EX_MEM_RegWrite(EX_MEM_RegWrite_p),
	.EX_MEM_MemtoReg(EX_MEM_MemtoReg_p),
		
	.MEM_WB_rd(MEM_WB_rd_p),
	.MEM_WB_ALU(MEM_WB_ALU_Main_p),
	.MEM_WB_Read_Data(MEM_WB_Read_Data_p),
	.MEM_WB_RegWrite(MEM_WB_RegWrite_p),
	.MEM_WB_MemtoReg(MEM_WB_MemtoReg_p)
);

endmodule 