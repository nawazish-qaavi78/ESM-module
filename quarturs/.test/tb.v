`include "code\ESM.v"

module tb;

    parameter instr_delay = 10;

    reg clk, rst, RegWrite, ALUSrc;
    reg  [31:0] Instr_in;
    wire [31:0] Instr_out;

    ESM uut(Instr_in, ALUSrc, RegWrite, clk, rst, Instr_out);

    initial begin
        $display("Working in this testbench!! yohoo");
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        #2;
        #instr_delay Instr_in = 32'b00000000000100000000000010010011;
        #instr_delay Instr_in = 32'b00000000000000000000000100010011;
        #instr_delay Instr_in = 32'b00000000001100010000000110110011;
        #instr_delay Instr_in = 32'b11111111111100001000000010010011;
        #instr_delay Instr_in = 32'b0000000_00001_00100_010_00000_1010011;
        #instr_delay Instr_in = 32'b000000000010_00000_000_00111_0010011;
        #instr_delay Instr_in = 32'b000000000101_00000_000_01000_0010011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_000_01001_0110011;
        #instr_delay Instr_in = 32'b0100000_00111_01000_000_01010_0110011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_100_01011_0110011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_111_01100_0110011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_110_01101_0110011;
        #instr_delay Instr_in = 32'b000000000010_00000_000_00111_0010011;
        #instr_delay Instr_in = 32'b000000000101_00000_000_01000_0010011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_000_01001_0110011;
        #instr_delay Instr_in = 32'b0100000_00111_01000_000_01010_0110011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_100_01011_0110011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_111_01100_0110011;
        #instr_delay Instr_in = 32'b0000000_01000_00111_110_01101_0110011;
        #instr_delay Instr_in = 32'b0000000_00001_00111_001_01110_0110011;
        #instr_delay Instr_in = 32'b0000000_00001_01000_101_01111_0110011;
        #instr_delay Instr_in = 32'b0000000_00111_00110_000_10000_0110011;
        #instr_delay Instr_in = 32'b0100000_01001_10000_000_10001_0110011;
    end
    
endmodule