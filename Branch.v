`ifndef _branch
`define _branch
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:25:38 11/15/2017
// Design Name:
// Module Name:    Branch
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
module Branch(data_1, data_2, op, if_jump, AddressSelect, IFID_flush);

	input [31:0] data_1;
	input [31:0] data_2;
	input if_jump;
	input [5:0] op;
	output reg [1:0] AddressSelect;
	output reg IFID_flush;

	initial begin
		AddressSelect <= 2'b00;
		IFID_flush <= 1'b0;

	end

	always @(data_1 or data_2 or op or if_jump) begin
		if (if_jump) begin
			AddressSelect <= 2'b10;
			IFID_flush <= 1'b1;
		end
		else if ( ( (op == 6'b000100) && (data_1 == data_2) ) || ( (op == 6'b000101) && (data_1 != data_2) ) ) begin
			AddressSelect <= 2'b01;
			IFID_flush <= 1'b1;
		end
		else begin
			AddressSelect <= 2'b00;
			IFID_flush <= 1'b0;
		end
	end


endmodule

`endif
