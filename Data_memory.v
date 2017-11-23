`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:52 11/15/2017 
// Design Name: 
// Module Name:    Data_memory 
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
module Data_memory(clk,Address,Write_data,Read_data,MemWrite,MemRead);
	input clk;
	input [31:0] Address,Write_data;
	input MemWrite,MemRead;
	output[31:0] Read_data;
	
	reg [31:0] data[0:127];
	
	//Initialization 
	integer i;
	initial begin
		for (i=0;i<128;i=i+1)
			begin
				data[i]=32'b0;
			end
	end
	//lw
	assign Read_data=(MemRead)?data[Address]:32'b0;
	//sw
	always @(posedge clk)
		begin
			if(MemWrite==1)
				data[Address]<=Write_data;
		end
endmodule
