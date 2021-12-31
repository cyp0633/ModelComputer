module decoder (EN,IR,MOVA,MOVB,MOVC,ADD,SUB,AND,NOT,RSR,RSL,JMP,JZ,JC,IN,OUT,NOP,HALT);
    input EN;
    input[7:0] IR;
    output MOVA,MOVB,MOVC,ADD,SUB,AND,NOT,RSR,RSL,JMP,JZ,JC,IN,OUT,NOP,HALT;
    reg MOVA,MOVB,MOVC,ADD,SUB,AND,NOT,RSR,RSL,JMP,JZ,JC,IN,OUT,NOP,HALT;
always @(IR,EN) begin
    if(EN==1'b1) begin
        if (IR[7-:4]==4'b1100) begin //MOV
            if(IR[3-:2]==2'b11) begin //MOVB 11R2
                MOVA=1'b0;
                MOVB=1'b1;
                MOVC=1'b0;
            end
            else if (IR[1-:2]==2'b11) begin //MOVC R1111
                MOVA=1'b0;
                MOVB=1'b0;
                MOVC=1'b1;
            end
            else begin //MOVA R1R2
                MOVA=1'b1;
                MOVB=1'b0;
                MOVC=1'b0;
            end
        end
        else begin
            MOVA=1'b0;
            MOVB=1'b0;
            MOVC=1'b0;
        end
        if (IR[7-:4]==4'b1001 && IR[3-:2]!=2'b11 && IR[1-:2]!=2'b11) begin //ADD
            ADD=1'b1;
        end
        else ADD=1'b0;
        if (IR[7-:4]==4'b0110 && IR[3-:2]!=2'b11 && IR[1-:2]!=2'b11) begin //SUB
            SUB=1'b1;
        end
        else SUB=1'b0;
        if (IR[7-:4]==4'b1011 && IR[3-:2]!=2'b11 && IR[1-:2]!=2'b11) begin //AND
            AND=1'b1;
        end
        else AND=1'b0;
        if (IR[7-:4]==4'b0101 && IR[3-:2]!=2'b11) begin //NOT
            NOT=1'b1;
        end
        else NOT=1'b0;
        if (IR[7-:4]==4'b1010 && IR[1-:2]==2'b00 && IR[3-:2]!=2'b11) begin //RSR
            RSR=1'b1;
        end
        else RSR=1'b0;
        if (IR[7-:4]==4'b1010 && IR[1-:2]==2'b11 && IR[3-:2]!=2'b11) begin //RSL
            RSL=1'b1;
        end
        else RSL=1'b0;
        if (IR[7:0]==8'b0011_0000||IR[7:0]==8'b0001_0000) begin //JMP
            JMP=1'b1;
        end
        else JMP=1'b0;
        if (IR[7:0]==8'b0011_0001||IR[7:0]==8'b0001_0001) begin //JZ
            JZ=1'b1;
        end
        else JZ=1'b0;
        if (IR[7:0]==8'b0011_0010||IR[7:0]==8'b0001_0010) begin //JC
            JC=1'b1;
        end
        else JC=1'b0;
        if (IR[7-:4]==4'b0010 && IR[3-:2]!=2'b11) begin //IN
            IN=1'b1;
        end
        else IN=1'b0;
        if (IR[7-:4]==4'b0100 && IR[3-:2]!=2'b11) begin //OUT
            OUT=1'b1;
        end
        else OUT=1'b0;
        if (IR[7:0]==8'b0111_0000) begin //NOP
            NOP=1'b1;
        end
        else NOP=1'b0;
        if (IR[7:0]==8'b1000_0000) begin //HALT
            HALT=1'b1;
        end
        else HALT=1'b0;
    end
    else begin
        MOVA=1'b0;
        MOVB=1'b0;
        MOVC=1'b0;
        ADD=1'b0;
        SUB=1'b0;
        AND=1'b0;
        NOT=1'b0;
        RSR=1'b0;
        RSL=1'b0;
        JMP=1'b0;
        JZ=1'b0;
        JC=1'b0;
        IN=1'b0;
        OUT=1'b0;
        NOP=1'b0;
        HALT=1'b0;
    end

end

endmodule //decoder