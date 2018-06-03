module freqVar 
(
	input signalIn,
	output reg [31:0]countValueParam

);

reg countUpOrDown;
reg countEnab;
reg [2:0]countAux;

initial begin
countValueParam = 25'd98;
countUpOrDown = 1'b1;
countEnab <= 1'b0;
countAux <= 3'd0;
end

always @ (posedge signalIn) begin
if(countUpOrDown && countEnab)
countValueParam = countValueParam + 25'd1;
else if (!countUpOrDown && countEnab)
countValueParam = countValueParam - 25'd1;
end

always @ (posedge signalIn) begin
if(countValueParam == 25'd98) begin
countUpOrDown <= 1'b1;
end
else if (countValueParam == 25'd99) begin
countUpOrDown <= 1'b0;
end
end

always @ (posedge signalIn) begin
if (countAux >= 3'd1) begin
countAux<= 3'd0;
countEnab <= 1'b1;
end
else begin
countAux <= countAux + 3'd1;
countEnab <= 1'b0;
end
end

endmodule