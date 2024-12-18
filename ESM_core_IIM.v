`include "PRNG.v"
module ESM_core_IIM #(
    parameter bs = 16
) (
    input [$clog2(bs)-1:0] ready_index,
    input clk, rst,
    output reg [$clog2(bs)-1: 0] buffer_index
);
    reg [bs-1:0] candidate_list = 0;
    reg [$clog2(bs)-1:0] mapping_table [0:bs-1];
    reg [$clog2(bs)-1: 0] count = 0;
    
    always @(posedge clk, posedge rst) begin
        if(rst) candidate_list = 0;
        else candidate_list[ready_index] = 1;
    end

    always@(candidate_list, rst) begin
        for(integer i =0; i<bs; i=i+1) begin
            if(rst) mapping_table[i] = 0;
            else if(candidate_list[i]) mapping_table[count++] = i;
        end
    end

    always @(posedge clk, posedge clk) begin
        if(rst) buffer_index = 0;
        else buffer_index = mapping_table[map_ready_index];
    end

    wire [31:0] rand_num;
    PRNG random_num(clk, 1'b1, rst, rand_num);

    wire [$clog2(bs)-1: 0] map_ready_index;
    assign map_ready_index = rand_num % count;


    
endmodule