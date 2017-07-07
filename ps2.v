module ps2(
				input ck,
				input reset,
				input scl,
				input sda,
				output  reg [7:0] data_out,
				output  reg data_valid
				);
				
//parameter idle=2'b01;
//parameter write=2'b11;

reg [1:0] full;
reg [1:0] state;
wire  parity_test;
reg [3:0]cnt_2;
reg [1:0]parity_stop;
reg parity;


assign parity_test=data_out[7] ^ data_out[6] ^ data_out[5] ^ data_out[4] ^ data_out[3] ^ data_out[2] ^ data_out[1] ^  data_out[0];  
 
always @ (negedge scl)
if (~reset )
cnt_2=0;
else if (cnt_2==4'b1100)   			//counter for the 11 b frame  1-12
cnt_2=0;
else 
cnt_2= cnt_2+1;





always @ (negedge scl )
if (cnt_2==4'b0001 && data_valid==1)
		full[0] = sda;
 
 else if (cnt_2==4'b0010 && full[0]==0 && data_valid==1)
data_out[cnt_2 -2] <= sda;

else if (cnt_2==4'b1010 && data_valid==1)
data_out[7] <= sda;

else if (cnt_2==4'b1011 && data_valid==1)
parity=sda;

else if (cnt_2==4'b1100 && data_valid==1)
full[1]=sda;
 
 else data_valid=0;











endmodule 





////always @(negedge scl)
////if (cnt_2==4'b0010 )  //  writing the 8 b of info
////data_out[cnt_2 -2]=sda
////else if (cnt_2==4'b1001 )
////data_out[7]=sda;
////else if (cnt_2==4'b1010 )        
////parity=sda;
////else ///////////////////////
//
//
//
//
//always @ (negedge scl )
//if (cnt_2==4'b0001 && sda==0)
// data_out[cnt_2 -1] <= sda;
// else if (cnt_2==4'b1001 )
//data_out[7] <= sda;
//else 
//
//
// 
// 
// always @ (negedge scl)
// full[cnt_2] <= sda;
// if (full[1]
//


