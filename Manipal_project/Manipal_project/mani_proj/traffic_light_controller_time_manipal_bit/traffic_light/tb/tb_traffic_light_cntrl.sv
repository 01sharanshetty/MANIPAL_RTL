`timescale 1 ns/ 1 ns

module tb_traffic_light_cntrl ();

parameter   CLK_PERIOD    = 20;     // 50 MHz clock

reg         clk = 0;
reg         reset_n;
wire [1:0]  n_light;
wire [1:0]  e_light;
wire [1:0]  s_light;
wire [1:0]  w_light;

top_traffic_light_cntrl top_traffic_light_cntrl_inst
(
    .clk                 (clk    ),
    .reset_n             (reset_n),
    .n_light             (n_light),
    .e_light             (e_light),
    .s_light             (s_light),
    .w_light             (w_light) 
);

// ------------------------------------
// Clock generation
// ------------------------------------
always
  begin
    #(CLK_PERIOD/2) clk <= ~clk;
  end
  
// ------------------------------------
// Reset generation
// ------------------------------------
initial
  begin
    reset_n        = 1'b0;
    #100 reset_n  =  1'b1; 
  end

endmodule