module move_square(clock, switches, coord_x, coord_y, red, green, blue);
	input clock;
	input [17:0] switches;
	input [9:0] coord_x;
	input [9:0] coord_y;
	output [3:0] red;
	output [3:0] green;
	output [3:0] blue;
	
	reg [9:0] x_cur;
	reg [9:0] y_cur;
	reg enable_move;
	
	always @(posedge clock) begin
		if (enable_move) begin
			
		end
	end
endmodule