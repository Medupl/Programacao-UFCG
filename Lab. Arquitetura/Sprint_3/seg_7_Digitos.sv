module seg_7_Digitos(
    input [3:0] in_bits,
    output reg [6:0] out_display);

	 always @(in_bits)							// Entra no laço sempre que tiver alguma alteração em in_bits
	 begin
	     
		  case(in_bits)							// Trata os casos possiveis da variavel in_bits
		      
				4'h0: out_display = ~7'b0111111;
				4'h1: out_display = ~7'b0000110; 		//  ---[0]---
				4'h2: out_display = ~7'b1011011;  		//  |       |
				4'h3: out_display = ~7'b1001111; 		// [5]     [1]
				4'h4: out_display = ~7'b1100110; 		//  |       |
				4'h5: out_display = ~7'b1101101;  		//  ---[6]---
				4'h6: out_display = ~7'b1111101;  		//  |       |
				4'h7: out_display = ~7'b0000111;  		// [4]     [2]
				4'h8: out_display = ~7'b1111111; 		//  |       |
				4'h9: out_display = ~7'b1101111; 		//  ---[3]---
				4'ha: out_display = ~7'b1110111;
				4'hb: out_display = ~7'b1111100;
				4'hc: out_display = ~7'b0111001;
				4'hd: out_display = ~7'b1011110;
				4'he: out_display = ~7'b1111001;
				4'hf: out_display = ~7'b1110001;
				
		  endcase
		  
    end

endmodule