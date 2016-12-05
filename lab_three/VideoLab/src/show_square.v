/**
 *	This verilog module outputs rgb of white when the current x and y coords fall between
 * the x and y origin and the x and y limit (i.e. within the square delimitted by them).
 *
 * Author: Malcolm Watt
 */
module show_square(fsm_clck, x_coords, y_coords, switches, red, green, blue);
	// The current raster coordinates
	input fsm_clck;
	input [9:0] x_coords;
	input [9:0] y_coords;
	input [17:0] switches;
	
	// The output colour registers.
	output reg [3:0] red;
	output reg [3:0] green;
	output reg [3:0] blue;
	
	// Local declarations.
	reg [9:0] square_size = 10'b0000000001;
	reg [9:0] max_square_size = 10'b0111011111;
	
	parameter RED = 4'b1000, GREEN = 4'b0100, BLUE = 4'b0010, IDLE = 4'b0001;
	reg [3:0] state;
	reg [3:0] next_state = 4'b0001;
	
	reg fake_fsm_clock;
	always @(switches) begin
		fake_fsm_clock = switches[16];
	end
	
	/* Color FSM */
	always @(state) begin: COMBINATIONAL_LOGIC
		next_state = 4'b0001;
		case(state)
			IDLE: next_state = RED;
			RED: next_state = GREEN;
			GREEN: next_state = BLUE;
			BLUE: next_state = RED;
			default: next_state = RED;
		endcase
	end
	always @(posedge fake_fsm_clock) begin: SEQUENTIAL_LOGIC
		if (switches[17] == 1'b1) begin
			state <= IDLE;
		end
		else begin
			state <= next_state;
		end
	end
	
	
	/* Handle Square Drawing */
	always @(fake_fsm_clock, x_coords, y_coords, switches, state) begin
		// If the current coordinates are within the bounding box then output white RGB, otherwise black.
		if (switches[9:0] > max_square_size) begin
			square_size = max_square_size;
		end
		else begin
			square_size = switches[9:0];
		end
		
		
		if (x_coords <= square_size && y_coords <= square_size) begin
			case(state)
				IDLE: begin
					red = 4'b1111;
					green = 4'b1111;
					blue = 4'b1111;
				end
				RED: begin
					red = 4'b1111;
					green = 4'b0000;
					blue = 4'b0000;
				end
				GREEN: begin
					red = 4'b0000;
					green = 4'b1111;
					blue = 4'b0000;
				end
				BLUE: begin
					red = 4'b0000;
					green = 4'b0000;
					blue = 4'b1111;
				end
				default: begin
					red = 4'b1111;
					green = 4'b1111;
					blue = 4'b1111;
				end
			endcase
		end
		else begin
			red = 4'b0010;
			green = 4'b0010;
			blue = 4'b0010;
		end
	end
endmodule
