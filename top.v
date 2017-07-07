module top(
				input FPGA_clock,
				input rst,
				input PS2_sclk,
				input PS2_data,
				output DATA_VALID,
				output [6:0] trans
		);
		wire [7:0] data_out;
		
			ps21 keyboard(.ck(FPGA_clock),
							.reset(rst),
							.scl(PS2_sclk),
							.sda(PS2_data),
							.data_valid(DATA_VALID),
							.data_out(data_out));
							transcodor inst_1(.data_in(data_in),.data_out(trans));	
		
		
		endmodule