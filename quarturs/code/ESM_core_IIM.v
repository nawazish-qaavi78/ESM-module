module ESM_core_IIM #(
    parameter bs = 16
) (
    input [bs-1:0] ready_positions,
    input clk, rst, start,
    output [$clog2(bs)-1: 0] buffer_index
);
    
    wire [bs-1:0] cand_list;
	 wire [31:0] rand_num;
	 
    candidate_list #(bs) c_list (clk, rst, ready_positions, cand_list);

    mapping_table #(bs) m_table (clk, rst, start, cand_list, rand_num, buffer_index);

	 PRNG random_num(clk, 1'b1, rst, rand_num);
    
endmodule