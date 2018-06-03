/*
	-Sequência de pelo menos 5 bits 0 em VPPM: 00000;
	para detecção da frequência.
	-Inicio dos dados após bit 0:  0 101010101010
											 ^ ^          ^	
											 | |   dados  |
											 |
									   sincronia
	-Demodula infinitamente apos isto
	-Devo adicionar reset.
*/

module Mainn

#(
   parameter NBITS = 12 
)
(
	input  clk,
	input bitRead

);

parameter clockFreq = 32'd200000000;

wire [NBITS-1:0] inCount;
wire inputRead;
wire clk_50, iCLK, iCLK_n, clk_200; 
wire clk_defFreq;
wire dataRead;
wire [31:0] freqCalculada;
wire [31:0] CountValueParam;

//PLL----------------------------------------------------------------------------------------
PLL32 PLL(clk, clk_50, iCLK, iCLK_n, clk_200);
//-------------------------------------------------------------------------------------------

//PARA SIMULAÇÃO---------------------------------------------------------------------------------
//Variador de Frequencia do Sinal de Entrada-------------------------------------------------------------

freqVar variadorDeFreq(inputRead, CountValueParam);
//-----------------------------------------------------------------------------------------------


//Astavel (Parameter = 200MHz/(Freq*2) - 2)(Inicio 1MHz)------------------------------------------------------
astavel Astavel(clk_200, CountValueParam, clk_defFreq);

//-------------------------------------------------------------------------------------------
//Counter------------------------------------------------------------------------------------
Counter #(NBITS)contador(clk_defFreq, inCount);

//-------------------------------------------------------------------------------------------
//Input(Gera sinal com freq = Astavel)--------------------------------------------------------------------
Input #(NBITS)Input(inCount, inputRead);
//-------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------


//Detectar Frequência--------------------------------------------------------------------------
freqDetect freqDetector1(clk_200, inputRead, freqCalculada);

//-------------------------------------------------------------------------------------

endmodule


