module freqDetect
(
	input clk,
	input signalIn,	
	output reg [31:0] frequency
);

parameter clockFreq = 32'd200000000;

reg startCountFlag;


reg [31:0] freqCount;
reg freqIsSet;
reg freqCalcComplete;
reg isFirstClock;


initial begin
startCountFlag = 1'b0;
freqIsSet = 1'b0;
freqCount = 32'd0;
freqCalcComplete = 1'b0;
isFirstClock = 1'b1;
end

always @ (posedge signalIn) begin
if(isFirstClock) begin
startCountFlag <= 1'b1;
freqIsSet <= 1'b0;
isFirstClock <= 1'b0;
end
else begin
startCountFlag <= 1'b0;
freqIsSet <= 1'b1;
isFirstClock <= 1'b1;
end
end

always @ (posedge clk) begin
if(startCountFlag) begin
freqCount <= freqCount + 1'b1;
end
else if (frequency != 32'd0)
freqCount <= 32'd0;
end

always @ (posedge clk) begin
if(freqIsSet && freqCalcComplete) begin
frequency <= 2*clockFreq/freqCount;
freqCalcComplete <= 1'b0;
end
else if (!freqIsSet)
freqCalcComplete <= 1'b1;
end

endmodule