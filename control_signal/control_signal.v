module control_signal (MOVA,MOVB,MOVC,ADD,SUB,AND1,NOT1,RSR,RSL,JMP,JZ,Z,JC,C,IN1,OUT1,NOP,HALT,IR,SM,REG_RA,REG_WA,MADD,ALU_S,PC_LD,PC_INC,REG_WE,RAM_XL,RAM_DL,ALU_M,SHI_FBUS,SHI_FLBUS,SHI_FRBUS,IR_LD,CF_EN,ZF_EN,SM_EN,IN_EN,OUT_EN);
    input MOVA,MOVB,MOVC,ADD,SUB,AND1,NOT1,RSR,RSL,JMP,JZ,Z,JC,C,IN1,OUT1,NOP,HALT,SM;
    //    MOVA,MOVB,MOVC,ADD,SUB,AND, NOT, RSR,RSL,JMP,JZ-T,JC-T,IN, OUT, NOP,HALT,SM
    input[7:0] IR;
    output[1:0] REG_RA,REG_WA,MADD;
    //          RAA,   RWBA,  MADD
    output[3:0] ALU_S;
    //          S
    output PC_LD,PC_INC,REG_WE,RAM_XL,RAM_DL,ALU_M,SHI_FBUS,SHI_FLBUS,SHI_FRBUS,IR_LD,CF_EN,ZF_EN,SM_EN,IN_EN,OUT_EN;
    //     LD PC,IN PC, /WE,   XL,    DL,    M,    F-BUS,   FL-BUS,   FR-BUS,   LD IR,            SM,

    reg[1:0] MADD,REG_RA,REG_WA;
    reg[3:0] ALU_S;
    
    assign RAM_DL = (~SM)||MOVC||JMP||(JZ&&Z)||(JC&&C); //取指,MOVC,JMP,JZT,JCT
    assign RAM_XL = MOVB&&(~SM); //MOVB
    assign PC_LD = JMP||(JZ&&Z)||(JC&&C); //JMP,JZT,JCT
    assign PC_INC = (~SM)||(JZ&&~Z)||(JC&&~C); //取指,JZF,JCF
    assign IR_LD = (~SM); //取指
    assign SHI_FBUS = ADD||SUB||AND1||NOT1||OUT1||MOVA||MOVB; //ADD,SUB,AND,NOT,OUT,MOVA,MOVB
    assign SHI_FLBUS = RSL; //RSL
    assign SHI_FRBUS = RSR; //RSR
    assign ALU_M = ADD||SUB||AND1||NOT1||RSR||RSL||OUT1;
    assign REG_WE = (~SM)||OUT1||MOVB||JMP||JZ||JC||HALT||NOP;
    assign CF_EN = ADD||SUB||RSR||RSL;
    assign ZF_EN = ADD||SUB;
    assign SM_EN = ~HALT;
    assign IN_EN = IN1;
    assign OUT_EN = OUT1;
    
    always @(SM,MOVB,MOVC) begin //MADD
        if(~SM) MADD=2'b0;
        else if(MOVB) MADD=2'b10;
        else if(MOVC) MADD=2'b01;
        else MADD=2'b0; //不锁存只能这样了吧？
    end

    always @(ADD,SUB,AND1,NOT1,RSR,RSL,OUT1,MOVA,MOVB) begin //ALU_S
        if(ADD||SUB||AND1||NOT1||RSR||RSL||OUT1||MOVA||MOVB) ALU_S[3:0]=IR[7-:4];
        else ALU_S=4'b0;
    end

    always @(ADD,SUB,AND1,MOVA,MOVB,MOVC) begin //RAA
        if(ADD||SUB||AND1||MOVA||MOVB||MOVC) REG_RA=IR[1-:2];
        else REG_RA=2'b0;
    end

    always @(ADD,SUB,AND1,NOT1,RSR,RSL,IN1,OUT1,MOVA,MOVB,MOVC) begin//RWBA
        if(ADD||SUB||AND1||NOT1||RSR||RSL||IN1||OUT1||MOVA||MOVB||MOVC) REG_WA=IR[3-:2];
        else REG_WA=2'b0;
    end
    
endmodule