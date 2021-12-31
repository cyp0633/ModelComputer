module Register(WE,clk,RA,WA,i,S,D);
    input WE,clk;
    input [1:0] RA,WA;
    input [7:0] i;

    output[7:0] S,D;

    reg [7:0] S,D;
    reg [7:0] a=8'b00000000;
    reg [7:0] b=8'b00000000;
    reg [7:0] c=8'b10000000;

    always @(RA) begin
        case(RA)
            2'b00: S=a;
            2'b01: S=b;
            default: S=c;
        endcase
    end

    always @(WA) begin
        case(WA)
            2'b00: D=a;
            2'b01: D=b;
            default: D=c;
        endcase
    end

    always @(negedge clk) begin
        if(WE==0) begin
            case(WA)
                2'b00: a<=i;
                2'b01: b<=i;
                2'b10: c<=i;
            endcase
        end
    end

endmodule //Register