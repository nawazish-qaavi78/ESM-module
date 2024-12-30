module Instr_Buffer #(
    parameter Instr_word_size = 32,
    parameter bs = 16
) (
    input clk, rst,
    input [bs_bits-1:0] buffer_index,
    input [Instr_word_size-1:0] Instr_in,
    output reg [Instr_word_size-1:0] Instr_out
);

    localparam bs_bits = $clog2(bs);

    reg [Instr_word_size-1:0] buffer [0:bs-1];

    initial begin
        for(integer i=0; i<bs; i=i+1) 
            buffer[i] = 0;
    end

    always @(posedge clk, posedge rst ) begin
        if(rst)
            for(integer i=0; i<bs; i=i+1)
                buffer[i] <= 0;
        else begin
            Instr_out <= buffer[buffer_index];
            buffer[buffer_index] <= Instr_in;
        end
    end

endmodule