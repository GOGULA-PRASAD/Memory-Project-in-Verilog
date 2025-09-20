`include"memory.v"
module tb;
	parameter WIDTH=8;
	parameter DEPTH=32;
	parameter ADDR_WIDTH=$clog2(DEPTH);
	reg clk,res,wr_rd,valid;
	reg [WIDTH-1:0]wdata;
	reg [ADDR_WIDTH-1:0]addr;
	wire [WIDTH-1:0]rdata;
	wire ready;
	integer i;
	memory dut(clk,res,wr_rd,addr,wdata,rdata,valid,ready);
	always #5 clk=~clk;
	initial begin
		clk=0;
		res=1;
		wr_rd=0;
		addr=0;
		wdata=0;
		valid=0;
		repeat(2) @(posedge clk);
		res=0;
		for(i=0;i<DEPTH;i=i+1) begin	
			@(posedge clk);
			wr_rd=1;
			addr=i;
			wdata=$random;
			valid=1;
			wait(ready==1);
		end
		@(posedge clk);
		wr_rd=0;
		addr=0;
		wdata=0;
		valid=0;
		// reads
		for(i=0;i<DEPTH;i=i+1) begin
			@(posedge clk);
			wr_rd=0;
			addr=i;
			valid=1;
			wait(ready==1);
		end
		@(posedge clk);
		wr_rd=0;
		addr=0;
		valid=0;
		#100;
		$finish;
	end
endmodule


