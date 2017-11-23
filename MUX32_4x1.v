`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:36 11/16/2017 
// Design Name: 
// Module Name:    MUX32_4x1 
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
module MUX32_4x1(in1, in2, in3, in4, select, out);

	input [31:0] in1;
	input [31:0] in2;
	input [31:0] in3;
	input [31:0] in4;
	input [1:0] select;
	
	output reg [31:0] out;

	initial begin 
		out <= 32'b0;
	end
	
	always @(*) begin
		if (select == 2'b00) begin
			out <= in1;
		end
		else if (select == 2'b01) begin
			out <= in2;
		end
		else if (select == 2'b10) begin
			out <= in3;
		end
		else if (select == 2'b11) begin
			out <= in4;
		end
		
	end
endmodule
