module IRT #(
    parameter regnum = 32,
    parameter bs = 16
) (
    input [$clog2(regnum)-1:0] rs1, rs2, rd,
    input [$clog2(bs)-1:0] buffer_index, 
    input clk, rst,
    output reg [bs-1:0] idt
);
	 
	 reg[$clog2(regnum+1)-1:0] i;

    // IRT has instruction in columns while registers as rows
    reg [0:bs-1] IRT_RS [0:regnum-1];
    reg [0:bs-1] IRT_RD [0:regnum-1];
	 
	 // clear_self_bit_mask is used to keep the irt_rd/s for the current bit as 0 (since obvio current function will depend on currently needed registers)
	 wire [bs-1:0] clear_self_bit_mask = ~({{(bs-1){1'b0}}, 1'b1} << buffer_index); // {{(bs-1){1'b0}}, 1'b1} is to ensure size matching, intention is 1<<buffer_index
    wire [bs-1:0] raw1 = IRT_RD[rs1] & clear_self_bit_mask;
    wire [bs-1:0] raw2 = IRT_RD[rs2] & clear_self_bit_mask;
    wire [bs-1:0] war  = IRT_RS[rd]  & clear_self_bit_mask;
    wire [bs-1:0] waw  = IRT_RD[rd]  & clear_self_bit_mask;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            // resetting everything to 1, results in assuming everything is dependent
            for(i=0; i<regnum; i=i+1) begin
                IRT_RS[i] = {bs{1'b1}};
                IRT_RD[i] = {bs{1'b1}};
            end
            idt = 0;
        end else begin
            // for every new instruction at column buffer_index, resetting the previous values stored
            for (i=0; i<regnum; i=i+1) begin
                IRT_RS[i][buffer_index] = 0;
                IRT_RD[i][buffer_index] = 0;
            end

            // setting the register dependencies to 1
            IRT_RS[rs1][buffer_index] = 1'b1;
            IRT_RS[rs2][buffer_index] = 1'b1;
            IRT_RD[rd][buffer_index]  = 1'b1;

            idt = raw1 | raw2 | war | waw;
        end
    end

    
endmodule