//`define SIM = 1
module top_traffic_light_cntrl 
(
    input  wire     clk,
    input  wire     reset_n,

    //Traffic light LED output 
    output reg [1:0] n_light,       // North light: Red, Yellow, Green
    output reg [1:0] e_light,       // East  light: Red, Yellow, Green
    output reg [1:0] s_light,       // South light: Red, Yellow, Green
    output reg [1:0] w_light        // West  light: Red, Yellow, Green
);

wire       w_rst_count;
wire       w_one_sec_timer;
wire       w_five_sec_timer;

traffic_light_cntrl traffic_light_cntrl_inst(
    .clk                 (clk           ),
    .reset_n             (reset_n       ),
    .rst_count           (w_rst_count     ),         
    .one_sec_timer       (w_one_sec_timer ),             
    .five_sec_timer      (w_five_sec_timer),  
    .n_light             (n_light       ),
    .e_light             (e_light       ),
    .s_light             (s_light       ),
    .w_light             (w_light       ) 
);

sec_timer sec_timer_inst
(
    .clk                 (clk           ),   
    .reset_n             (reset_n       ),       
    .rst_count           (w_rst_count     ),         
    .one_sec_timer       (w_one_sec_timer ),             
    .five_sec_timer      (w_five_sec_timer)             
);
endmodule