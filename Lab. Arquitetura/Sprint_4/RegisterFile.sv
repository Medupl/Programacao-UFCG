// Banco com 32 registradores de 32 bits.
module  RegisterFile (
    input  wire clk, reset, we3,									// Clock, Reset e Write Enable - 1 bits - Habilita gravação
	 input  wire [31:0] wd3,										// Write Data - 32 bits - Entrada de dados, informação a ser registrada
	 input  wire [4:0]  wa3,										// Write Address - 5 bits - Seleção do registrador que receberá a informação
	 input  wire [4:0]  ra1, ra2,								   // Register Address - 5 bits - Seleção de qual registrador será mostrado
	 output wire [31:0] rd1, rd2,									// Register Data - 32 bits - Barramento de saída, informação será exibida
	 output wire [31:0] x0, x1, x2, x3, x4, x5, x6, x7		//8 saídas auxiliares para visualizar externamente 
);

	 // Criando nosso banco com 32 registradores de 32 bits. Comparando a uma array 32x32
	 reg [31:0] registers [31:0];
	 
	 // A solução do problema será implementada usando alto nível, para ganhar produtividade e eficiência.
    // As alterações serão realizadas caso tenha subida de clock ou descida de reset
	 always @(posedge clk, negedge reset)
	 begin
      if (!reset)
        // Neste caso o reset tem a prioridade maxima e zera todos registrador se houver descida do pulso
        registers <= '{default: 32'b0};						// Forma simples de zerar todos os registradores, usando atribuição de agregado.
		
		// Essa parte do laço é o ponto principal, pois ao informarmos o endereço do registrador que queremos gravar a informação,
		// o Quartus instantaneamente decodifica esse endereço, se wa3 = 011 -> 00011 ele já sabe que queremos acessar o registrador $3.
      else if (we3 && (wa3 != 5'b0))
        registers[wa3] <= wd3;
		  
     end
	  
	  // Para criarmos um circuito combinacional e resolver a situação de usar os Mux 32x1, isso pode ser feito diretamente usando assign
	  // Internamente o Quartus entende que se trata de uma solução Mux 32x1, resolvendo de forma automatica
	  assign rd1 = registers[ra1];
	  assign rd2 = registers[ra2];
	  
	  assign x0 = registers[0][7:0];
	  assign x1 = registers[1][7:0];
	  assign x2 = registers[2][7:0];
	  assign x3 = registers[3][7:0];
	  assign x4 = registers[4][7:0];
	  assign x5 = registers[5][7:0];
	  assign x6 = registers[6][7:0];
	  assign x7 = registers[7][7:0];
	  
endmodule