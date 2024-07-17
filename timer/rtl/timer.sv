module timer 
(
    input  wire clk_50m,
    input  wire reset_n,
    input  wire reset_timer,

    output reg  one_sec_timer,
    output reg  one_min_timer,
    output reg  one_hour_timer
);

`define SIM
`ifdef SIM
    localparam FREQ = 50;               //1 us delay  @50 MHz clock
`else
    localparam FREQ = 50 * 1000 * 1000; //1 sec delay @50 MHz clock
`endif

localparam DELAY_IN_SEC = 5;

//conversion
localparam SEC_TO_MIN  = 60;
localparam MIN_TO_HOUR = 60;
localparam HOUR_TO_DAY = 24;

localparam SEC_WIDTH    = 6;
localparam MIN_WIDTH    = 6;
localparam HOUR_WIDTH   = 5;

reg [25:0]                  count;                    // count to manage timing
reg [SEC_WIDTH - 1 : 0]     sec_count;
reg [MIN_WIDTH - 1 : 0]     min_count;
reg [HOUR_WIDTH - 1 : 0]    hour_count;

always @(posedge clk_50m or negedge reset_n) 
begin
    if (!reset_n) 
        begin
            count           <= 26'h0;
            sec_count       <= {(SEC_WIDTH-1){1'b0}};
            min_count       <= {(MIN_WIDTH-1){1'b0}};
            hour_count      <= {(HOUR_WIDTH-1){1'b0}};
            one_sec_timer   <= 1'b0;
            one_min_timer   <= 1'b0;
            one_hour_timer  <= 1'b0;
        end 
    else begin
                
        if (reset_timer == 1) begin
            count           <= 3'b0;
            sec_count       <= {(SEC_WIDTH-1){1'b0}};
            min_count       <= {(MIN_WIDTH-1){1'b0}};
            hour_count      <= {(HOUR_WIDTH-1){1'b0}};
            one_sec_timer   <= 1'b0; 
            one_min_timer   <= 1'b0;
            one_hour_timer  <= 1'b0;
        end

            //1 sec timer
        else if (count == FREQ * 1) begin                          //one sec counter
            count <= 'b0;
            one_sec_timer   <= 1'b1;
            
            //60 sec timer
            if (sec_count == SEC_TO_MIN - 1) begin                  //60 sec count
                sec_count   <= {(SEC_WIDTH-1){1'b0}};
                
                if (min_count == MIN_TO_HOUR- 1) begin              //60 min count
                    min_count       <= {(MIN_WIDTH-1){1'b0}};
                    one_min_timer   <= 1'b1;
                    
                    if (hour_count == HOUR_TO_DAY- 1) begin         //24 hour count
                        hour_count      <= {(HOUR_WIDTH-1){1'b0}};
                        one_hour_timer  <= 1'b1;
                    end
                    else begin 
                        hour_count      <= hour_count + 1;
                        one_hour_timer  <= 1'b1;
                    end
                end
                else begin
                    min_count       <= min_count + 1;
                    one_min_timer   <= 1'b1;
                    one_hour_timer  <= 1'b0;
                    
                end
            end   
            else begin
                sec_count       <= sec_count + 1;
                min_count       <= min_count;
                hour_count      <= hour_count;
                one_min_timer   <= 1'b0;
                one_hour_timer  <= 1'b0;
            end
        end 

        else begin                
            count          <= count + 1;
            sec_count      <= sec_count;
            one_sec_timer  <= 1'b0;
            one_min_timer  <= 1'b0;
            one_hour_timer <= 1'b0;
        end   
    end
end
endmodule