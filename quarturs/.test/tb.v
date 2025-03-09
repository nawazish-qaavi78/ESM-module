`timescale 1 ns/1 ns

module tb;

    parameter instr_delay = 10;

    reg clk, rst, RegWrite, ALUSrc;
    reg  [31:0] Instr_in;
    wire [31:0] Instr_out;

    localparam i1 = 32'b00000000000100000000000010010011; // lw x1, 1
    localparam i2 = 32'b00000000000000000000000100010011; // li x2, 0
    localparam i3 = 32'b00000000001100010000000110110011; // add x2, x2, x3
    localparam i4 = 32'b11111111111100001000000010010011; // addi x1, x1, -1
    localparam i5 = 32'b0000000_00001_00100_010_00000_1010011; // st x4, x1
    localparam i6 = 32'b000000000010_00000_000_00111_0010011; // li x7, 10
    localparam i7 = 32'b000000000101_00000_000_01000_0010011; // li x8, 20
    localparam i8 = 32'b0000000_01000_00111_000_01001_0110011; // add x9, x7, x8
    localparam i9 = 32'b0100000_00111_01000_000_01010_0110011; // sub x10, x8, x7
    localparam i10 = 32'b0000000_01000_00111_100_01011_0110011; // xor x11, x7, x8
    localparam i11 = 32'b0000000_01000_00111_111_01100_0110011; // and x12, x7, x8
    localparam i12 = 32'b0000000_01000_00111_110_01101_0110011; // or x13, x7, x8
    localparam i20 = 32'b0000000_00001_00111_001_01110_0110011; // sll t14, t7, t1
    localparam i21 = 32'b0000000_00001_01000_101_01111_0110011; // srl t15, t8, t1
    localparam i22 = 32'b0000000_00111_00110_000_10000_0110011; // add t16, t6, t7
    localparam i23 = 32'b0100000_01001_10000_000_10001_0110011; // sub t17, t16, t9

    ESM uut(Instr_in, ALUSrc, RegWrite, clk, rst, Instr_out);

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #2 rst = 1'b1;
        #5 rst = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        #instr_delay Instr_in = i1; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i2; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i3; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i4; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i5; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = i6; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i7; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i8; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i9; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i10; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i11; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i12; RegWrite = 1 ; ALUSrc = 0;
        
        #instr_delay Instr_in = i20; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i21; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i22; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i23; RegWrite = 1 ; ALUSrc = 0;
        
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;

        #instr_delay Instr_in = i6; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i7; RegWrite = 1 ; ALUSrc = 1;
        #instr_delay Instr_in = i8; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i9; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i10; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i11; RegWrite = 1 ; ALUSrc = 0;
        #instr_delay Instr_in = i12; RegWrite = 1 ; ALUSrc = 0;
        
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #instr_delay Instr_in = 0; RegWrite = 0 ; ALUSrc = 0;
        #400 $stop;
    end
    
always @(negedge clk ) begin
    case(Instr_out)
        i1:  $display("i1 is executed");
        i2:  $display("i2 is executed");
        i3:  $display("i3 is executed");
        i4:  $display("i4 is executed");
        i5:  $display("i5 is executed");
        i6:  $display("i6 is executed");
        i7:  $display("i7 is executed");
        i8:  $display("i8 is executed");
        i9:  $display("i9 is executed");
        i10: $display("i10 is executed");
        i11: $display("i11 is executed");
        i12: $display("i12 is executed");
        i20: $display("i20 is executed");
        i21: $display("i21 is executed");
        i22: $display("i22 is executed");
        i23: $display("i23 is executed");
        0: $display("No function");
    endcase
end

endmodule