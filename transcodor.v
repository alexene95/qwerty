module transcodor (
						input [7:0] data_in,
						output reg [6:0] data_out
						);
						
						always@(*)
								case(data_in)
										
										8'h0B : data_out =7'b1000000;     //0
	 									8'h02 : data_out = 7'b1111001;   //1
										8'h03: data_out = 7'b0100100;   //2
										8'h04: data_out = 7'b0110000;   //3
										8'h05: data_out = 7'b0011011;	//4
										8'h06: data_out = 7'b0010010;   //5
										8'h07: data_out = 7'b0000010;	//6
										8'h08: data_out = 7'b1111000;  //7
										8'h09: data_out = 7'b0000000;	//8
										8'h0A: data_out = 7'b0010000;   //9
										8'h1E: data_out = 7'b0001000;   //A
										8'h30: data_out = 7'b0000011;	//B
										8'h2E: data_out = 7'b1000110;   //C
										8'h20: data_out = 7'b1000000;  //D
										8'h12: data_out = 7'b0000110; //E
										8'h21: data_out = 7'b0001110; //F
										default : data_out = 7'b1111111;
										endcase
										
endmodule