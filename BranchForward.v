`ifndef _branch_forward
`define _branch_forward
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:28:47 11/20/2017
// Design Name:
// Module Name:    BranchForward
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
module BranchForward(EXMEM_RegWrite, MEMWB_RegWrite,
		EXMEMRd, MEMWBRd, IDRs, IDRt, ForwardA, ForwardB
);
	input EXMEM_RegWrite, MEMWB_RegWrite;
	input [4:0] EXMEMRd;
	input [4:0] MEMWBRd;
	input [4:0] IDRs;
	input [4:0] IDRt;

	output reg [1:0] ForwardA, ForwardB;

	always @(EXMEM_RegWrite, MEMWB_RegWrite) begin
		if (EXMEM_RegWrite && (EXMEMRd != 0) && EXMEMRd == IDRs) begin
			ForwardA <= 2'b10;
			ForwardB <= 2'b00;
		end
		else if (EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDRt) begin
			ForwardA <= 2'b00;
			ForwardB <= 2'b10;
		end
		else if (MEMWB_RegWrite && MEMWBRd != 0 && MEMWBRd == IDRs && (~(EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDRs)) ) begin
			ForwardA <= 2'b10;
			ForwardB <= 2'b00;
		end
		else if (MEMWB_RegWrite && MEMWBRd != 0 && MEMWBRd == IDRt && (~(EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDRt)) ) begin
			ForwardA <= 2'b00;
			ForwardB <= 2'b10;
		end
		else begin
			ForwardA <= 2'b00;
			ForwardB <= 2'b00;
		end
	end

endmodule
`endif
