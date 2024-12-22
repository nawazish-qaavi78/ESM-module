`include "PRNG.v"
module mapping_table #(
    parameter bs = 16
) (
    input clk, rst,
    input [bs-1:0] cand_list,
    output reg [bs_bits-1: 0] buffer_index
);

    localparam bs_bits = $clog2(bs);

    reg [bs_bits-1:0] map_table [0:bs-1];
    reg [bs_bits-1: 0] count = 0;

    always @(posedge clk, posedge rst) begin
        if(rst) 
            for(integer i=0; i<bs; i=i+1)
                map_table[i] = 0;
        else 
            for(integer i=0; i<bs; i=i+1)
                if(cand_list[i]) begin
                    map_table[count] <= i;
                    count <= count+1;
                end

    end

    always @(posedge clk, posedge rst) begin
        if(rst) buffer_index = 0;
        else buffer_index = map_table[map_ready_index];
    end
    
    wire [31:0] rand_num;
    PRNG random_num(clk, 1'b1, rst, rand_num);

    wire [bs_bits-1: 0] map_ready_index;
    assign map_ready_index = rand_num % count;
    
endmodule