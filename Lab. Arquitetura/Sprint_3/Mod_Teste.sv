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

//---------- modifique a partir daqui --------

// ------------------------------------------------------------------------------
// O decodificador deve possuir uma entrada de 4bits, para entrar um número de 4’h0 até 4’hF
// e uma saída de 7bits para conectar um display de 7 segmentos e poder visualizar o dígito.

//Resgate o registrador de 4bits já implementado e validado da Sprint 2 e 
//inclua um decodificador de hexa-7seg para visualizar sua saída. 

//	 wire [3:0] out_register;
 
	 // Instância do Registrador de 4bits
//    Registrador_de_4bits tes(.in(SW[11:8]), .clk(SW[2]), .reset(SW[0]), .enable(SW[1]), .out(out_register));
	 // Instância do Registrador de 4bits
//	 seg_7_Digitos Hexa_7Seg(.in_bits(out_register), .out_display(HEX0[6:0]));

endmodule