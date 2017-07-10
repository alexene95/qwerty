module ps2new(
				input ck,
				input reset,
				input scl,
				input sda,
				output  reg [7:0] data_out,
				output  reg data_valid
				);

			reg [10:0] frame;
			reg [3:0] cnt_2;
			reg parity;
			
assign parity_test=~(frame[10] ^ frame[8] ^ frame[7] ^ frame[6] ^ frame[5] ^ frame[4] ^  frame[3]	^ frame[2] ^ frame[1] ^  frame[0]);  
			
		
	
	
			
always @ (negedge scl)

	if (~reset )
cnt_2=0;

	else if (cnt_2==4'b1011)   			//counter for the 11 b frame  1-11
cnt_2=0;

	else 
cnt_2= cnt_2+1;


always @ (negedge scl)

	if (parity==1 && cnt_2==4'b0001 )
frame[0] <= sda;

	else frame <= 0;
always @ (negedge scl)

case (cnt_2)
4'b0010:begin frame[1]=sda;
 data_out[0]=frame[1];
 end
4'b0011:begin frame[2]=sda;
 data_out[1]=frame[2];end
4'b0100:begin frame[3]=sda;
 data_out[2]=frame[3];end
4'b0101:begin frame[4]=sda;
 data_out[3]=frame[4];end
4'b0110:begin frame[5]=sda;
 data_out[4]=frame[5];end
4'b0111:begin frame[6]=sda;
 data_out[5]=frame[6];end
4'b1000:begin frame[7]=sda;
 data_out[6]=frame[7];end
4'b1001:begin frame[8]=sda;
data_out[7]=frame[8];end
default frame <=0;
endcase



 

always @ ( posedge ck )

	if (parity_test&frame[9])
 parity <= 1;

	else
 parity <= 0;
    




endmodule 