module Data_Memory
(
	input [63:0]Mem_Addr,Write_Data,
	input clk, MemWrite, MemRead,
	output reg [63:0]Read_Data
);

reg [7:0] registers[99:0];
initial 
begin
	registers[0] = 64'd0;
	registers[1] = 64'd0;
	registers[2] = 64'd2;
	registers[3] = 64'd3;
	registers[4] = 64'd4;
	registers[5] = 64'd5;
	registers[6] = 64'd6;
	registers[7] = 64'd7;
	registers[8] = 64'd8;
	registers[9] = 64'd9;
	registers[10] = 64'd10;
	registers[11] = 64'd11;
	registers[12] = 64'd12;
	registers[13] = 64'd13;
	registers[14] = 64'd14;
	registers[15] = 64'd15;
	registers[16] = 64'd16;
	registers[17] = 64'd17;
	registers[18] = 64'd18;
	registers[19] = 64'd19;

	registers[20] = 64'd9; 
	registers[21] = 64'd0;
	registers[22] = 64'd0;
	registers[23] = 64'd0;
	registers[24] = 64'd0;
	registers[25] = 64'd0;
	registers[26] = 64'd0;
	registers[27] = 64'd0;

	registers[28] = 64'd8;
	registers[29] = 64'd0;
	registers[30] = 64'd0;
	registers[31] = 64'd0;
	registers[32] = 64'd0;
	registers[33] = 64'd0;
	registers[34] = 64'd0;
	registers[35] = 64'd0;

	registers[36] = 64'd7;
	registers[37] = 64'd0;
	registers[38] = 64'd0;
	registers[39] = 64'd0;
    registers[40] = 64'd0;
	registers[41] = 64'd0;
	registers[42] = 64'd0;
	registers[43] = 64'd0;

	registers[44] = 64'd6;
	registers[45] = 64'd0;
	registers[46] = 64'd0;
	registers[47] = 64'd0;
	registers[48] = 64'd0;
	registers[49] = 64'd0;
	registers[50] = 64'd0;
	registers[51] = 64'd0;

	registers[52] = 64'd5;
    registers[53] = 64'd0;
	registers[54] = 64'd0;
	registers[55] = 64'd0;
	registers[56] = 64'd0;
	registers[57] = 64'd0;
	registers[58] = 64'd0;
	registers[59] = 64'd0;

	registers[60] = 64'd4;
	registers[61] = 64'd0;
	registers[62] = 64'd0;
	registers[63] = 64'd0;
	registers[64] = 64'd0;
	registers[65] = 64'd0;
	registers[66] = 64'd0;
	registers[67] = 64'd0;

	registers[68] = 64'd3;
	registers[69] = 64'd0;
	registers[70] = 64'd0;
	registers[71] = 64'd0;
	registers[72] = 64'd0;
	registers[73] = 64'd0;
	registers[74] = 64'd0;
	registers[75] = 64'd0;


	registers[76] = 64'd2;
	registers[77] = 64'd0;
	registers[78] = 64'd0;
	registers[79] = 64'd0;
	registers[80] = 64'd0;
	registers[81] = 64'd0;
	registers[82] = 64'd0;
	registers[83] = 64'd0;

	registers[84] = 64'd1;
	registers[85] = 64'd0;
	registers[86] = 64'd0;
	registers[87] = 64'd0;
	registers[88] = 64'd0;
	registers[89] = 64'd0;
	registers[90] = 64'd0;
	registers[91] = 64'd0;


	registers[92] = 64'd0;
	registers[93] = 64'd0;
	registers[94] = 64'd0;
	registers[95] = 64'd0;
	registers[96] = 64'd0;
	registers[97] = 64'd0;
	registers[98] = 64'd0;
	registers[109] = 64'd0;
	
end 

always@(posedge clk)
begin
	if (MemWrite == 1)
		registers[Mem_Addr] = Write_Data[7:0];
		registers[Mem_Addr+1] = Write_Data[15:8];
		registers[Mem_Addr+2] = Write_Data[23:16];
		registers[Mem_Addr+3] = Write_Data[31:24];
		registers[Mem_Addr+4] = Write_Data[39:32];
		registers[Mem_Addr+5] = Write_Data[47:40];
		registers[Mem_Addr+6] = Write_Data[55:48];
		registers[Mem_Addr+7] = Write_Data[63:56];
end
always@(*)
begin
	if (MemRead == 1)
		Read_Data = {registers[Mem_Addr+7],registers[Mem_Addr+6],registers[Mem_Addr+5],registers[Mem_Addr+4],registers[Mem_Addr+3],registers[Mem_Addr+2],registers[Mem_Addr+1],registers[Mem_Addr]};
end 		
endmodule 