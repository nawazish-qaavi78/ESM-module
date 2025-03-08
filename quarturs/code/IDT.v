module IDT #(
    parameter bs = 16
) (
    input clk, rst,
    input [$clog2(bs)-1:0] buffer_index,
    input [bs-1:0] current_idt,
    output reg [bs-1:0] ready_positions
);
	 
	 integer i;

    reg [bs-1: 0] IDT_table [bs-1:0]; // imp note idt is not like irt, it has current instruction in row and dependencies in column

    always @(posedge clk, posedge rst) begin
     if(rst) begin
            for(i = 0; i<bs; i=i+1) begin
                IDT_table[i] = {bs{1'b1}};
            end
    end else 
        IDT_table[buffer_index] = current_idt;
    end

	 // later replace this with generate block 
    always @(*) begin
        for(i=0; i<bs; i=i+1) begin
            ready_positions[i] = (IDT_table[i] == 0); // if a instruction has no dependencies then only IDT_table[i] = 0
        end
    end

endmodule