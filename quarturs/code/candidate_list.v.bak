module candidate_list #(
    parameter bs =16
) (
    input clk, rst,
    input [bs_bits-1:0]ready_index,
    output reg [bs-1:0] candidate_list = 0
);
    localparam bs_bits = $clog2(bs);

    always @(posedge clk, posedge rst) begin
        if(rst) candidate_list = 0;
        else candidate_list[ready_index] = 1;
    end

endmodule