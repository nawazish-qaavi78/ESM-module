`include "ESM_core.v"

module ESM #(
    parameter Instr_word_size = 32,
    parameter regnum = 32,
    parameter bs = 16
) (
    input [Instr_word_size-1:0] Instr_in,
    input ALUSrc, RegWrite, clk,
    output reg [Instr_word_size-1:0] Instr_out
);

    reg [Instr_word_size-1:0] Instr_Buffer [0:bs-1];

    initial begin
        for(integer i=0; i<bs; i=i+1) 
            Instr_Buffer[i] = 0;
    end
    
    wire [$clog2(bs)-1:0] buffer_index;
    ESM_core #(Instr_word_size, regnum, bs) core (Instr_in, ALUSrc, RegWrite, clk, buffer_index);

    always @(posedge clk) begin
        Instr_out <= Instr_Buffer[buffer_index];
        Instr_Buffer[buffer_index] <= Instr_in;
    end

endmodule