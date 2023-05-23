module top(
				input FPGA_clock,
				input rst,
				input PS2_sclk,
				input PS2_data,
				output DATA_VALID,
				output [6:0] trans,
				output [6:0] trans_2
		);
		wire [7:0] data_out;
		//this line will not worl
		hhhh
			ps2new keyboard(.ck(FPGA_clock),
							.reset(rst),
							.scl(PS2_sclk),
							.sda(PS2_data),
							.data_valid(DATA_VALID),
							.data_out(data_out));
							transcodor inst_1(.data_in(data_out[3:0]),.data_out(trans));	
		transcodor inst_2(.data_in(data_out[7:4]),.data_out(trans_2));	
		
		endmodule
