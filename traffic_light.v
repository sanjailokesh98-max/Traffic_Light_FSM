`timescale 1ns/1ps


module traffic_light_fsm (
    input  clk,
    input  rst,
    output reg [2:0] road_A, 
    output reg [2:0] road_B  
);

    
    parameter S0_A_GREEN  = 2'b00;
    parameter S1_A_YELLOW = 2'b01;
    parameter S2_B_GREEN  = 2'b10;
    parameter S3_B_YELLOW = 2'b11;

    reg [1:0] state, next_state;
    reg [3:0] timer;

    
    parameter GREEN_TIME  = 4'd5;
    parameter YELLOW_TIME = 4'd2;

    
    always @(posedge clk) begin
        if (rst) begin
            state <= S0_A_GREEN;
            timer <= 4'd0;
        end else begin
            if (timer == 4'd0)
                state <= next_state;
            else
                timer <= timer - 1;
        end
    end

    
    always @(*) begin
        case (state)
            S0_A_GREEN:  begin next_state = S1_A_YELLOW; end
            S1_A_YELLOW: begin next_state = S2_B_GREEN;  end
            S2_B_GREEN:  begin next_state = S3_B_YELLOW; end
            S3_B_YELLOW: begin next_state = S0_A_GREEN;  end
            default:     begin next_state = S0_A_GREEN;  end
        endcase
    end

   
    always @(*) begin
        case (state)
            S0_A_GREEN:  begin road_A = 3'b001; road_B = 3'b100; end 
            S1_A_YELLOW: begin road_A = 3'b010; road_B = 3'b100; end 
            S2_B_GREEN:  begin road_A = 3'b100; road_B = 3'b001; end 
            S3_B_YELLOW: begin road_A = 3'b100; road_B = 3'b010; end 
            default:     begin road_A = 3'b100; road_B = 3'b100; end 
        endcase
    end

endmodule
