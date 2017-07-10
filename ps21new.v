module ps2new(
				input ck,
				input reset,
				input scl,
				input sda,
				output  [7:0] data_out,
				output  reg data_valid
				);

			reg [10:0] frame;
			reg [3:0] cnt_2;
			wire parity_test;
			
assign parity_test=frame[10] ^ frame[8] ^ frame[7] ^ frame[6] ^ frame[5] ^ frame[4] ^  frame[3]	^ frame[2] ^ frame[1] ^  frame[0];  
			
		
	
	 
			
always @ (negedge scl)

	if (~reset )
cnt_2=0;

	else if (cnt_2==4'b1010)   			//counter for the 11 b frame  1-11
cnt_2=0;

	else 
cnt_2= cnt_2+1;


always @ (negedge scl)

case (cnt_2)
4'd0: frame[0] <=sda;
4'd1: frame[1] <= sda;
4'd2: frame[2] <= sda;
4'd3: frame[3] <= sda;
4'd4: frame[4] <= sda;
4'd5: frame[5] <= sda;
4'd6: frame[6] <= sda;
4'd7: frame[7]<= sda;
4'd8: frame[8] <= sda;
4'd9: frame[9] <= sda;
4'd10: frame[10] <=sda;

default: frame[8:1] <=0;
endcase
//
//always @(negedge scl)
//
//if ( cnt_2==4'b1011 && parity==1 && frame[0]==0)
//data_out <= frame[8:1];
//else 
//data_out <= 8'b00000000;

assign data_out = frame[8:1];
 

always @ ( posedge ck )

	if (parity_test&frame[9])
 data_valid <= 1;

	else
 data_valid <= 0;
    




endmodule 