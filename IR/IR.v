module IR(clk,ir_ld,d,ir);
    input clk,ir_ld;
    input[7:0] d;
    output[7:0] ir;

    reg[7:0] ir;
    
    always @(negedge clk) begin
        if(ir_ld) begin
            ir <= d;
        end
    end
endmodule