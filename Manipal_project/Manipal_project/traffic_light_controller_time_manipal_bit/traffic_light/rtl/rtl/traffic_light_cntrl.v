module traffic_light_cntrl 
(
    input  wire     clk,
    input  wire     reset_n,

    //timer interface signals
    input  wire     one_sec_timer,
    input  wire     five_sec_timer,
    output reg      rst_count,
    
    //Traffic light LED output 
    output reg [1:0] n_light,       // North light: Red, Yellow, Green
    output reg [1:0] e_light,       // East  light: Red, Yellow, Green
    output reg [1:0] s_light,       // South light: Red, Yellow, Green
    output reg [1:0] w_light        // West  light: Red, Yellow, Green
);
 
// State encoding
//typedef enum {
//    IDLE,   
//    S0,     
//    S1,     
//    S2,     
//    S3,      
//    S4,
//    S5,
//    S6,
//    S7
//} state_t;

localparam IDLE  = 4'b0000;
localparam S0    = 2'b0001;
localparam S1    = 2'b0010;
localparam S2    = 4'b0011;
localparam S3    = 2'b0100;
localparam S4    = 2'b0101;
localparam S5    = 4'b0110;
localparam S6    = 2'b0111;
localparam S7    = 2'b1000;



// State, next state, and count
reg [3:0] state, next_state;
 
// Light encoding: 2'b00 = Red, 2'b01 = Yellow, 2'b10 = Green
localparam RED    = 2'b00;
localparam YELLOW = 2'b01;
localparam GREEN  = 2'b10;
 
// State transition and light control
always @(posedge clk or negedge reset_n) 
begin
    if (!reset_n) begin
        state <= IDLE;
    end else begin
        state <= next_state;  
    end     
end
 
// Next state logic and output control
always @(*) 
begin
    // Default values
    next_state = state;
    n_light = RED;
    e_light = RED;
    s_light = RED;
    w_light = RED;
    rst_count = 0;

    case (state)
        IDLE: begin
            n_light = YELLOW;
            e_light = YELLOW;
            s_light = YELLOW;
            w_light = YELLOW;
            next_state = S0;
        end
        S0: begin
            n_light = GREEN;
            e_light = RED;
            s_light = RED;
            w_light = RED;
            next_state = S0;
            if (five_sec_timer == 1) begin // Time to change to Yellow
                next_state = S1;
                rst_count = 1;
            end
        end
        S1: begin
            n_light = YELLOW;
            e_light = YELLOW;
            s_light = RED;
            w_light = RED;
            next_state = S1;
            if (one_sec_timer == 1) begin // Time to change to EW Green
                next_state = S2;
                rst_count = 1;
            end
        end
        S2: begin
            n_light = RED;
            e_light = GREEN;
            s_light = RED;
            w_light = RED;
            next_state = S2;
            if (five_sec_timer == 1) begin // Time to change to Yellow
                next_state = S3;
                rst_count = 1;
            end
        end
        S3: begin
            n_light = RED;
            e_light = YELLOW;
            s_light = YELLOW;
            w_light = RED;
            next_state = S3;
            if (one_sec_timer == 1) begin // Time to change to NS Green
                next_state = S4;
                rst_count = 1;
            end
        end
        S4: begin
            n_light = RED;
            e_light = RED;
            s_light = GREEN;
            w_light = RED;
            next_state = S4;
            if (five_sec_timer == 1) begin // Time to change to Yellow
                next_state = S5;
                rst_count = 1;
            end
        end
        S5: begin
            n_light = RED;
            e_light = RED;
            s_light = YELLOW;
            w_light = YELLOW;
            next_state = S5;
            if (one_sec_timer == 1) begin // Time to change to NS Green
                next_state = S6;
                rst_count = 1;
            end
        end
        S6: begin
            n_light = RED;
            e_light = RED;
            s_light = RED;
            w_light = GREEN;
            next_state = S6;
            if (five_sec_timer == 1) begin // Time to change to Yellow
                next_state = S7;
                rst_count = 1;
            end
        end
        S7: begin
            n_light = YELLOW;
            e_light = RED;
            s_light = RED;
            w_light = YELLOW;
            next_state = S7;
            if (one_sec_timer == 1) begin // Time to change to NS Green
                next_state = S0;
                rst_count = 1;
            end
        end
        default : begin
            n_light = YELLOW;
            e_light = YELLOW;
            s_light = YELLOW;
            w_light = YELLOW;
            next_state = IDLE;
        end
    endcase
end
 
endmodule