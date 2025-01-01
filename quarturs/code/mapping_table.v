module mapping_table #(
    parameter bs = 16
) (
    input clk, rst,
    input [bs-1:0] cand_list,
    output reg [$clog2(bs)-1: 0] buffer_index
);

    localparam bs_bits = $clog2(bs);
	 
	 integer i;

    reg [bs_bits-1:0] map_table [0:bs-1];
    reg [bs_bits-1: 0] count = 0;
	 
	 wire [bs_bits-1: 0] map_ready_index;
	 wire [31:0] rand_num;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
				count <= 0;
            for(i=0; i<bs; i=i+1)
                map_table[i] <= 0;
        end else 
            for(i=0; i<bs; i=i+1)
                if(cand_list[i]) begin
                    map_table[count] <= i;
                    count <= count+1;
                end
    end

    always @(posedge clk, posedge rst) begin
        if(rst) buffer_index = 0;
        else buffer_index = map_table[map_ready_index];
    end

 
    PRNG random_num(clk, 1'b1, rst, rand_num);

    
    assign map_ready_index = (count!=0) ? (rand_num % count) : 0;
    
endmodule