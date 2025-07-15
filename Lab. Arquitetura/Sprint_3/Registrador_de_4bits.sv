//  Registrador de 4bits
module  Registrador_de_4bits (
  input wire [3:0] in,
  input wire clk, reset, enable,
  output reg [3:0] out
);
  // As alterações serão realizadas caso tenha subida de clock ou descida de reset
  always @(posedge clk, negedge reset)
  	begin
      if (!reset)
        // Neste caso o reset tem a prioridade maxima e zera o registrador se houver descida do pulso
        out <= 0;
      else if (enable)
        out <= in;
      else 
        out <= out;
// Nesses últimos casos se o enable for ativo irá registrar a entrada senão permanece a ja registrada
    end
  
endmodule