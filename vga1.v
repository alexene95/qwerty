

module vga1(
	input wire clk,			//pixel clock: 25MHz
	input wire rst,			//asynchronous reset
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [3:0] red,	//red vga output
	output reg [3:0] green, //green vga output
	output reg [3:0] blue	//blue vga output
	);

// video structure constants
reg [1:0] cnt;
wire clk_25;
parameter hpixels = 1040;// horizontal pixels per line
parameter vlines = 666; // vertical lines per frame
parameter hpulse = 120; 	// hsync pulse length
parameter vpulse = 6; 	// vsync pulse length
parameter hbp = 64; 	// end of horizontal back porch
parameter hfp = 56; 	// beginning of horizontal front porch
parameter vbp = 23; 		// end of vertical back porch
parameter vfp = 37; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;



				
always @(posedge clk or posedge rst)
begin
	// reset condition
	if (rst == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else

		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end


assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;


always @(*)
begin
	
	if (vc >= vbp && vc < vfp)
	begin
		
		if (hc >= hbp && hc < (hbp+80))
		begin
			red = 4'b1111;
			green = 4'b1111;
			blue = 4'b1111;
		end
		
		else if (hc >= (hbp+80) && hc < (hbp+160))
		begin
			red = 4'b1111;
			green = 4'b1111;
			blue = 4'b0000;
		end
		// display cyan bar
		else if (hc >= (hbp+160) && hc < (hbp+240))
		begin
			red = 4'b0000;
			green = 4'b1111;
			blue = 4'b1111;
		end
		// display green bar
		else if (hc >= (hbp+240) && hc < (hbp+320))
		begin
			red = 4'b0000;
			green = 4'b1111;
			blue = 4'b0000;
		end
		// display magenta bar
		else if (hc >= (hbp+320) && hc < (hbp+400))
		begin
			red = 4'b1111;
			green = 4'b0000;
			blue = 4'b1111;
		end
		// display red bar
		else if (hc >= (hbp+400) && hc < (hbp+480))
		begin
			red = 4'b1111;
			green = 4'b0000;
			blue = 4'b0000;
		end
		// display blue bar
		else if (hc >= (hbp+480) && hc < (hbp+560))
		begin
			red = 4'b0000;
			green = 4'b0000;
			blue = 4'b1111;
		end
		// display black bar
		else if (hc >= (hbp+560) && hc < (hbp+640))
		begin
			red = 4'b0000;
			green = 4'b0000;
			blue = 4'b0000;
		end
		// we're outside active horizontal range so display black
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

endmodule