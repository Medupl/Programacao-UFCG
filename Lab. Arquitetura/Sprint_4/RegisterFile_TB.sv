// Criando nosso Testbech do banco com 32 registradores de 32 bits.

module RegisterFile_TB;

	 reg clk, reset, we3;
	 reg [4:0]  wa3, ra1, ra2;
	 reg [31:0] wd3;
	wire [31:0] rd1, rd2;

	 // Instância do banco de registradores de 32bits
	 RegisterFile RF(
		 .clk(clk), .reset(reset), .we3(we3), 
		 .wd3(wd3),
		 .ra2(ra2),
		 .ra1(ra1),
		 .wa3(wa3),
		 .rd1(rd1),
		 .rd2(rd2));
		 
	 always
	 	// Alterando os valores de clock a cada 5 segundos para alterar os valores de teste
	   begin
		  #5;
		  clk = ~clk;
		end
		
    initial
	   begin
		// Iniciando a  simulação exaustiva das operações de escrita e leitura em cada um dos registradores do banco
		// Geração de sinais.
		clk = 0; reset = 1; we3 = 1; ra1 = 0; ra2=0; wa3 = 0;
		#1;
		reset = 0; wd3  = 32'h21FB8251;
		#1;
		reset = 1;
		#2;
		
		//Teste de escrita e leitura para todos os registradore
		// Iniciando de 1 porque o zero é so leitura
		for (integer cont = 1;  cont < 32; cont = cont + 1)
	     begin
		    // Escrita nos registradores
		    we3 = 1;
			 wa3 = cont;
			 wd3 = 32'h21FB8251 + cont;
			 
			 // Leitura dos registradores
			 #2;
			 we3 = 0;
			 ra1 = cont;
			 
			 // Verificando o funcionamento
			 #1;
			 if (rd1 === wd3)
			     ra2 = cont - 1;
			 else 
			     ra2 = 0;  
			 #7;	  
				  
		  end 
		  
		  // Testando o registrador $0
		  #10;
		  we3 = 1;
		  wa3 = 0;
		  wd3 = 32'hF;
		  #2;
		  we3 = 0;
		  ra1 = 0;
		  #1;
		  if (rd1 === 32'h0)
		      ra2 = 0;
		  else
				ra2 = 31;
		  
		  // Ativando o reset
		  #9;
		  reset = 0;
		  #30;
		
		end

endmodule