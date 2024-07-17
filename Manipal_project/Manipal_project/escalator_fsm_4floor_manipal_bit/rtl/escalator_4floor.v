module elevator(
		input        clk,
		input 	     rst,
		input  [3:0] req_floor,    // input to the escalator
//		output [3:0] o_count,
		output [3:0] rec_floor     // output of escalator, whic floor escalator will reach
//		output reg   o_door_open
		);

	reg [3:0]  cur_floor = 4'b0001;
	reg [15:0] counter;               // number of bits can be increased depending on the clock frequency
//	reg        open_door;

always@(posedge clk) begin
    if (rst) begin
        counter <= 16'b0000_0000_0000_0000;
    end else if (counter < 16'b1000_0000_0000_0000) begin
        counter <= counter + 1; 
    end else
        counter <= 16'b0000_0000_0000_0000; 
    end
    
// assign o_count = counter;

always@(posedge counter[15]) begin
//if (rst) begin
//    cur_floor <= 4'b0001;
//    open_door <= 1'b0;
//end else begin
if (req_floor < cur_floor) 
begin
  if (cur_floor == 4'b0001) begin    
    cur_floor <= 4'b0001;
//    o_door_open <= 1'b1;   
  end else begin
    cur_floor <= cur_floor >> 1; //so that escalator can reach to ground floor
//    o_door_open <= 1'b0;
  end 
end else if (req_floor > cur_floor) begin
  cur_floor <= cur_floor << 1;
//  o_door_open <= 1'b0;
end else if (req_floor == cur_floor) begin
  cur_floor <= req_floor;
//  o_door_open <= 1'b1;
//end else
//    cur_floor <= cur_floor;
end
end

assign rec_floor = cur_floor;
//assign o_door_open = open_door;

endmodule