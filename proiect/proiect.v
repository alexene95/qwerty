module proiect (
						input btn_l,btn_r,rst,
						input clk,


						output h_sync,
						output v_sync,
						output reg [3:0] red,
						output reg [3:0] green,
						output reg [3:0] blue
						);
			
wire display_en;
wire [10:0] x_pos, y_pos;
wire update;
vga_sync vga(.clk(clk),.h_sync(h_sync),.v_sync(v_sync),.display_en(display_en),.x_pos(x_pos),.y_pos(y_pos));
		
updateclk clock(.clk(clk),.update(update));
reg border,paddle,ball;	
reg [10:0] paddle_x;
reg [10:0] ball_x,ball_y;
wire left,right,reset;

initial begin
paddle_x=300;
ball_x=390;
ball_y=290;
end


assign left=(~btn_l)?1:0;  
assign right=(~btn_r)?1:0; 
assign reset=(~rst)?1:0; 

always @(posedge clk) begin
	border <= (((x_pos <=20) || (x_pos >= 770) ) || 
((y_pos >= 0) && (y_pos <= 20) || (y_pos >= 580) && (y_pos <= 700)));
	paddle <=(x_pos > paddle_x && x_pos < (paddle_x+150)) && (y_pos > 560 && y_pos < 580);
   ball <= (x_pos > ball_x && x_pos < (ball_x+20)) && (y_pos > ball_y && y_pos < (ball_y+20));
end
reg paddle_xl;//x left
reg smash_y1;
reg smash_y2;
wire bounce = paddle|border;

always @(posedge update) begin
//		if(display_en) begin
//			if (ball & paddle)
//				smash_y1=1;
//				else smash_y1 = 0;
//				
//			if ( border && ball)
//					smash_y2 = 1;
//			else
//				begin
//			 smash_y1=0;
//			 smash_y2=0;
//				end
//			end	
end			
always @(posedge update) begin
	if(reset)begin
		paddle_x=300;
		ball_x=390;
		ball_y=290;
	end
		else begin
if (display_en) begin
end
		paddle_xl = paddle_x+150;
		ball_y = ball_y +20;
		end
		 begin
		 if (smash_y1)
		 ball_y=ball_y -20;
		 else if (smash_y2)
		 ball_y= ball_y+20;
		 else
		 ball_y<=ball_y;
		 
		 end
		if (left)begin
			paddle_x<=paddle_x-50;	
		end
		else if (right)begin
			paddle_x<=paddle_x+50;
		end
		else if (btn_r && paddle_x >=520)
				paddle_x <= 620;			
		else if (btn_l &&  paddle_xl <= 75 ) 
				paddle_xl = 175;											/////nu se duce in stanga 
		else begin
		
		
			paddle_x<=paddle_x;
		end
	end

	

	

assign paddle_c = (paddle);
assign border_c = (border);
always@(posedge clk) begin

		if(display_en) begin
			if(paddle||border||ball) begin
				if(paddle)begin
					red=4'b0000;
					green=4'b0000;
					blue=4'b1111;
				end
				if(border)begin
					red=4'b0000;
					green=4'b0000;
					blue=4'b0000;
				end
				if (ball)begin
				red=4'b0000;
					green=4'b0000;
					blue=4'b1111;
			end
			end
			else begin
					red=4'b1111;
					green=4'b1111;
					blue=4'b1111;
			end
		end
		else begin
			red=4'b0000;
			green=4'b0000;
			blue=4'b0000;
		end
end
endmodule


		

