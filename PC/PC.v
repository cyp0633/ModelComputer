module PC(ld,inc,clk,a,c);
    input ld,inc,clk;
    input[7:0] a;
    output[7:0] c;

    reg[7:0] c;

    always @(negedge clk) begin
        if (ld) begin
            c <= a;
        end else begin
            if (inc) begin
                c <= c + 1;
            end
        end
    end
endmodule //PC