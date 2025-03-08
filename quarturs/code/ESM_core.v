module ESM_core #(
    parameter Instr_word_size = 32,
    parameter regnum = 32,
    parameter bs = 16
) (
    input [Instr_word_size-1:0] Instr_in,
    input ALUSrc, RegWrite, clk, rst, start,
    output [$clog2(bs)-1:0] buffer_index 
);  

    localparam bs_bits = $clog2(bs);

    wire [bs-1:0] ready_positions;
    ESM_core_IDA #(Instr_word_size, regnum, bs) IDA_core(Instr_in, ALUSrc, RegWrite, clk, rst, buffer_index, ready_positions);

    ESM_core_IIM #(bs) IIM_core(ready_positions, clk, rst, start, buffer_index);
    
endmodule