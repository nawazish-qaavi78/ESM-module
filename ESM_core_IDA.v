`include "IRT.v"
module ESM_core_IDA #(
    parameter Instr_word_size = 32,
    parameter regnum = 32,
    parameter bs = 16
) (
    input [Instr_word_size-1:0] Instr_in,
    input ALUSrc, RegWrite,
    input  [$clog2(bs)-1:0] buffer_index,
    output [Instr_word_size-1:0] Instr_to_be_issuded
);
    localparam reg_addr_bits = $clog2(regnum);

    wire [reg_addr_bits-1:0] rs1 =  Instr_in[19:15];
    wire [reg_addr_bits-1:0] rs2 =  ALUSrc ? Instr_in[24:20] : 0;
    wire [reg_addr_bits-1:0] rd  = RegWrite ? Instr_in[11:7] : 0;

    IRT irt (rs1, rs2, rd, buffer_index);

    reg [bs-1: 0] IDT [bs-1:0];

    always @(*) begin
        IDT[buffer_index] = 0;
    end

endmodule