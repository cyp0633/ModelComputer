module Shift_Register (F_BUS,FL_BUS,FR_BUS,a,W,Cf);
    input F_BUS,FL_BUS,FR_BUS;
    input[7:0] a;
    output[7:0] W;
    output Cf;
    
    reg[7:0] W;
    reg Cf;

    wire[2:0] BUS;
    
    assign BUS = {F_BUS,FL_BUS,FR_BUS};
    
    always @(BUS) begin
        case (BUS)
            3'b100: begin
                W = a;
                Cf = 0;
            end
            3'b010: begin
                W  = {a[6:0],a[7]};
                Cf = a[7];
            end
            3'b001: begin
                W  = {a[0],a[7:1]};
                Cf = a[0];
            end
            default: begin
                W = 8'bZZZZZZZZ;
                Cf = 0;
            end
        endcase
    end
endmodule //Shift_Register
