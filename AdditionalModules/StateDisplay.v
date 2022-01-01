module StateDisplay (clken,halt,digitout);
    input clken,halt;
    output[7:0] digitout;
    
    assign digitout[7]=(~clken);
    assign digitout[6]=(~clken);
    assign digitout[5]=halt;
    assign digitout[4]=1'b0;
    assign digitout[3]=(~clken)||halt;
    assign digitout[2]=(~clken)||halt;
    assign digitout[1]=(~clken)||halt;
    assign digitout[0]=1'b0;
    //From 7 to 0: from a to g, plus dot
endmodule //StateDisplay