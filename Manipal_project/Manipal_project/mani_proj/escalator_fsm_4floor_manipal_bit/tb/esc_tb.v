module tb_elev;
		reg        clk;
		reg  	     rst;
		reg  [3:0] req_floor;   
		wire [3:0] rec_floor;
//		wire [3:0] o_count;
//		wire       o_door_open; 

elevator int_elev (
                  .clk(clk),
                  .rst(rst),
                  .req_floor(req_floor),
                  .rec_floor(rec_floor)
//                  .o_count(o_count)
//                  .o_door_open(o_door_open)
                  );

  initial begin
    clk = 0;
  end
  
  always begin
    #5 clk = ~ clk;
  end

  initial begin
  #10
  rst = 1'b1;
  req_floor = 4'b0100;
  #10
  rst = 1'b0;
  #10
  req_floor = 4'b0100;
  #200
  req_floor = 4'b0001;
  #200
  req_floor = 4'b1000;

  #5000000

  $finish;

  end

endmodule
