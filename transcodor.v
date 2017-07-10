module transcodor(
	input [3:0] data_in,
	output reg [6:0] data_out
	);
						
	always@(*)
	case(data_in)
										
		4'h0 : data_out = 7'b1000000;   //0
	   4'h1 : data_out = 7'b1111001;   //1
		4'h2 : data_out = 7'b0100100;   //2
		4'h3 : data_out = 7'b0110000;   //3
		4'h4 : data_out = 7'b0011001;	  //4
		4'h5 : data_out = 7'b0010010;   //5
		4'h6 : data_out = 7'b0000010;	  //6
		4'h7 : data_out =7'b1111000;   //7
		4'h8 : data_out = 7'b0000000;   //8
		4'h9 : data_out = 7'b0010000;   //9
		4'hA : data_out = 7'b0001000;   //A
		4'hB : data_out = 7'b0000011;	  //B
		4'hC : data_out = 7'b1000110;   //C
		4'hD : data_out = 7'b0100001;   //D
		4'hE : data_out = 7'b0000110;   //E
		4'hF : data_out = 7'b0001110;   //F
		default : data_out = 7'b0111111;
		
	endcase
endmodule