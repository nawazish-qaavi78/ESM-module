//the purpose of candidate list is storing flagging the indices which are ready
module candidate_list #(
    parameter bs =16
) (
    input clk, rst,
    input [bs-1:0]ready_index,
    output reg [bs-1:0] candidate_list = 0
);

    always @(posedge clk, posedge rst) begin
        if(rst) candidate_list = 0;
        else candidate_list = ready_index;
    end

endmodule