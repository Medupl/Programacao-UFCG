// Testbench para o  Registrador da Soma do Mux 4bits - Entradas manuais 
module Registrador_Somador_TB; 
  // Implemente um registrador de 4bits com enable, reset assíncrono, entrada paralela e saída paralela.  
  // Sinais 
	reg  [3:0] value_a, value_b, value_c; 
    reg  select, clk, reset, enable;
    wire [3:0] saida;
    reg  [2:0] cont;
    reg  [3:0] out_Soma;
    reg  [18:0] vector_test [7:0];


    // Instância do Registrador de 4bits
    Registrador_Somador tes(.ia(value_a), .ib(value_b), .ic(value_c), .select(select), .clk(clk), .reset(reset), .enable(enable), .saida(saida)); 

    initial 
      begin 
        //Salva os sinais do TB em um arquivo .vcd 
        $dumpfile("test_Register_Sum.vcd"); $dumpvars(1, Registrador_Somador_TB); 
		$readmemb("values_registrador_Somador.txt",     vector_test);
        cont = 0;
        clk = 0; reset = 1; enable = 0;
        #1;
        reset = 0;
        #9;
        //Monitora os sinais de entrada e saída 
        $monitor("time=%3d, Valor A=%d, Valor B=%d, Valor C=%d, Selecao=%b, Clock=%d, Reset=%b, Enable=%b, Saida=%d", $time,value_a,value_b,value_c,select,clk,reset,enable,saida); 
        #81;

        $display("Programa finalizado com sucesso..."); 
        $finish();
      end  

    always
      begin
        // Alterando os valores de clock a cada 5 segundos para alterar os valores de teste
        #5;
        clk = ~clk;
      end

    always
      begin
        // Pegando os valores das variaveis pelo txt
        {value_a, value_b, value_c, select, reset, enable, out_Soma} = vector_test[cont];
      #10;
      cont = cont + 1'b1;
      end

  endmodule