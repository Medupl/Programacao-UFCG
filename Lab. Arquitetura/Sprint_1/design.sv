// Porta XOR 2x1 
module XOR2x1 (input wire in0, in1, output wire out); 
   assign out = in0 ^ in1;			//out = (in0 & ~in1) | (~in0 & in1) 
endmodule 

// Somador de 4 bits 
module Somador_4bits (
  input logic [3:0]a, b, 			//Entrada de 4 bits
  output [3:0]res					//Resultado em 4 bits
); 
   assign res = a + b; 				//Realiza a soma 
endmodule 

// MUX 2x1 de 4 bits 
module MUX_2x1_4bits (
  input logic [3:0]i0, i1, 			//Entradas de 4 bits
  input logic sel,					//Sinal de seleção
  output [3:0]out					//Saída em 4 bits
); 
   assign out = sel ? i1 : i0; 		//Seleção das entradas 
endmodule 

// Somador com Mux
module Somador_MUX_2x1_4bits(
  input logic [3:0] Ia, Ib, Ic, 
  output [3:0] Out_Sum, 
  input logic select
);
  // Sinal interno, ligação entre Mux e Somador
  logic [3:0] Out_Mux;
  
  MUX_2x1_4bits mux(.i0(Ib), .i1(Ic), .sel(select), .out(Out_Mux)); 
  Somador_4bits sum(.a(Ia), .b(Out_Mux), .res(Out_Sum));
 
endmodule

// Somador ULA de 4 bits 
module Somador_ULA_4bits (
  input logic [3:0] A, B, 				//Entrada de 4 bits
  input logic [1:0] sel,				// chave seleção
  output logic[3:0] res,				//Resultado em 4 bits
  output logic overflow
); 
   // Variável interna para a soma de 5 bits
  logic [4:0] op;
  // Casos com overflow acontecem quando não a bits suficientes para representar as operações solicitadas pelo desafio
  	always_comb 
    begin
      case(sel)
        2'b00: 
          begin
            // Acrescentando o bit zero a um bit mais significativo 
            op = {1'b0, A} + {1'b0, B};
            res = op[3:0];
            // Caso tenha overflow netornará o bit 1'b01
            overflow = op[4];
          end
        
        2'b01:
          begin
            res = A - B;
            // Se o valor de B for maior sempre existirá um emprestimo na parte final dos cálculos
            overflow = (A < B) ? 1'b1 : 1'b0;
          end
        
        2'b10:
          begin
            // Deslocar a direita é o mesmo que dividir A por (2^B)
            // O resulta é a divisão por inteiros, sem contar com o resto
            res = A >> B;
            // Por ser uma divisão, não há overflow neste contexto
            overflow = 1'b0;
          end
        
        2'b11:
          begin
            // Deslocar a esquerda é o mesmo que multiplicar A por (2^B)
            // Para teste da função trabalharemos com valor de B baixo
            op = {4'b0, A} << {4'b0, B};
            res = op[3:0];
            // Faremos um teste com 8 bits, se os 4 bits mais significativo for diferente de zero ocorreu overflow
            overflow = (op[7:4] !== 4'b0) ? 1'b1 : 1'b0;
          end
        
        default: begin
        // Valores para algum caso acima der problemas
        	res = 4'bxxxx;
        	overflow = 1'bx;
      	end
      endcase
    end
endmodule