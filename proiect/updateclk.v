module updateclk(
input clk, 
output reg update
);
	
	reg [23:0]count;	

	always@(posedge clk)
	begin
		count <= count + 1;
		if(count == 3000000)
		begin
			update <= ~update;
			count <= 0;
		end	
	end
endmodule
