`ifndef _pc
`define _pc
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:04:01 11/16/2017
// Design Name:
// Module Name:    PC
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module PC(clk, ins_in, PC_hold, ins_out);

	input clk;
	input [31:0] ins_in;
	input PC_hold;
	output reg [31:0] ins_out;

	initial begin
		ins_out <= 32'b0;
	end

	always @ (posedge clk) begin
		if (PC_hold == 1'b0) begin
			ins_out <= ins_in;
		end
	end

endmodule
`endif
