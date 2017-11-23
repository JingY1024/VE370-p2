`ifndef _forward
`define _forward
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:39:05 11/17/2017
// Design Name:
// Module Name:    Forward
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
module Forward(EXMEM_RegWrite, MEMWB_RegWrite,
		EXMEMRd, MEMWBRd, IDEXRs, IDEXRt, ForwardA, ForwardB
);
	input EXMEM_RegWrite, MEMWB_RegWrite;
	input [4:0] EXMEMRd;
	input [4:0] MEMWBRd;
	input [4:0] IDEXRs;
	input [4:0] IDEXRt;

	output reg [1:0] ForwardA, ForwardB;

	initial begin
		ForwardA <= 2'b00;
		ForwardB <= 2'b00;
	end

	always @(*) begin
		if (EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDEXRs) begin
			ForwardA <= 2'b01;
		end
		else if (MEMWB_RegWrite && MEMWBRd != 0 && MEMWBRd == IDEXRs && (~(EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDEXRs)) ) begin
			ForwardA <= 2'b10;
		end
		else begin
			ForwardA <= 2'b00;
		end
	end

	always @(*) begin
		if (EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDEXRt) begin
			ForwardB <= 2'b01;
		end
		else if (MEMWB_RegWrite && MEMWBRd != 0 && MEMWBRd == IDEXRt && (~(EXMEM_RegWrite && EXMEMRd != 0 && EXMEMRd == IDEXRt)) ) begin
			ForwardB <= 2'b10;
		end
		else begin
			ForwardB <= 2'b00;
		end
	end

endmodule
`endif
