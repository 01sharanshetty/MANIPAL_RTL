module top_timer_led 
(
    input  wire     clk_50m,
    input  wire     reset_n,
    input  wire     reset_timer,
  
    //LED output 
    output wire     n_sec_led,     
    output wire     n_min_led,     
    output wire     n_hour_led      
);

wire       one_sec_timer;
wire       one_min_timer;
wire       one_hour_timer;

timer timer_inst
(
    .clk_50m              (clk_50m       ),         
    .reset_n              (reset_n       ),         
    .reset_timer          (reset_timer   ),             
    .one_sec_timer        (one_sec_timer ),               
    .one_min_timer        (one_min_timer ),               
    .one_hour_timer       (one_hour_timer)               
);

led_cntrl led_cntrl_inst
(
    .clk_50m              (clk_50m       ),               
    .reset_n              (reset_n       ),               
    .one_sec_timer        (one_sec_timer ),                     
    .one_min_timer        (one_min_timer ),                     
    .one_hour_timer       (one_hour_timer),                      
    .n_sec_led            (n_sec_led     ),                 
    .n_min_led            (n_min_led     ),                 
    .n_hour_led           (n_hour_led    )                
);


endmodule