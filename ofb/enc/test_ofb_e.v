`timescale 1ns / 1ps

module test_ofb_e;

	// Outputs
	wire [128:1]ciphertext;
	wire [128:1]pre_enc_res;
	reg [128:1] image;
	reg [128:1] img[1:65536];
	reg [128:1] key;
	reg [128:1] iv;
	integer i;
	integer f;

	// Instantiate the Unit Under Test (UUT)
	ofb_e uut (ciphertext,pre_enc_res,image,key,iv);

	initial 
	begin

		#10 $readmemb("C:\\Users\\yashj\\OneDrive\\Desktop\\Implementation-of-AES128-to-Verilog\\ofb\\enc\\binary.txt",img);
		$display("img=%h",img[1]);
		f=$fopen("C:\\Users\\yashj\\OneDrive\\Desktop\\Implementation-of-AES128-to-Verilog\\ofb\\enc\\ofb_enc.txt","w");
		iv = 128'h04C723C31896059A071280E2EB27B275;
		#10
		for(i=1;i<=65536;i=i+1)
		 begin
			  image=img[i];
			  
			  //$display("%h",image);
			  key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
			  //$monitor("%d",i);  
			  //$display("%h",key);
			  #10 
			  $display("%d  %h  %h",i,ciphertext,iv); 
			  $fwrite(f,"%b\n",ciphertext);
			  iv=pre_enc_res;
		 end 
		#10 $fclose(f);

	end
      
endmodule

