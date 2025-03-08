//the purpose of candidate list is storing flagging the indices which are ready
module candidate_list #(
    parameter bs =16
) (
    input clk, rst,
    input [bs-1:0]ready_positions,
    output reg [bs-1:0] candidate_list = 0
);

    always @(posedge clk, posedge rst) begin
        if(rst) candidate_list = 0;
        else candidate_list = ready_positions;
    end

endmodule