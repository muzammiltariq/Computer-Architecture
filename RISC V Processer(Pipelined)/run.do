vlog Adder.v ALU_64_bit.v ALU_Control.v Control_Unit.v Data_Memory.v EX_MEM.v Forwarding_Unit.v ID_EX.v IF_ID.v ImmGen.v InsParser.v Instruction_Memory.v MEM_WB.v Mux.v Mux_4_by_1.v Program_Counter.v registerfile.v Processer.v tb.v

vsim -novopt work.tb

view wave

add wave -r sim:/tb/Process/*
add wave \
{sim:/tb/Process/registers_p/registers } 
run 2000ns