`include "PRNG.v"
module ESM_core_IIM #(
    parameter bs = 16
) (
    input [$clog2(bs)-1:0] issue_index,
    input clk,
    output [$clog2(bs)-1: 0]random_index
);
    reg [bs-1:0] candidate_list = 0;
    reg [$clog2(bs)-1:0] mapping_table [0:bs-1];
    reg [$clog2(bs)-1: 0] count = 0;
    
    always @(*) begin
        candidate_list[issue_index] = 1;
    end

    always@(candidate_list) begin
        for(integer i =0; i<bs; i=i+1) begin
            if(candidate_list[i]) mapping_table[count++] = i;
        end
    end

    wire [31:0] rand_num;
    PRNG random_num(clk, 1'b1, 1'b0, rand_num);

    assign random_index = rand_num % count;
    
endmodule