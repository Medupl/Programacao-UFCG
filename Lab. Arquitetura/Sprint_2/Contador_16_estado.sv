// Testbench para o  Registrador da Soma do Mux 4bits - Entradas manuais 
module Contador_16_estado_TB; 
  // Implemente um registrador de 4bits com enable, reset assíncrono, entrada paralela e saída paralela.  
  // Sinais 
  reg  select, clk, reset, enable;
  wire [3:0] saida; 
  
   
  // Instância do Registrador de 4bits
  Contador_16_estado cont16(.sel_c16(select), .clock(clk), .reset(reset), .enable(enable), .out_counter(saida)); 
  
    initial 
      begin 
      
        //Salva os sinais do TB em um arquivo .vcd 
        $dumpfile("test_Contador_16.vcd"); $dumpvars(1, Contador_16_estado_TB); 

        $monitor("Tempo=%0t # Reset=%b, Enable=%b, select=%b | Saida=%h",
                   $time, reset, enable, select, saida);

        //Geração dos sinais de entra (estímulos)
        clk = 0; reset = 1; enable = 0; select = 0;
        #1;
        reset = 1'b0;					// Ativa o reset para zerar o registrador
        #2; 
        reset = 1'b1; 					// Desativa o reset para realizar os testes
        #7;

        $display("\n	- Contagem Crescente -	");
        // Habilita gravar no registrador e Seleciona formato crescente
        enable = 1'b1; select = 1'b1; 					
        #70; 							// Contagem de 0 a 7

        $display("\n	- Enable Ativo -	");
        enable = 1'b0; 					// Desabilita a gravação
        reset =  1'b0;					// Zera novamente o contador
        #25; 							// Espera 2 ciclos

        // 4. Cenário: Contagem Decrescente
        $display("\n	- Contagem decrescente -	");
        reset =  1'b1;					// Libera o contador para registro
        enable = 1'b1; 					// Habilita novamente a gravação
        select = 1'b0; 					// eleciona formato decrescente
        #90; 							// Contagem de F a 7
        
        $display("\n	- Enable Ativo -	");
        enable = 1'b0; 					// Desabilita a gravação
		#15
        
        $display("\nPrograma finalizado com sucesso...");
        $finish;
	  end  
  
    always
      begin
        // Alterando os valores de clock a cada 5 segundos para alterar os valores de teste
        #5;
        clk = ~clk;
      end
  
endmodule