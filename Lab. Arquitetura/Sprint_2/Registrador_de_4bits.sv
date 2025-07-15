// Testbench para o Registrador de 4bits - Entradas manuais 
module Registrador_de_4bits_TB; 
  // Implemente um registrador de 4bits com enable, reset assíncrono, entrada paralela e saída paralela.  
  // Sinais 
  reg [3:0] entrada; 
  reg clk, reset, enable;
  wire [3:0] saida; 
   
  // Instância do Registrador de 4bits
  Registrador_de_4bits tes(.in(entrada), .clk(clk), .reset(reset), .enable(enable), .out(saida)); 
  
  initial 
    begin 
      //Salva os sinais do TB em um arquivo .vcd 
      $dumpfile("test_Registrador.vcd"); $dumpvars(1, Registrador_de_4bits_TB); 
       
      //Monitora os sinais de entrada e saída 
      $monitor("time=%3d, Entrada=%d, Clock=%d, Reset=%b, Enable=%b, Saida=%d", $time,entrada,clk,reset,enable,saida); 
       
      //Geração dos sinais de entra (estímulos)
      clk = 0; reset = 1;
      #1;
      reset = 0;
      #1
      reset = 1; entrada = 4'd1; enable = 1;
      #8
      reset = 1; entrada = 4'd2; enable = 0;
      #10
      reset = 1; entrada = 4'd3; enable = 1;
      #10
      reset = 1; entrada = 4'd4; enable = 0;
      #10 
      reset = 1; entrada = 4'd5; enable = 1;
      #10
      reset = 1; entrada = 4'd6; enable = 0;
      #10
      reset = 1; entrada = 4'd7; enable = 1;
      #10
      
      $display("Programa finalizado com sucesso..."); 
      $finish();
    end  
  
  always
    begin
      // Alterando os valores de clock a cada 5 segundos para alterar os valores de teste
      #5;
      clk = ~clk;
    end
  
endmodule