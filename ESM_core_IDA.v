`include "IRT.v"

module ESM_core_IDA #(
    parameter Instr_word_size = 32,
    parameter regnum = 32,
    parameter bs = 16
) (
    input [Instr_word_size-1:0] Instr_in,
    input ALUSrc, RegWrite, clk, rst,
    input  [$clog2(bs)-1:0] buffer_index,
    output [$clog2(bs)-1:0] ready_index
);
    localparam reg_addr_bits = $clog2(regnum);

    wire [reg_addr_bits-1:0] rs1 =  Instr_in[19:15];
    wire [reg_addr_bits-1:0] rs2 =  ALUSrc ? Instr_in[24:20] : 0;
    wire [reg_addr_bits-1:0] rd  = RegWrite ? Instr_in[11:7] : 0;

    wire [bs-1:0] current_idt;
    IRT #(regnum, bs) irt (rs1, rs2, rd, buffer_index, clk, current_idt);
    
    reg [bs-1: 0] IDT [bs-1:0]; // imp note idt is not like irt, it has current instruction in row and dependencies in column

    always @(posedge clk or posedge rst) begin
        // initalizing idt with all 1's => we assume that all the instructions are dependent
        if(rst) begin
            for(integer i = 0; i<bs; i=i+1) begin
                IDT[i] = {bs{1'b1}};
            end
        end else 
            IDT[buffer_index] = current_idt;
    end



endmodule