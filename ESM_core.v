`include "ESM_core_IDA.v"
`include "ESM_core_IIM.v"
module ESM_core #(
    parameter Instr_word_size = 32,
    parameter regnum = 32,
    parameter bs = 16
) (
    input [Instr_word_size-1:0] Instr_in,
    input ALUSrc, RegWrite, clk,
    output reg [$clog2(bs)-1:0]buffer_index 
);  
    wire [$clog2(bs)-1:0] issue_index;
    ESM_core_IDA #(Instr_word_size, regnum, bs) IDA_core(Instr_in, ALUSrc, RegWrite, clk, buffer_index, issue_index);

    wire [$clog2(bs)-1: 0] random_index;
    ESM_core_IIM #(bs) IIM_core(issue_index, clk, random_index);
    
endmodule