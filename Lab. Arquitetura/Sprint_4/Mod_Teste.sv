`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
logic [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------

// ------------------------------------------------------------------------------
// O decodificador deve possuir uma entrada de 4bits, para entrar um número de 4’h0 até 4’hF
// e uma saída de 7bits para conectar um display de 7 segmentos e poder visualizar o dígito.

//Resgate o registrador de 4bits já implementado e validado da Sprint 2 e 
//inclua um decodificador de hexa-7seg para visualizar sua saída. 

	 // Precisa instanciar uma saida de 32bits visto que o LCD só tem 8 bits.
	 wire [31:0] out_rd1, out_rd2;
 
	 // Instância do banco com 32 registradores de 32 bits.
    RegisterFile RF(
		 .clk(~KEY[1]), .reset(KEY[2]), .we3(SW[17]), 
		 .wd3(SW[7:0]),
		 .ra2(SW[10:8]),
		 .ra1(SW[13:11]),
		 .wa3(SW[16:14]),
		 .rd1(out_rd1),
		 .rd2(out_rd2));
		 
	 // Instância do Registrador de 4bits
	 seg_7_Digitos Hexa_7Seg_1(.in_bits(SW[3:0]), .out_display(HEX0[6:0]));
	 seg_7_Digitos Hexa_7Seg_2(.in_bits(SW[7:4]), .out_display(HEX1[6:0]));
	 
	 // Usando um led para indicar que o clock está ativo
	 assign LEDG[8] = ~KEY[1];
	 assign LEDG[1] = KEY[2];
	 // Relacionando as saída rd1 e rd2 com os displays do LCD
	 assign w_d0x0 = out_rd1[7:0];
	 assign w_d0x1 = out_rd2[7:0];

endmodule