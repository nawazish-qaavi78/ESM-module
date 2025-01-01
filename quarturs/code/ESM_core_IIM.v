module ESM_core_IIM #(
    parameter bs = 16
) (
    input [$clog2(bs)-1:0] ready_index,
    input clk, rst,
    output [$clog2(bs)-1: 0] buffer_index
);
    
    wire [bs-1:0] cand_list;
    candidate_list #(bs) c_list (clk, rst, ready_index, cand_list);

    mapping_table #(bs) m_table (clk, rst, cand_list, buffer_index);


    
endmodule