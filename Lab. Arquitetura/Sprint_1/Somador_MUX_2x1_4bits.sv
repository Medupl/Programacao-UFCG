// Testbench para o Mux de 4 bits - Entradas manuais 
module Somador_MUX_2x1_4bits_TB; 
  // Implemente um módulo MUX 2x1 de 4bits.
  // Sinais 
  logic [3:0] Ia, Ib, Ic; 
  logic [3:0] Out_Sum; 
  logic select;
  logic [16:0] vector_test [7:0];
  logic [2:0] cont;
  logic [3:0] out_Esperado;
   
  // Instância do Mux de 4 bits 
  //MUX_2x1_4bits mux(.i0(Ib), .i1(Ic), .sel(select), .out(Out_Mux)); 
  //Somador_4bits sum(.a(Ia), .b(Out_Mux), .res(Out_Sum));
  Somador_MUX_2x1_4bits tes(.Ia(Ia), .Ib(Ib), .Ic(Ic), .select(select), .Out_Sum(Out_Sum));
  
  initial 
    begin 
      //Salva os sinais do TB em um arquivo .vcd 
      $dumpfile("test_Somador_Mux.vcd"); $dumpvars(1, Somador_MUX_2x1_4bits_TB); 
      $readmemb("values_Vector_Somador_Mux.txt", vector_test);
      cont = 0;
      #81;
      $display("Programa finalizado com sucesso..."); 
      $finish();
    end  
   
  	always  
    	begin
          // Relacionando as variaveis de entrada com os valores passados no arquivo
          {Ia, Ib, Ic, select, out_Esperado} = vector_test[cont];
          #10;
          //Monitora os sinais de entrada e saída 
          $display("time=%3d, Ia=%d, Ib=%d, Ic=%d, select=%d, out_Esperado=%d, Resultado da Soma=%d", $time,Ia,Ib,Ic,select,out_Esperado,Out_Sum);
          // Incremento no contador
          cont = cont + 1'b1;
    	end  
  
endmodule 