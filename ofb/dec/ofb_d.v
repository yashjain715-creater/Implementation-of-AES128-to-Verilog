`timescale 1ns / 1ps

module ofb_d(ciphertext, pre_enc_res, image, key, iv);
output reg [128:1] ciphertext;
output reg [128:1] pre_enc_res;
input [128:1] image;
input[128:1] key;
input [128:1] iv;
reg [32:1] w[1:44];
reg [12:1] test = 12'he3b;
reg [32:1] s[1:4];
reg [32:1] sd[1:4];
reg[127:0] mcl;
reg[127:0] a;


wire [32:1] w1 ,w2 ,w3 ,w4 ,w5 ,w6 ,w7 ,w8 ,w9 ,w10 ,w11 ,w12 ,w13 ,w14 ,w15 ,w16 ,w17 ,w18 ,w19 ,w20 ,w21 ,w22 ,w23 ,w24 ,w25 ,w26 ,w27 ,w28 ,w29 ,w30 ,w31 ,w32 ,w33 ,w34 ,w35 ,w36 ,w37 ,w38 ,w39 ,w40 ,w41 ,w42 ,w43,w44;
integer i;
integer j;
reg [8:1] temp1, temp2, temp3, temp4;
processkey p(w1 ,w2 ,w3 ,w4 ,w5 ,w6 ,w7 ,w8 ,w9 ,w10 ,w11 ,w12 ,w13 ,w14 ,w15 ,w16 ,w17 ,w18 ,w19 ,w20 ,w21 ,w22 ,w23 ,w24 ,w25 ,w26 ,w27 ,w28 ,w29 ,w30 ,w31 ,w32 ,w33 ,w34 ,w35 ,w36 ,w37 ,w38 ,w39 ,w40 ,w41 ,w42 ,w43 , w44,key);
//reg [8:1] k=8'h2b; 


function [8:1] substitute(input [8:1] sb);
	reg [0:127] sbox[0:15];
	
	begin
		sbox[0] =128'h637C777BF26B6FC53001672BFED7AB76;
		sbox[1] =128'hCA82C97DFA5947F0ADD4A2AF9CA472C0;
		sbox[2] =128'hB7FD9326363FF7CC34A5E5F171D83115;
		sbox[3] =128'h04C723C31896059A071280E2EB27B275;
		sbox[4] =128'h09832C1A1B6E5AA0523BD6B329E32F84;
		sbox[5] =128'h53D100ED20FCB15B6ACBBE394A4C58CF;
		sbox[6] =128'hD0EFAAFB434D338545F9027F503C9FA8;
		sbox[7] =128'h51A3408F929D38F5BCB6DA2110FFF3D2;
		sbox[8] =128'hCD0C13EC5F974417C4A77E3D645D1973;
		sbox[9] =128'h60814FDC222A908846EEB814DE5E0BDB;
		sbox[10]=128'hE0323A0A4906245CC2D3AC629195E479;
		sbox[11]=128'hE7C8376D8DD54EA96C56F4EA657AAE08;
		sbox[12]=128'hBA78252E1CA6B4C6E8DD741F4BBD8B8A;
		sbox[13]=128'h703EB5664803F60E613557B986C11D9E;
		sbox[14]=128'hE1F8981169D98E949B1E87E9CE5528DF;
		sbox[15]=128'h8CA1890DBFE6426841992D0FB054BB16;
		
		substitute = sbox[sb[8:5]][8*sb[4:1] +:8];
	end
endfunction 

function [7:0] mixcolumn32;
	input [7:0] i1,i2,i3,i4;
	begin
	mixcolumn32[7]=i1[6] ^ i2[6] ^ i2[7] ^ i3[7] ^ i4[7];
	mixcolumn32[6]=i1[5] ^ i2[5] ^ i2[6] ^ i3[6] ^ i4[6];
	mixcolumn32[5]=i1[4] ^ i2[4] ^ i2[5] ^ i3[5] ^ i4[5];
	mixcolumn32[4]=i1[3] ^ i1[7] ^ i2[3] ^ i2[4] ^ i2[7] ^ i3[4] ^ i4[4];
	mixcolumn32[3]=i1[2] ^ i1[7] ^ i2[2] ^ i2[3] ^ i2[7] ^ i3[3] ^ i4[3];
	mixcolumn32[2]=i1[1] ^ i2[1] ^ i2[2] ^ i3[2] ^ i4[2];
	mixcolumn32[1]=i1[0] ^ i1[7] ^ i2[0] ^ i2[1] ^ i2[7] ^ i3[1] ^ i4[1];
	mixcolumn32[0]=i1[7] ^ i2[7] ^ i2[0] ^ i3[0] ^ i4[0];
	end
endfunction

always @(*)
  begin
	w[5]= w5; w[6]= w6; w[7]= w7; w[8]= w8; w[9]= w9; w[10]= w10; w[11]= w11; w[12]= w12; w[13]= w13; w[14]= w14; w[15]= w15; w[16]= w16; w[17]= w17; w[18]= w18; w[19]= w19; w[20]= w20; w[21]= w21; w[22]= w22; w[23]= w23; w[24]= w24; w[25]= w25; w[26]= w26; w[27]= w27; w[28]= w28; w[29]= w29; w[30]= w30; w[31]= w31; w[32]= w32; w[33]= w33; w[34]= w34; w[35]= w35; w[36]= w36; w[37]= w37; w[38]= w38; w[39]= w39; w[40]= w40; w[41]= w41; w[42]= w42; w[43]= w43; w[44]= w44;

	s[1]=iv[128:97];
	s[2]=iv[96:65];
	s[3]=iv[64:33];
	s[4]=iv[32:1];
	//initial transformation
	s[1]=s[1]^w1;
	s[2]=s[2]^w2;
	s[3]=s[3]^w3;
	s[4]=s[4]^w4;
	//round 1 to 9
	for(i=1;i<=9;i=i+1)
	begin
		//substitute bytes
		for(j=1;j<=4;j=j+1)
		begin
			s[j][32:25]=substitute(s[j][32:25]);
			s[j][24:17]=substitute(s[j][24:17]);
			s[j][16:9]=substitute(s[j][16:9]);
			s[j][8:1]=substitute(s[j][8:1]);
		end
		
		//shift rows
		temp1=s[1][24:17];
		s[1][24:17]=s[2][24:17];
		s[2][24:17]=s[3][24:17];
		s[3][24:17]=s[4][24:17];
		s[4][24:17]=temp1;
		
		temp1=s[1][16:9];
		temp2=s[2][16:9];
		s[1][16:9]=s[3][16:9];
		s[2][16:9]=s[4][16:9];
		s[3][16:9]=temp1;
		s[4][16:9]=temp2;
		
		temp1=s[4][8:1];
		s[4][8:1]=s[3][8:1];
		s[3][8:1]=s[2][8:1];
		s[2][8:1]=s[1][8:1];
		s[1][8:1]=temp1;
		
		//mix columns
		/*s[1]=32'h876e46a6;
		s[2]=32'hf24ce78c;
		s[3]=32'h4d904ad8;
		s[4]=32'h97ecc395;*/
		
		a={s[1],s[2],s[3],s[4]};
		
		mcl[127:120]= mixcolumn32 (a[127:120],a[119:112],a[111:104],a[103:96]);
		mcl[119:112]= mixcolumn32 (a[119:112],a[111:104],a[103:96],a[127:120]);
		mcl[111:104]= mixcolumn32 (a[111:104],a[103:96],a[127:120],a[119:112]);
		mcl[103:96]= mixcolumn32 (a[103:96],a[127:120],a[119:112],a[111:104]);

		mcl[95:88]= mixcolumn32 (a[95:88],a[87:80],a[79:72],a[71:64]);
		mcl[87:80]= mixcolumn32 (a[87:80],a[79:72],a[71:64],a[95:88]);
		mcl[79:72]= mixcolumn32 (a[79:72],a[71:64],a[95:88],a[87:80]);
		mcl[71:64]= mixcolumn32 (a[71:64],a[95:88],a[87:80],a[79:72]);

		mcl[63:56]= mixcolumn32 (a[63:56],a[55:48],a[47:40],a[39:32]);
		mcl[55:48]= mixcolumn32 (a[55:48],a[47:40],a[39:32],a[63:56]);
		mcl[47:40]= mixcolumn32 (a[47:40],a[39:32],a[63:56],a[55:48]);
		mcl[39:32]= mixcolumn32 (a[39:32],a[63:56],a[55:48],a[47:40]);

		mcl[31:24]= mixcolumn32 (a[31:24],a[23:16],a[15:8],a[7:0]);
		mcl[23:16]= mixcolumn32 (a[23:16],a[15:8],a[7:0],a[31:24]);
		mcl[15:8]= mixcolumn32 (a[15:8],a[7:0],a[31:24],a[23:16]);
		mcl[7:0]= mixcolumn32 (a[7:0],a[31:24],a[23:16],a[15:8]);


		
		{s[1],s[2],s[3],s[4]}=mcl;
		
		
		//add round key
		s[1]=s[1]^w[4*i+1];
		s[2]=s[2]^w[4*i+2];
		s[3]=s[3]^w[4*i+3];
		s[4]=s[4]^w[4*i+4];
	end
	
	//round 10
	//substitute bytes
	for(j=1;j<=4;j=j+1)
	begin
		s[j][32:25]=substitute(s[j][32:25]);
		s[j][24:17]=substitute(s[j][24:17]);
		s[j][16:9]=substitute(s[j][16:9]);
		s[j][8:1]=substitute(s[j][8:1]);
	end
	
	//shift rows
	temp1=s[1][24:17];
	s[1][24:17]=s[2][24:17];
	s[2][24:17]=s[3][24:17];
	s[3][24:17]=s[4][24:17];
	s[4][24:17]=temp1;
	
	temp1=s[1][16:9];
	temp2=s[2][16:9];
	s[1][16:9]=s[3][16:9];
	s[2][16:9]=s[4][16:9];
	s[3][16:9]=temp1;
	s[4][16:9]=temp2;
	
	temp1=s[4][8:1];
	s[4][8:1]=s[3][8:1];
	s[3][8:1]=s[2][8:1];
	s[2][8:1]=s[1][8:1];
	s[1][8:1]=temp1;
	
	//add round key
	s[1]=s[1]^w[41];
	s[2]=s[2]^w[42];
	s[3]=s[3]^w[43];
	s[4]=s[4]^w[44];
	
	
	
	
	pre_enc_res =  {s[1],s[2],s[3],s[4]};
	ciphertext =  image^{s[1],s[2],s[3],s[4]};
	
  end
endmodule
