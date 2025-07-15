//  Registrador de 4bits
module  Registrador_de_4bits (
  input wire [3:0] in,
  input wire clk, reset, enable,
  output reg [3:0] out
);
  // As alterações serão realizadas caso tenha subida de clock ou descida de reset
  always @(posedge clk, negedge reset)
  	begin
      if (!reset)
        // Neste caso o reset tem a prioridade maxima e zera o registrador se houver descida do pulso
        out <= 0;
      else if (enable)
        out <= in;
      else 
        out <= out;
// Nesses últimos casos se o enable for ativo irá registrar a entrada senão permanece a ja registrada
    end
  
endmodule

// Somador de 4 bits 
module Somador_4bits (
  input wire [3:0]a, b, 			//Entrada de 4 bits
  output reg [3:0]res				//Resultado em 4 bits
); 
   assign res = a + b; 				//Realiza a soma 
endmodule 

// MUX 2x1 de 4 bits 
module MUX_2x1_4bits (
  input wire [3:0]i0, i1, 			//Entradas de 4 bits
  input wire sel,					//Sinal de seleção
  output reg [3:0]out				//Saída em 4 bits
); 
   assign out = sel ? i1 : i0; 		//Seleção das entradas 
endmodule 

// Registrador para Somador com Mux
module Registrador_Somador(
  input wire [3:0] ia, ib, ic, 
  output reg [3:0] saida,
  input wire select, clk, reset, enable
);
  // Sinal interno, ligação entre Mux e Somador
  wire [3:0] out_Mux, out_Sum;
  
  MUX_2x1_4bits mux(.i0(ib), .i1(ic), .sel(select), .out(out_Mux)); 
  Somador_4bits sum(.a(ia), .b(out_Mux), .res(out_Sum));
  Registrador_de_4bits tes(.in(out_Sum), .clk(clk), .reset(reset), .enable(enable), .out(saida)); 
 
endmodule

//módulo contador de 16 estados.
module Contador_16_estado(
  // Entradas de Controle
	input wire clock,
    input wire reset,
    input wire enable,     			// Habilita a contagem a cada ciclo de clock
    input wire sel_c16,    			// 1 para contagem crescente, 0 para decrescente
    output reg [3:0] out_counter	// Saída do Contador
);
  
    // a saída do registrador (valor atual)
    wire [3:0] out_register;
  
  	Registrador_Somador RS(
      .ia(out_register),   			// Saída do registrador e entrada do somador
        .ib(4'b1111),        		// Valor para decrementar (-1)
        .ic(4'b0001),        		// Valor para incrementar (+1)
        .select(sel_c16),
        .saida(out_register),
        .clk(clock),
        .reset(reset),
        .enable(enable)
    );
    assign out_counter = out_register;
  
endmodule