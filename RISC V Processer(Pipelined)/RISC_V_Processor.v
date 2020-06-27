module RISC_V_Processor (
    input clk,reset
); 

wire [63:0] PC_In; wire [63:0] PC_Out; wire [63:0] out1; wire [63:0] out2;
wire [31:0]Instruction1;
wire [6:0] opcode; wire [4:0] rd;  wire [4:0]rs1; wire [4:0]rs2; wire [2:0]funct3; wire [6:0]funct7;
wire Branch; wire MemRead; wire MemtoReg; wire MemWrite; wire ALUSrc; wire Regwrite; wire [1:0]ALUOp;
wire Zero; wire [63:0]Result; wire [3:0]operation; wire [63:0]Write_Data;
wire [63:0] Read_Data; wire [63:0] Read_Data1; wire [63:0] Read_Data2; wire [63:0]imm_data; wire [63:0] data_out; wire [63:0] data_out2;

Adder a1
(
	.a(PC_Out),
	.b(64'd4),
	.out(out1)
);
Adder a2
(
	.a(PC_Out),
	.b(imm_data<<1),
	.out(out2)
);
Program_Counter pc
(
	.PC_In(PC_In),
	.PC_Out(PC_Out),
	.clk(clk),
	.reset(reset)	
);
Instruction_Memory im
(
    .Inst_Address(PC_Out),
	.Instruction(Instruction1)
);
parser p 
(
	.instruction(Instruction1),
	.opcode(opcode),
	.funct7(funct7),
	.rd(rd),
	.rs1(rs1),
	.rs2(rs2),
	.funct3(funct3)
);
registerFile rf
(
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd),
	.WriteData(data_out2),
	.clk(clk),
	.reset(reset),
	.RegWrite(WriteData),
	.ReadData1(Read_Data1),
	.ReadData2(Read_Data2)
);
Data_Memory dm
(
	.Mem_Addr(Result),
	.Write_Data(Read_Data2),
	.clk(clk),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.Read_Data(Read_Data)
);
Control_Unit cu
(
	.Opcode(opcode),
	.ALUOp(ALUOp),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(Regwrite)
);
extractor e
(
	.instruction(Instruction1),
	.imm_data(imm_data)
);
ALU_64_bit ab
(
	.a(Read_Data1),
	.b(data_out),
	.AluOp(operation),
	.Result(Result),
	.Zero(Zero)
);
ALU_Control ac
(
	.ALUOp(ALUOp),
	.Funct({Instruction1[30],Instruction1[14:12]}),
	.Operation(operation)
);
mux m1 
(
    .a(out1),
	.b(out2),
	.sel(Branch & Zero),
	.data_out(PC_In)
);
mux m2 
(
    .a(Result),
	.b(Read_Data),
	.sel(MemtoReg),
	.data_out(Write_Data)
);
mux m3 
(
    .a(Read_Data2),
	.b(imm_data),
	.sel(ALUSrc),
	.data_out(data_out)
);

endmodule