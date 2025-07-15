// Testbench para o Somador ULA de 4 bits - Entradas manuais 
module Soamdor_ULA_4bits_TB; 
  // Modifique seu somador para possibilitar a execução de 4 operações (ULA): Soma, Subtração, deslocamento para direita e para esquerda. 
  // Sinais 
  logic [3:0] Values_A, Values_B; 
  logic [1:0] selecao;
  logic overflow;
  logic [3:0] Resultado; 
   
  // Instância do Somador ULA de 4 bits 
  Somador_ULA_4bits tes(.A(Values_A), .B(Values_B), .sel(selecao), .res(Resultado), .overflow(overflow)); 
  
  initial 
    begin 
      //Salva os sinais do TB em um arquivo .vcd 
      $dumpfile("test_Somador.vcd"); $dumpvars(1, Soamdor_ULA_4bits_TB); 
       
      //Monitora os sinais de entrada e saída 
      $monitor("time=%3d, Values A=%d, Values B=%d, selecao=%b, Resultado=%b, overflow=%d", $time,Values_A,Values_B,selecao,Resultado, overflow); 
       
      //Geração dos sinais de entra (estímulos) 
      Values_A=4'd5; Values_B=4'd4; selecao=2'b00;  // 5 + 4 = 9 -> saída 1001
      #10; 
      Values_A=4'd9; Values_B=4'h8; selecao=2'b00; // 9 + 8 = 17 -> saída 0001
      #10; 
      Values_A=4'd10; Values_B=4'd3; selecao=2'b01; // 10 - 3 = 7 -> saída 0111
      #10; 
      Values_A=4'd3; Values_B=4'ha; selecao=2'b01; // 3 - 10 = -7 -> saída 1001
      #10; 
      Values_A=4'hc; Values_B=4'h1; selecao=2'b10; // 12 / 2^1 = 6 -> saída 0110
      #10; 
      Values_A=4'hf; Values_B=4'h3; selecao=2'b10; // 15 / 2^3 = 1 -> saída 0001
      #10; 
      Values_A=4'd3; Values_B=4'd2; selecao=2'b11; // 3 * 2^2 = 12 -> saída 1100
      #10; 
      Values_A=4'd6; Values_B=4'd2; selecao=2'b11; // 6 * 2^2 = 24 -> saída 1000
      #10
      $display("Programa finalizado com sucesso..."); 
    end  
endmodule