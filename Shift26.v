`ifndef _s26
`define _s26
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:51:56 11/16/2017
// Design Name:
// Module Name:    Shift26
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
module Shift26(in, out);

	input [25:0] in;
	output [27:0] out;

	assign out = in << 2;

endmodule
`endif
