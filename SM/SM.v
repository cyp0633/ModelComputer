module SM(clk,EN,z);
    input clk,EN;
    output z;

    reg z;

    always @(negedge clk) begin
        if(EN) z <= ~z;
    end

endmodule //SM