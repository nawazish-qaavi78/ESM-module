module IDT #(
    parameter bs = 16
) (
    input clk, rst,
    input [bs_bits-1:0] buffer_index,
    input [bs-1:0] current_idt,
    output reg [bs_bits-1:0] ready_index
);

    localparam bs_bits = $clog2(bs);
	 
	 integer i,j;

    reg [bs-1: 0] IDT_table [bs-1:0]; // imp note idt is not like irt, it has current instruction in row and dependencies in column

    always @(posedge clk, posedge rst) begin
	  j=0;
     if(rst) begin
            for(j = 0; j<bs; j=j+1) begin
                IDT_table[j] = {bs{1'b1}};
            end
    end else 
        IDT_table[buffer_index] = current_idt;
    end

    always @(posedge clk) begin
        ready_index = 0;
        for(i=0; i<bs; i=i+1) begin
            if(IDT_table[i] == 0) ready_index = i;
        end
    end

endmodule