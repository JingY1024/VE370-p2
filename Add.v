`ifndef _add
`define _add
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:15:03 11/15/2017
// Design Name:
// Module Name:    Add
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
module Add(in1, in2, out);
	input [31:0] in1;
	input [31:0] in2;
	output [31:0] out;

	assign out = in1 + in2;

endmodule
`endif
