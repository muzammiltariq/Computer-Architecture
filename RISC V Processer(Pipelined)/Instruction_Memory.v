module Instruction_Memory
(
	input [63:0]Inst_Address,
	output reg [31:0]Instruction
);

reg [7:0]registers[75:0];

initial 
begin
	registers[75] = 8'b11111100;
registers[74] = 8'b00000000;
registers[73] = 8'b00000000;
registers[72] = 8'b11100011;


//11111100 00000000 00000000 11100011
registers[71] = 8'b00000000;
registers[70] = 8'b10000101;
registers[69] = 8'b00000101;
registers[68] = 8'b00010011;

registers[67] = 8'b00000000;
registers[66] = 8'b00010010;
registers[65] = 8'b10000010;
registers[64] = 8'b10010011;

registers[63] = 8'b11111110;
registers[62] = 8'b00000000;
registers[61] = 8'b00000110;
registers[60] = 8'b11100011;
  

registers[59] = 8'b00000001;
registers[58] = 8'b11010110;
registers[57] = 8'b00110000;
registers[56] = 8'b00100011;
registers[55] = 8'b00000001;
registers[54] = 8'b11000101;
registers[53] = 8'b00110000;
registers[52] = 8'b00100011;
registers[51] = 8'b11111110;
registers[50] = 8'b00000000;
registers[49] = 8'b00000100;
registers[48] = 8'b11100011;
registers[47] = 8'b00000000;
registers[46] = 8'b10000110;
registers[45] = 8'b00000110;
registers[44] = 8'b00010011;
registers[43] = 8'b00000000; 
registers[42] = 8'b00010011;
registers[41] = 8'b10000011;
registers[40] = 8'b10010011;

registers[39] = 8'b00000001;
registers[38] = 8'b11001110;
registers[37] = 8'b11001000;
registers[36] = 8'b01100011;

registers[35] = 8'b00000000;
registers[34] = 8'b00000101;
registers[33] = 8'b00111110;
registers[32] = 8'b10000011;
registers[31] = 8'b00000000;
registers[30] = 8'b00000110;
registers[29] = 8'b00111110;
registers[28] = 8'b00000011;
registers[27] = 8'b00000010;
registers[26] = 8'b10110011;
registers[25] = 8'b10000100;
registers[24] = 8'b01100011;
registers[23] = 8'b00000000;
registers[22] = 8'b00000000;
registers[21] = 8'b00000010;
registers[20] = 8'b01100011;

registers[19] = 8'b00000001;
registers[18] = 8'b01000000;
registers[17] = 8'b00000110;
registers[16] = 8'b00010011;

 

registers[15] = 8'b00000000;
registers[14] = 8'b00000000;
registers[13] = 8'b00000011;
registers[12] = 8'b10110011;


registers[11] = 8'b00000100;
registers[10] = 8'b10110010;
registers[9] = 8'b10000010;
registers[8] = 8'b01100011;



registers[7] = 8'b00000001;
registers[6] = 8'b01000000;
registers[5] = 8'b00000101;
registers[4] = 8'b00010011;
 


registers[3] = 8'b00000000;
registers[2] = 8'b00110000;
registers[1] = 8'b00000101;
registers[0] = 8'b10010011;


end 

always@(*)
Instruction = {registers[Inst_Address+3],registers[Inst_Address+2],registers[Inst_Address+1],registers[Inst_Address]};

endmodule 