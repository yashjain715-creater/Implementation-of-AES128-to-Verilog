`timescale 1ns / 1ps

module test_ecb_e;

	// Outputs
	wire [128:1]ciphertext;
	reg [128:1] image;
	reg [128:1] img[1:65536];
	reg [128:1] key;
	integer i;
	integer f;

	// Instantiate the Unit Under Test (UUT)
	ecb_d uut (ciphertext,image,key);

	initial 
	begin

		#10 $readmemb("C:\\Users\\yashj\\OneDrive\\Desktop\\Implementation-of-AES128-to-Verilog\\ecb\\enc\\ecb_enc.txt",img);
		$display("img=%h",img[1]);
		f=$fopen("C:\\Users\\yashj\\OneDrive\\Desktop\\Implementation-of-AES128-to-Verilog\\ecb\\enc\\ecb_dec.txt","w");
		#10
		for(i=1;i<=65536;i=i+1)
		 begin
			  #10 image=img[i];
			  $display("%h",image);
			  key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
			  //$monitor("%d",i);  
			  $display("%h",key);
			  $display("%h",ciphertext);
			 
			  //$fwrite(f,"%d",i);  
			  $fwrite(f,"%b\n",ciphertext);
		 end 
		#10 $fclose(f);

	end
      
endmodule

