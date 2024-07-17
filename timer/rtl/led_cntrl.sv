module led_cntrl 
(
    input  wire clk_50m,
    input  wire reset_n,

    input  reg  one_sec_timer,
    input  reg  one_min_timer,
    input  reg  one_hour_timer,
    output reg  n_sec_led,
    output reg  n_min_led,
    output reg  n_hour_led      //3 mins delay
);


localparam DELAY_IN_SEC = 1;
localparam DELAY_IN_MIN = 1;
localparam DELAY_IN_MIN_HR = 3;    //for HOUR LED

localparam SEC_WIDTH    = 6;
localparam MIN_WIDTH    = 6;
localparam HOUR_WIDTH   = 5;

reg [SEC_WIDTH - 1 : 0]     n_sec_count;
reg [MIN_WIDTH - 1 : 0]     n_min_count;
reg [HOUR_WIDTH - 1 : 0]    n_min_count1;

//n sec delay for sec LED
always @(posedge clk_50m or negedge reset_n) 
begin
    if (!reset_n) 
        begin
            n_sec_count     <= {(SEC_WIDTH-1){1'b0}};
            n_sec_led       <= 1'b0;
        end 
    else begin
        if (one_sec_timer == 1) 
        begin
            if (n_sec_count == DELAY_IN_SEC - 1) 
            begin
                n_sec_led      <= ~n_sec_led;
                n_sec_count    <= {(SEC_WIDTH-1){1'b0}};
            end
            else begin
                n_sec_led     <= n_sec_led;
                n_sec_count   <= n_sec_count + 1;                
            end
        end
        else n_sec_count <= n_sec_count;
    end
end

//n min delay for min LED
always @(posedge clk_50m or negedge reset_n) 
begin
    if (!reset_n) 
        begin
            n_min_count     <= {(MIN_WIDTH-1){1'b0}};
            n_min_led       <= 1'b0;
        end 
    else begin
        if (one_min_timer == 1) 
        begin
            if (n_min_count == DELAY_IN_MIN - 1) 
            begin
                n_min_led      <= ~n_min_led;
                n_min_count     <= {(MIN_WIDTH-1){1'b0}};
            end
            else begin
                n_min_led     <= n_min_led;
                n_min_count <= n_min_count + 1;
            end   
        end  
        else n_min_count <= n_min_count;
    end
end


//n min delay for hour LED
always @(posedge clk_50m or negedge reset_n) 
begin
    if (!reset_n) 
        begin
            n_min_count1    <= {(HOUR_WIDTH-1){1'b0}};
            n_hour_led      <= 1'b0;
        end 
    else begin
  
        if (one_min_timer == 1)
        begin
            if (n_min_count1 == DELAY_IN_MIN_HR - 1) 
            begin
                n_hour_led      <= ~n_hour_led;
                n_min_count1    <= {(HOUR_WIDTH-1){1'b0}};

            end
            else begin
                n_hour_led     <= n_hour_led;
                n_min_count1 = n_min_count1 + 1;
            end 
        end
        else n_min_count1 <= n_min_count1;

    end
end

endmodule