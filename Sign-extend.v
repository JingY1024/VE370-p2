`ifndef _se
`define _se
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:59:45 11/11/2017
// Design Name:
// Module Name:    SignExtend
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

module SignExtend(Instruction, extended_sign);

	input [15:0] Instruction;
	output [31:0] extended_sign;
	assign extended_sign=$signed(Instruction);

endmodule
`endif
