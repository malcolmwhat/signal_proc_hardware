module counter4 ( CLK, Y ); 

input CLK; 
output reg [3:0] Y; 
always@(posedge CLK) 

begin 
	Y <= Y + 1; 
end 
	
endmodule