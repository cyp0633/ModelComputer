module output_latch(indata,outen,outdata);
    input[7:0] indata;
    input outen;
    output[7:0] outdata;
    reg[7:0] outdata;

    always @(outen) begin
        if(outen==1'b1) begin
            outdata<=indata;
        end
    end
endmodule