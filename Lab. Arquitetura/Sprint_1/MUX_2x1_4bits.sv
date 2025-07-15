// Testbench para o Mux de 4 bits - Entradas manuais 
module MUX_2x1_4bits_TB; 
  // Implemente um módulo MUX 2x1 de 4bits.
  // Sinais 
  logic [3:0] Ia, Ib; 
  logic [3:0] Out_Mux; 
  logic select;
  logic [12:0] vector_test [7:0];
  logic [2:0] cont;
  logic [3:0] out_Esperado;
   
  // Instância do Mux de 4 bits 
  MUX_2x1_4bits tes(.i0(Ia), .i1(Ib), .sel(select), .out(Out_Mux)); 
  
  initial 
    begin 
      //Salva os sinais do TB em um arquivo .vcd 
      $dumpfile("test_Mux.vcd"); $dumpvars(1, MUX_2x1_4bits_TB); 
      $readmemb("values_Vector_Mux.txt", vector_test);
      cont = 0;
      #81;
      $display("Programa finalizado com sucesso..."); 
      $finish();
    end  
   
  	always  
    	begin
          // Relacionando as variaveis de entrada com os valores passados no arquivo
          {Ia, Ib, select, out_Esperado} = vector_test[cont];
          #10;
          //Monitora os sinais de entrada e saída 
          $display("time=%3d, Ia=%d, Ib=%d, select=%d, out_Esperado=%d, Out_Mux=%d", $time,Ia,Ib,select,out_Esperado,Out_Mux);
          // Testando se a saída está de forma correta
          if (Out_Mux == out_Esperado)
            $display("PASSOU");
          else
            $display("FALHOU");
          // Incremento no contador
          cont = cont + 1'b1;
    	end  
  
endmodule 