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
	 
	 reg [0:bs-1] valid_entries = {bs{1'b0}}; // tells us which values in the buffer are actually correct
    reg [Instr_word_size-1:0] buffer [0:bs-1];

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            valid_entries <= {bs{1'b0}};
				Instr_out <= {Instr_word_size{1'b0}};
		  end else begin
            Instr_out <= buffer[buffer_index];
            buffer[buffer_index] <= Instr_in;
				valid_entries[buffer_index] <= (Instr_in)? 1'b1 : 1'b0; // in case the instructions are over then instr_in will be 0, hence directly i can say it is invalid entry
        end
    end
	 
	 assign start = (Instr_in == 0) ? 1'b1 : (&valid_entries); // what this is doing is 
	 // Instr_in == 0 that is it will all the input instructions are over, used in case where no of instr < buffer size
	 // &valid_entries mean that when buffer is full
endmodule