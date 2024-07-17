//`define SIM = 1
module top_traffic_light_cntrl 
(
    input  wire     clk,
    input  wire     reset_n,

    //Traffic light LED output 
    output     [1:0] n_light,       // North light: Red, Yellow, Green
    output     [1:0] e_light,       // East  light: Red, Yellow, Green
    output     [1:0] s_light,       // South light: Red, Yellow, Green
    output     [1:0] w_light        // West  light: Red, Yellow, Green
);

wire       w_rst_count;
wire       w_one_sec_timer;
wire       w_five_sec_timer;

wire [1:0]  w_n_light;
wire [1:0]  w_e_light;
wire [1:0]  w_s_light;
wire [1:0]  w_w_light;

assign n_light = w_n_light;
assign e_light = w_e_light;
assign s_light = w_s_light;
assign w_light = w_w_light;


traffic_light_cntrl traffic_light_cntrl_inst(
    .clk                 (clk           ),
    .reset_n             (reset_n       ),
    .rst_count           (w_rst_count     ),         
    .one_sec_timer       (w_one_sec_timer ),             
    .five_sec_timer      (w_five_sec_timer),  
    .n_light             (w_n_light       ),
    .e_light             (w_e_light       ),
    .s_light             (w_s_light       ),
    .w_light             (w_w_light       ) 
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