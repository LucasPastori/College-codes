----------------------------------------------------------------------------------
-- memoria de programa
-- Prof. Pedro L. Benko - FEI - 2017 - revisado
-- memoria: 256*16
-- 8 bit address; 16 bit data
-- prom.vhd
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------------------------
entity prom is
port ( clock : in std_logic;
	rst : in std_logic;
	Mre : in std_logic;
--	Mwe : in std_logic;
	address : in std_logic_vector(7 downto 0); -- endereço pelo program counter.
--	data_in : in std_logic_vector(15 downto 0);-- opção para alterar o programa
	instr: out std_logic_vector(15 downto 0)-- Registrador de instrução.
	);
end prom;
architecture behv of prom is  
	type rom_type is array (0 to 255) of -- 255 words de 16 bits cada.
	std_logic_vector(15 downto 0);
	signal tmp_rom: rom_type;
 begin
write: process(clock, rst, Mre, address)-- write: process(clock, rst, Mre, address, data_in)
 begin
	if rst='0' then -- x".." numero em hexadecimal
tmp_rom <= ( -- exemplo ilustrativo de operação
-- {programa a ser carregado (cada aluno fará o seu nessa area)

--------------------------------------------- Bloco de início------------------------------------------------------
0=> x"48AA", -- Carrega AA no R[8]
1=> x"4101", -- Carrega 01 no R[1]
2=> x"4000", -- Carrega 00 no R[0]
3=> x"49FF", -- Carrega FF no R[9]                                          
4=> x"3800", -- Mostra R[8] no LED
-------------------------------------------- Bloco de carregamento--------------------------------------------------
5=> x"F000", -- RUN
6=> x"2200", -- Carrega valor da chave no R[2]
7=> x"1228", -- Carrega o valor de R[2]na Memória A[28]
8=> x"3200", -- Mostra R[2] no LED

9=> x"F000", -- RUN
10=> x"2300", -- Carrega valor da chave no R[3]
11=>x"1329", -- Carrega o valor de R[3]na Memória A[29]
12=> x"3300", -- Mostra R[3] no LED

13=> x"F000", -- RUN
14=> x"2400", -- Carrega valor da chave no R[4]
15=> x"142A", -- Carrega o valor de R[4]na Memória A[2A]
16=> x"3400", -- Mostra R[4] no LED  

17=> x"F000", -- RUN
18=> x"2500", -- Carrega valor da chave no R[5]
19=> x"152B", -- Carrega o valor de R[5]na Memória A[2B]
20=> x"3500", -- Mostra R[5] no LED

21=> x"F000", -- RUN
22=> x"2600", -- Carrega valor da chave no R[6]
23=> x"162C", -- Carrega o valor de R[6]na Memória A[2C]
24=> x"3600", -- Mostra R[6] no LED  
 
25=> x"F000", -- RUN
26=> x"2700", -- Carrega valor da chave no R[7]
27=> x"172D", -- Carrega o valor de R[7]na Memória A[2D]
28=> x"3700", -- Mostra R[7] no LED

29=> x"F000", -- RUN                                                                          
30=> x"3900", -- LED mostra R[9]                                                              
31=> x"F000", -- RUN                                                                          

32=> x"7A71", -- R[A] recebe R[7] AND R[1] 
33=> x"E000", -- Faz salto se o bit for par
34=> x"B072", -- Vai para o Bloco de instrução dígito ímpar (114)                                  

------------------------------------------ Bloco de instrução dígito par--------------------------------------------

                                                     --2--
35=> x"7A21", -- R[A] recebe R[2] AND R[1] 
36=> x"E000", -- Faz salto se o bit for par
37=> x"B02E", -- Vai para a instrução do bit ímpar (46)

-- Instrução do bit par
38=> x"5222", -- R[2] recebe R[2]+R[2]
39=> x"5222", -- R[2] recebe R[2]+R[2]
40=> x"5222", -- R[2] recebe R[2]+R[2]
41=> x"5222", -- R[2] recebe R[2]+R[2]
42=> x"3200", -- LED mostra R[2]
43=> x"1228", -- Devolve valor atualizado para a memória  
44=> x"F000", -- RUN
45=> x"B030", -- Vai para 3 (48)                                                                  
-- Instrução do bit ímpar
46=> x"3200", -- LED mostra R[2]
47=> x"F000", -- RUN
                                                     --3--
48=> x"7A31", -- R[A] recebe R[3] AND R[1] 
49=> x"E000", -- Faz salto se o bit for par
50=> x"B03B", -- Vai para a instrução do bit ímpar (59)
                                                     
-- Instrução do bit par
51=> x"5333", -- R[3] recebe R[3]+R[3]
52=> x"5333", -- R[3] recebe R[3]+R[3]
53=> x"5333", -- R[3] recebe R[3]+R[3]
54=> x"5333", -- R[3] recebe R[3]+R[3]
55=> x"3300", -- LED mostra R[3]
56=> x"1329", -- Devolve valor atualizado para a memória  
57=> x"F000", -- RUN
58=> x"B03D", -- Vai para 4 (61)                                                                   
-- Instrução do bit ímpar
59=> x"3300", -- LED mostra R[3]
60=> x"F000", -- RUN
                                                     --4--
61=> x"7A41", -- R[A] recebe R[4] AND R[1] 
62=> x"E000", -- Faz salto se o bit for par
63=> x"B048", -- Vai para a instrução do bit ímpar (72)
                                                     
-- Instrução do bit par
64=> x"5444", -- R[4] recebe R[4]+R[4]
65=> x"5444", -- R[4] recebe R[4]+R[4]
66=> x"5444", -- R[4] recebe R[4]+R[4]
67=> x"5444", -- R[4] recebe R[4]+R[4]
68=> x"3400", -- LED mostra R[4]
69=> x"142A", -- Devolve valor atualizado para a memória  
70=> x"F000", -- RUN
71=> x"B04A", -- Vai para 5 (74)  
                                                                  
-- Instrução do bit ímpar
72=> x"3400", -- LED mostra R[4]
73=> x"F000", -- RUN
                                                     --5--
74=> x"7A51", -- R[A] recebe R[5] AND R[1] 
75=> x"E000", -- Faz salto se o bit for par
76=> x"B055", -- Vai para a instrução do bit ímpar (85)
                                                     
-- Instrução do bit par
77=> x"5555", -- R[5] recebe R[5]+R[5]
78=> x"5555", -- R[5] recebe R[5]+R[5]
79=> x"5555", -- R[5] recebe R[5]+R[5]
80=> x"5555", -- R[5] recebe R[5]+R[5]
81=> x"3500", -- LED mostra R[5]
82=> x"152B", -- Devolve valor atualizado para a memória  
83=> x"F000", -- RUN
84=> x"B057", -- Vai para 6 (87)                                                                    
-- Instrução do bit ímpar
85=> x"3500", -- LED mostra R[5]
86=> x"F000", -- RUN
                                                     --6--
87=> x"7A61", -- R[A] recebe R[6] AND R[1] 
88=> x"E000", -- Faz salto se o bit for par
89=> x"B062", -- Vai para a instrução do bit ímpar (98)
                                                     
-- Instrução do bit par
90=> x"5666", -- R[6] recebe R[6]+R[6]
91=> x"5666", -- R[6] recebe R[6]+R[6]
92=> x"5666", -- R[6] recebe R[6]+R[6]
93=> x"5666", -- R[6] recebe R[6]+R[6]
94=> x"3600", -- LED mostra R[6]
95=> x"162C", -- Devolve valor atualizado para a memória  
96=> x"F000", -- RUN
97=> x"B064", -- Vai para 7 (100)                                                                    
-- Instrução do bit ímpar
98=> x"3600", -- LED mostra R[6]
99=> x"F000", -- RUN	
                                                     --7--
100=> x"7A71", -- R[A] recebe R[7] AND R[1] 
101=> x"E000", -- Faz salto se o bit for par
102=> x"B06F", -- Vai para a instrução do bit ímpar (111)
                                                     
-- Instrução do bit par
103=> x"5777", -- R[7] recebe R[7]+R[7]
104=> x"5777", -- R[7] recebe R[7]+R[7]
105=> x"5777", -- R[7] recebe R[7]+R[7]
106=> x"5777", -- R[7] recebe R[7]+R[7]
107=> x"3700", -- LED mostra R[7]
108=> x"172D", -- Devolve valor atualizado para a memória  
109=> x"F000", -- RUN
110=> x"B0C0", -- Vai para o final do programa  (192)                                                
-- Instrução do bit ímpar
111=> x"3700", -- LED mostra R[7]
112=> x"F000", -- RUN	
113=> x"B0C0", -- Vai para o final do programa 	(192)														  																	  
------------------------------------------ Bloco de instrução dígito ímpar--------------------------------------------
  
                                                     --2--
114=> x"7A21", -- R[A] recebe R[2] AND R[1] 
115=> x"E000", -- Faz salto se o bit for par
116=> x"B078", -- Vai para a instrução do bit ímpar (120)

-- Instrução do bit par
117=> x"3200", -- LED mostra R[2]
118=> x"F000", -- RUN
119=> x"B07F", -- Vai para 3 (127)                                                                    
-- Instrução do bit ímpar
120=> x"5222", -- R[2] recebe R[2]+R[2]
121=> x"5222", -- R[2] recebe R[2]+R[2]
122=> x"5222", -- R[2] recebe R[2]+R[2]
123=> x"5222", -- R[2] recebe R[2]+R[2]
124=> x"3200", -- LED mostra R[2]
125=> x"1228", -- Devolve valor atualizado para a memória  
126=> x"F000", -- RUN

                                                     --3--
127=> x"7A31", -- R[A] recebe R[3] AND R[1] 
128=> x"E000", -- Faz salto se o bit for par
129=> x"B085", -- Vai para a instrução do bit ímpar (133) 
                                                     
-- Instrução do bit par
130=> x"3300", -- LED mostra R[3]
131=> x"F000", -- RUN
132=> x"B08C", -- Vai para 4 (140)                                                                    
-- Instrução do bit ímpar
133=> x"5333", -- R[3] recebe R[3]+R[3]
134=> x"5333", -- R[3] recebe R[3]+R[3]
135=> x"5333", -- R[3] recebe R[3]+R[3]
136=> x"5333", -- R[3] recebe R[3]+R[3]
137=> x"3300", -- LED mostra R[3]
138=> x"1329", -- Devolve valor atualizado para a memória  
139=> x"F000", -- RUN
                                                     --4--
140=> x"7A41", -- R[A] recebe R[4] AND R[1] 
141=> x"E000", -- Faz salto se o bit for par
142=> x"B092", -- Vai para a instrução do bit ímpar (146) 
                                                     
-- Instrução do bit par
143=> x"3400", -- LED mostra R[4]
144=> x"F000", -- RUN
145=> x"B099", -- Vai para 5  (153)                                                                   
-- Instrução do bit ímpar
146=> x"5444", -- R[4] recebe R[4]+R[4]
147=> x"5444", -- R[4] recebe R[4]+R[4]
148=> x"5444", -- R[4] recebe R[4]+R[4]
149=> x"5444", -- R[4] recebe R[4]+R[4]
150=> x"3400", -- LED mostra R[4]
151=> x"142A", -- Devolve valor atualizado para a memória  
152=> x"F000", -- RUN
                                                     --5--
153=> x"7A51", -- R[A] recebe R[5] AND R[1] 
154=> x"E000", -- Faz salto se o bit for par
155=> x"B09F", -- Vai para a instrução do bit ímpar (159)
                                                     
-- Instrução do bit par
156=> x"3500", -- LED mostra R[5]
157=> x"F000", -- RUN
158=> x"B0A6", -- Vai para 6 (166)                                                                    
-- Instrução do bit ímpar
159=> x"5555", -- R[5] recebe R[5]+R[5]
160=> x"5555", -- R[5] recebe R[5]+R[5]
161=> x"5555", -- R[5] recebe R[5]+R[5]
162=> x"5555", -- R[5] recebe R[5]+R[5]
163=> x"3500", -- LED mostra R[5]
164=> x"152B", -- Devolve valor atualizado para a memória  
165=> x"F000", -- RUN
                                                     --6--
166=> x"7A61", -- R[A] recebe R[6] AND R[1] 
167=> x"E000", -- Faz salto se o bit for par
168=> x"B0AC", -- Vai para a instrução do bit ímpar (172) 
                                                     
-- Instrução do bit par
169=> x"3600", -- LED mostra R[6]
170=> x"F000", -- RUN
171=> x"B0B3", -- Vai para 7  (179)                                                                   
-- Instrução do bit ímpar
172=> x"5666", -- R[6] recebe R[6]+R[6]
173=> x"5666", -- R[6] recebe R[6]+R[6]
174=> x"5666", -- R[6] recebe R[6]+R[6]
175=> x"5666", -- R[6] recebe R[6]+R[6]
176=> x"4600", -- LED mostra R[6]
177=> x"162C", -- Devolve valor atualizado para a memória  
178=> x"F000", -- RUN	
                                                     --7--
179=> x"7A71", -- R[A] recebe R[7] AND R[1] 
180=> x"E000", -- Faz salto se o bit for par
181=> x"B0B9", -- Vai para a instrução do bit ímpar  (185)
                                                     
-- Instrução do bit par
182=> x"3700", -- LED mostra R[7]
183=> x"F000", -- RUN
184=> x"B0C0", -- Vai para o final do programa (192)                                                 
-- Instrução do bit ímpar
185=> x"5777", -- R[7] recebe R[7]+R[7]
186=> x"5777", -- R[7] recebe R[7]+R[7]
187=> x"5777", -- R[7] recebe R[7]+R[7]
188=> x"5777", -- R[7] recebe R[7]+R[7]
189=> x"3700", -- LED mostra R[7]
190=> x"172D", -- Devolve valor atualizado para a memória  
191=> x"F000", -- RUN

--------------------------------------------- Bloco de finalização---------------------------------------------------

192=> x"B000", -- salta para o início reiniciando o programa

----------------------------------------------------FIM--------------------------------------------------------------



others => "0000000000000000");
--else -- opçao para inclusão de instruções ou modificação do programa.
--	if (clock'event and clock = '1') then
--		if (Mwe ='1' and Mre = '0') then
--			tmp_rom(conv_integer(address)) <= data_in;
--		end if;
--	end if;
--end if;
--end process;
----------------------------------------------------------------------------------
-- Programa a ser executado. O endereçamento é executaos pelo Program Counter
-- entrada "address". O bloco de controle gera o sinal de leitura 'Mre'
-- "data_out" corresponde ao Registro de instrução (IR - Instruc Regs).
----------------------------------------------------------------------------------
--read: process(clock, rst, Mwe, address)
--begin
--	if rst='1' then
		instr <= "0000000000000000";
	else
		if (clock'event and clock = '1') then
			if (Mre ='1') then -- if (Mre ='1' and Mwe ='0') then
				instr <= tmp_rom(conv_integer(address));
			end if;
		end if;
	end if;
end process;
end behv;
----------------------------------------------------------------------------------