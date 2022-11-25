`timescale 1ns / 1ps

module test_cbc_e;

	// Outputs
	wire [128:1]ciphertext;
	reg [128:1] image;
	reg [128:1] img[1:65536];
	reg [128:1] key;
	reg [128:1] iv;
	integer i;
	integer f;

	// Instantiate the Unit Under Test (UUT)
	cbc_e uut (ciphertext,image,key,iv);

	initial 
	begin

		#10 $readmemb("C:\\Users\\yashj\\OneDrive\\Desktop\\Implementation-of-AES128-to-Verilog\\cbc\\enc\\binary.txt",img);
		$display("img=%h",img[1]);
		f=$fopen("C:\\Users\\yashj\\OneDrive\\Desktop\\Implementation-of-AES128-to-Verilog\\cbc\\enc\\cbc_enc.txt","w");
		iv = 128'h04C723C31896059A071280E2EB27B275;
		#10
		for(i=1;i<=65536;i=i+1)
		 begin
			  image=img[i];
			  
			  //$display("%h",image);
			  key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
			  //$monitor("%d",i);  
			  //$display("%h",key);
			  $display("%h",ciphertext);
			 
			  //$fwrite(f,"%d",i);  
			  $fwrite(f,"%b\n",ciphertext);
			  #10 iv=ciphertext;
		 end 
		#10 $fclose(f);

	end
      
endmodule

