// Testbench do registrador para 7 segmentos. 
module register_7dig;

    reg  clk, reset, enable;
	 reg  [3:0] in;
	 wire [3:0] out_register;
	 wire [6:0] HEX0;
	 
	 // Instância do Registrador de 4bits
    Registrador_de_4bits tes(.in(in), .clk(clk), .reset(reset), .enable(enable), .out(out_register));
	 // Instância do Registrador de 4bits
	 seg_7_Digitos Hexa_7Seg(.in_bits(out_register), .out_display(HEX0));
	 
	 always
	   // Alterando os valores de clock a cada 5 segundos para alterar os valores de teste
	   begin
		  #5
		  clk = ~clk;
		end
		
    initial
	   begin
		// Geração de sinais.
		  clk = 0; reset = 1; enable = 0; in = 4'h0;
		  #1;
		  reset = 0;
		  #2;
		  reset = 1;
		  
		  #7
		  enable = 1;
		  in = 4'h3;
		  
		  #10
		  enable = 1;
		  in = 4'h7;
		  
		  #10
		  enable = 0;
		  in = 4'h9;
		  
		  #10
		  enable = 1;
		  in = 4'h8;
		  
		  #10
		  enable = 0;
		  in = 4'h5;
		  
		  #10
		  enable = 1;
		  in = 4'ha;
		  
		  #10
		  enable = 1;
		  in = 4'hf;
		  
		end
		
endmodule