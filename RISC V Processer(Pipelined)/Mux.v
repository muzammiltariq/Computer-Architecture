module mux(
	input [63:0]a, [63:0]b,
	input sel,
	output [63:0]data_out
);
reg [63:0]new;
always@* begin
if (sel == 0)
	new = a;
else if (sel ==1)
	new = b;
end
assign data_out = new;
endmodule 