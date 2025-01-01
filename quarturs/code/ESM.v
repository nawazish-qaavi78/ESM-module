module ESM #(
    parameter Instr_word_size = 32,
    parameter regnum = 32,
    parameter bs = 16
) (
    input [Instr_word_size-1:0] Instr_in,
    input ALUSrc, RegWrite, clk, rst,
    output [Instr_word_size-1:0] Instr_out
);
    localparam bs_bits = $clog2(bs);

    wire [bs_bits-1:0] buffer_index;
	 wire start;

    Instr_Buffer #(Instr_word_size, bs) buffer (clk, rst, buffer_index, Instr_in, Instr_out, start);

    ESM_core #(Instr_word_size, regnum, bs) core (Instr_in, ALUSrc, RegWrite, clk, rst, start, buffer_index);

endmodule