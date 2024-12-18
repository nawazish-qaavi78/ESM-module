module IRT #(
    parameter regnum = 32,
    parameter bs = 16
) (
    input [$clog2(regnum)-1:0] rs1, rs2, rd,
    input [$clog2(bs)-1:0] buffer_index, 
    input clk,
    output reg [bs-1:0] idt
);
    // IRT has instruction in columns while registers as rows
    reg [0:bs-1] IRT_RS [0:regnum-1];
    reg [0:bs-1] IRT_RD [0:regnum-1];

    always @(posedge clk) begin
        // for every new instruction at column buffer_index, resetting the previous values stored
        for (integer i=0; i<regnum; i=i+1) begin
            IRT_RS[buffer_index][i] = 0;
            IRT_RD[buffer_index][i] = 0;
        end

        // setting the register dependencies to 1
        IRT_RS[rs1][buffer_index] = 1;
        IRT_RS[rs2][buffer_index] = 1;
        IRT_RD[rd][buffer_index]  = 1;

        idt = raw1 | raw2 | war | waw;

    end

    wire [bs-1:0] clear_self_bit_mask = (~(1<<buffer_index));
    wire [bs-1:0] raw1 = IRT_RD[rs1] & clear_self_bit_mask;
    wire [bs-1:0] raw2 = IRT_RD[rs2] & clear_self_bit_mask;
    wire [bs-1:0] war  = IRT_RS[rd]  & clear_self_bit_mask;
    wire [bs-1:0] waw  = IRT_RD[rd]  & clear_self_bit_mask;
endmodule