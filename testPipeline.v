`timescale 1ns / 1ps
`include "main.v"
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   11:05:39 11/21/2017
// Design Name:   main
// Module Name:   C:/Users/Setsuna/Documents/XilinxWork/pipeline/testPipeline.v
// Project Name:  pipeline
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module testPipeline;

	// Inputs
	//reg [31:0] t;
	reg clk;
	reg reset;
	reg clock;
	reg [4:0] test;
	// Outputs
	wire a,b,c,d,e,f,g;
	wire [3:0] A;
	// Instantiate the Unit Under Test (UUT)
	main uut (
		clk,reset,
		a,b,c,d,e,f,g,A,clock,test
	);

	initial begin
		$display("---------------------------------------------------------------");
		$display("              Pipeline MIPS AProcessor Simulation              ");
		$display("---------------------------------------------------------------");
	end
	always begin
		#10 clk = ~clk;
		if (~clk) begin
		// $display("Time: %d, clock = %d, PC = %h", t, clk, PC_out);
		// $display("InsPC: %h, InsID = %h, InsEX = %h, ALUResult = %h", InsPC, InsID, InsEX, ALUResult);
		// $display("ALUin1: %h, ALUin2 = %h,ALUop = %b", ALUin1, ALUin2,ALUOpID);
		// $display("forwardA: %h, forwardB = %h", forwardA, forwardB);
		// $display("RegWriteID: %d, RegWriteex: %d, RegWriteMEM: %d,RegWriteWB: %d", RegWriteID, RegWriteEX, RegWriteMEM, RegWriteWB);
		// $display("WriteRegister: %h, WriteData: %h", WriteRegister, WriteData);
		// $display("ReadDataWB=%h,ResultWB=%h",ReadDataWB,ResultWB);
		// $display("AddressMEM=%h",AddressMEM);
		// $display("AddressSelect=%b",AddressSelect);
		// $display("[$s0] = %h, [$s1] = %h, [$s2] = %h", rs0,rs1,rs2);
		// $display("[$s3] = %h, [$s4] = %h, [$s5] = %h", rs3,rs4,rs5);
		// $display("[$s6] = %h, [$s7] = %h, [$t0] = %h", rs6,rs7,rt0);
		// $display("[$t1] = %h, [$t2] = %h, [$t3] = %h", rt1,rt2,rt3);
		// $display("[$t4] = %h, [$t5] = %h, [$t6] = %h", rt4,rt5,rt6);
		// $display("[$t7] = %h, [$t8] = %h, [$t9] = %h", rt7,rt8,rt9);
		//$display("Branch=%h",test);
		end
	end
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		test = 0;
		clock = 0;
		// Add stimulus here
		#3000 $stop;
	end
   always begin
		#20 test = test+1;
	end

	initial begin
	  $dumpfile("test.vcd");
    $dumpvars(1, uut);
  end

endmodule
