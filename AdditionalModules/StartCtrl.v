module StartCtrl (clk,startkey,pausekey,clken);
    input startkey,clk,pausekey;
    output clken;
    reg state,next_state,clken;
    parameter INIT = 1'b0,EN = 1'b1;

    always @(posedge clk or posedge pausekey) begin //state register
        if(pausekey) begin
            state <= INIT;
        end
        else begin
            state <= next_state;
        end
    end

    always @(startkey or state) begin //next state function
        case (state)
            INIT: next_state <= startkey ? EN : INIT;
            EN: next_state <= EN;
        endcase
    end
    
    always@(startkey or state) begin //output function
        case (state)
            INIT: clken <= 1'b0;
            EN: clken <= 1'b1;
        endcase
    end
    
endmodule //StartCtrl