module bitgen (SEL,bitstream); 

input [3:0] SEL; 
output reg bitstream; 
always @ (SEL) 

begin 
	bitstream = 0; 
	case (SEL) 
		4'b0001 : bitstream = 1'b1; 
		4'b0010 : bitstream = 1'b0; 
		4'b0011 : bitstream = 1'b0; 
		4'b0100 : bitstream = 1'b0; 
		4'b0101 : bitstream = 1'b1; 
		4'b0110 : bitstream = 1'b1; 
		4'b0111 : bitstream = 1'b0; 
		4'b1000 : bitstream = 1'b1;	 
	endcase 
end 

endmodule