module IRT #(
    parameter regnum = 32,
    parameter bs = 16
) (
    input [$clog2(regnum)-1:0] rs1, rs2, rd,
    input [$clog2(bs)-1:0] buffer_index
);
    reg [regnum-1:0] IRT_RS [0:bs-1];
    reg [regnum-1:0] IRT_RD [0:bs-1];

    always @(rs1, rs2, rd) begin
        IRT_RS[buffer_index] = 0;
        IRT_RD[buffer_index] = 0;
        IRT_RS[buffer_index][rs1] = 1;
        IRT_RS[buffer_index][rs2] = 1;
        IRT_RD[buffer_index][rd]  = 1;
    end
endmodule