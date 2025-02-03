module Instr_Buffer #(
    parameter Instr_word_size = 32,
    parameter bs = 16
) (
    input clk, rst,
    input [$clog2(bs)-1:0] buffer_index,
    input [Instr_word_size-1:0] Instr_in,
    output reg [Instr_word_size-1:0] Instr_out,
	 output start // tells when we can start sending the buffer index value based on mapping table, until then buffer_index will just increment
);
	 integer i,j;
	 
	 reg full; // imagine hte 1st instr in, it would considered independent, hence executed immediately... so we need to wait until buffer is full or instructions are completed
    reg [Instr_word_size-1:0] buffer [0:bs-1];

    initial begin
        for(i=0; i<bs; i=i+1) 
            buffer[i] = 0;
    end

    always @(posedge clk, posedge rst) begin
		  i= 0; // to avoid in inferred latch
        if(rst)
            for(i=0; i<bs; i=i+1)
                buffer[i] <= 0;
        else begin
            Instr_out <= buffer[buffer_index];
            buffer[buffer_index] <= Instr_in;
        end
    end
	 
	 always@(*) begin
		j = 0; // avoiding infered latches
		if(!rst) begin
			full = 1;
			for(j=0; j<bs; j=j+1) 
				if(!buffer[j]) full = 0;
		end else full = 1'b0;	
	 end
	 
	 assign start = (Instr_in == 0) ? 1'b1 : (full ? 1'b1 : 1'b0);

endmodule