module ESM (
    input [31:0] Instr_in,
    output reg [31:0] Instr_out
);
    localparam BUFFER_SIZE = 16;

    reg [31:0] Instr_Buffer [0:BUFFER_SIZE-1];

    initial begin
        for(integer i=0; i<BUFFER_SIZE; i=i+1) 
            Instr_Buffer[i] = 0;
    end
endmodule