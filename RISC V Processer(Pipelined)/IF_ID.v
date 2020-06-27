module IF_ID (
    input clk, reset,
	input [31:0] instruction,
	input [63:0] PC_Out,
	output reg [31:0] IF_ID_instruction,
	output reg [63:0] IF_ID_PC_Out

);

always@(posedge clk or reset)
begin
    if(reset)
        begin
            IF_ID_instruction = 0;
            IF_ID_PC_Out = 0;
        end 
    else if(clk)
        begin
            IF_ID_instruction = instruction;
            IF_ID_PC_Out = PC_Out;
        end
end
endmodule 