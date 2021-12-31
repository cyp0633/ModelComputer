module mux (MADD,A,B,C,OUT);
    input[1:0] MADD;
    input[7:0] A,B,C;
    output[7:0] OUT;

    reg[7:0] OUT;

    always @(MADD,A,B,C) begin
        case (MADD) 
            2'b00: OUT=A;
            2'b01: OUT=B;
            2'b10: OUT=C;
            default: OUT=8'b0;
        endcase
    end
endmodule //mux