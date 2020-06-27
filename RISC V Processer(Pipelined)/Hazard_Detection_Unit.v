module hazard_detection_unit(
    input ID_EX_MemRead,
    input [4:0] ID_EX_rd,
    input [4:0] IF_ID_rs1, IF_ID_rs2,
    output control_mux,
    output [1:0] PC_control_mux,
    output IF_ID_write,


);
always@(*)
begin
    if (ID_EX_MemRead == 1 and (ID_EX_rd = IF_ID_rs1 or ID_EX_rd = IF_ID_rs2))
        begin
            control_mux = 0;
            PC_control_mux = 00;
            IF_ID_write = 0;
        end

end
endmodule