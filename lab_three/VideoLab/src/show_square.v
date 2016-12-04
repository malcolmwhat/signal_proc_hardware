/**
 *	This verilog module contains the logic which allows us to control the display of a square
 * on the screen.
 *
 * Author: Malcolm Watt
 */
module show_square(clock, switches, x_coords, y_coords, x_origin, y_origin, red, green, blue);
	input clock;
	input [17:0] switches; 
	input [9:0] x_coords;
	input [9:0] y_coords; 
	input [9:0] x_origin;
	input [9:0] y_origin;
	output reg [3:0] red;
	output reg [3:0] green;
	output reg [3:0] blue;
	
	reg [9:0] x;

	always @(switches,x_coords,y_coords) begin
		x = switches[9:0];
		if (x > x_coords && x > y_coords) begin
			red = 4'b1111;
			green = 4'b1111;
			blue = 4'b1111;
		end
		else begin
			red = 4'b0000;
			green = 4'b0000;
			blue = 4'b0000;
		end
	end
endmodule
