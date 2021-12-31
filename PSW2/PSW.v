module PSW(clk,cf_en,zf_en,cf,zf,c,z);
    input clk,cf_en,zf_en,cf,zf;
    output c,z;
    reg c,z;
    reg cTemp,zTemp;

    always @(negedge clk) begin
        if(cf_en) begin
            c<=cf;
        end
        if(zf_en) begin
            z<=zf;
        end
    end
endmodule //PSW