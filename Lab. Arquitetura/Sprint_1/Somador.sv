// Testbench para o Somador de 4 bits - Entradas manuais 
module Soamdor_4bits_TB; 
  // Implemente um módulo somador de 4bits, sem entrada de carry-in, nem saída de carry-out.
  // Sinais 
  logic [3:0]Ia, Ib; 
  logic [3:0]Out; 
   
  // Instância do Somador de 4 bits 
  Somador_4bits tes(.a(Ia), .b(Ib), .res(Out)); 
  
  initial 
    begin 
      //Salva os sinais do TB em um arquivo .vcd 
      $dumpfile("test_Somador.vcd"); $dumpvars(1, Soamdor_4bits_TB); 
       
      //Monitora os sinais de entrada e saída 
      $monitor("time=%3d, Ia=%d, Ib=%d, Out=%b",$time,Ia,Ib,Out); 
       
      //Geração dos sinais de entra (estímulos) 
      Ia=4'd3; Ib=4'd7;  // 3 + 7 = 10 -> saída 1010
      #10; 
      Ia=4'd4; Ib=4'd3; // 4 + 3 = 7 -> saída 0111
      #10; 
      Ia=4'd1; Ib=4'd2; // 1 + 2 = 3 -> saída 0011
      #10; 
      Ia=4'd6; Ib=4'd6; // 6 + 6 = 12 -> saída 1100
      #10; 
      Ia=4'd9; Ib=4'h8; // 9 + 8 = 17 -> saída 0001
      #10;
      $display("Programa finalizado com sucesso..."); 
    end  
endmodule 