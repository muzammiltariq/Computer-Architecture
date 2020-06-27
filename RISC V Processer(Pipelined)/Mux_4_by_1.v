module mux_4_by_2(
	input [63:0]a, b, c, d,
	input [1:0]sel,
	output [63:0]data_out
);
reg [63:0]new;
always@* begin
    if (sel == 00)
	    new = a;
    else if (sel == 01)
	    new = b;
    else if (sel == 10)
	    new = c;
    else if (sel == 11)
	    new = d;
end
assign data_out = new;
endmodule 