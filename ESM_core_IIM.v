`include "mapping_table.v"
`include "candidate_list.v"

module ESM_core_IIM #(
    parameter bs = 16
) (
    input [bs_bits-1:0] ready_index,
    input clk, rst,
    output [bs_bits-1: 0] buffer_index
);
    localparam bs_bits = $clog2(bs);
    
    wire [bs-1:0] cand_list;
    candidate_list #(bs) c_list (clk, rst, ready_index, cand_list);

    mapping_table #(bs) m_table (clk, rst, cand_list, buffer_index);


    
endmodule