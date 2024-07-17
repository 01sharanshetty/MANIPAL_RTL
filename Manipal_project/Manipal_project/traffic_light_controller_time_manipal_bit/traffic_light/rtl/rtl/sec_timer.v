module sec_timer 
(
    input  wire clk,
    input  wire reset_n,
    input  wire rst_count,
    output reg  one_sec_timer,
    output reg  five_sec_timer
);

//`define SIM = 1
`ifdef SIM
    localparam FREQ = 50;               //1 us delay  @50 MHz clock
`else
    localparam FREQ = 50 * 1000 * 1000; //1 sec delay @50 MHz clock
`endif

localparam DELAY_IN_SEC = 5;


reg [25:0]  count;                    // count to manage timing
reg [5:0]   sec_count;

always @(posedge clk or negedge reset_n) 
begin
    if (!reset_n) 
        begin
            count <= 26'h0;
            sec_count <= 5'h0;
            one_sec_timer <= 0;
            five_sec_timer <= 0;
        end 
    else begin
                
        if (rst_count == 1) begin
            count <= 3'b0;
            sec_count <= 5'h0;
            one_sec_timer <= 0; 
            five_sec_timer <= 0;            
        end

            //1 sec timer
        else if (count == FREQ * 1) begin                          //one sec counter
            count <= 'b0;
            one_sec_timer <= 1;
            
            //5 sec timer
            if (sec_count == DELAY_IN_SEC - 1) begin         
                sec_count <= 5'h0;
                five_sec_timer <= 1;
            end
            else begin
                sec_count <= sec_count + 1;
                five_sec_timer <= 0;
            end
        end 

        else begin  
            one_sec_timer <= 0;  
            count <= count + 1;
            five_sec_timer <= 0;
            sec_count <= sec_count;
        end   
    end
end
endmodule