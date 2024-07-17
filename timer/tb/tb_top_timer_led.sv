`timescale 1 ns/ 1 ns

module tb_top_timer_led ();

`define SIM = 1
parameter   CLK_PERIOD    = 20;     // 50 MHz clock

reg         clk_50m = 0;
reg         reset_n;
wire        n_sec_led; 
wire        n_min_led; 
wire        n_hour_led;
reg         reset_timer;

top_timer_led top_timer_led_inst
(
    .clk_50m             (clk_50m       ), 
    .reset_n             (reset_n       ), 
    .reset_timer         (reset_timer   ),     
    .n_sec_led           (n_sec_led     ),       
    .n_min_led           (n_min_led     ),       
    .n_hour_led          (n_hour_led    )       
);

// ------------------------------------
// Clock generation
// ------------------------------------
always
  begin
    #(CLK_PERIOD/2) clk_50m <= ~clk_50m;
  end
  
// ------------------------------------
// Reset generation
// ------------------------------------
initial
  begin
    reset_n        = 1'b0;
    #100 reset_n   = 1'b1; 
    reset_timer    = 1'b0; 
end

endmodule
