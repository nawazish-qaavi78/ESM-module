// the purpose of the mapping_table is to serially arrange the ready indices, ie., indices of the candidate list
module mapping_table #(
    parameter bs = 16
) (
    input clk, rst, start,
    input [bs-1:0] cand_list,
	 input [31:0] rand_num,
    output reg [$clog2(bs)-1: 0] buffer_index = {$clog2(bs){1'b1}}
);

    localparam bs_bits = $clog2(bs);
	 
	 integer i;

    reg [bs_bits-1:0] map_table [0:bs-1];
    reg [bs_bits-1: 0] count = 0;
	 
	 wire [bs_bits-1: 0] map_ready_index;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            for(i=0; i<bs; i=i+1) begin
                map_table[i] = 0;
					 buffer_index = 0;
					 count = 0;
				end
        end else begin
					count = 0;
					for(i=0; i<bs; i=i+1)
                if(cand_list[i]) begin
                    map_table[count] = i; 
                    count = count+1;
                end
					if(count && start) buffer_index = map_table[map_ready_index]; // when buffer is full, and shuffling can start
					else buffer_index = buffer_index + 1; // this is for the time when buffer is still not full
		  end
            
    end


	 
    assign map_ready_index = (count!=0) ? (rand_num[bs_bits-1:0] % count): 0;
    
endmodule