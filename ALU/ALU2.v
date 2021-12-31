module ALU2 (M,S,A,B,t,Cf,Zf);
    input M;//算术运算指示
    input [3:0] S;//运算类型
    input [7:0] A,B;//参与运算的数字

    output [7:0] t;//输出结果
    output Cf,Zf;//是否进位，是否为0

    reg [7:0] t;
    reg Cf,Zf;
    reg [7:0] temp1;

    always @(M,S,A,B) begin
        if (M==1'b0) begin //不进行算术运算
            if(S==4'b1100) t[7:0]=A[7:0];
            else t=8'b0;
            Cf=1'b0;
            Zf=1'b0;
        end
        else begin//进行算术运算
            case (S)
                4'b1001: begin //ADD
                    {Cf,t}=A+B;
                    if (t==8'b0) begin
                        Zf=1'b1;
                    end
                    else Zf=1'b0;
                end
                4'b0110: begin //SUB
                    {Cf,t}=B-A;
                    if(t==8'b0) Zf=1'b1;
                    else Zf=1'b0;
                end
                4'b1011: begin //AND
                    // t=A&&B;
                    t[0]=A[0]&&B[0];
                    t[1]=A[1]&&B[1];
                    t[2]=A[2]&&B[2];
                    t[3]=A[3]&&B[3];
                    t[4]=A[4]&&B[4];
                    t[5]=A[5]&&B[5];
                    t[6]=A[6]&&B[6];
                    t[7]=A[7]&&B[7];
                    Cf=0;
                    Zf=0;
                end
                4'b0101: begin
                    t=~B; //NOT
                    Cf=0;
                    Zf=0;
                end
                4'b1010: begin
                    t=B;
                    Cf=0;
                    Zf=0;
                end
                4'b0100: begin
                    t=B;
                    Cf=0;
                    Zf=0;
                end
                4'b1100: begin
                    t=A;
                    Cf=0;
                    Zf=0;
                end
                default: begin
                    Cf=0;
                    Zf=0;
                    t=8'b0;
                end
            endcase
        end
    end
endmodule //ALU2