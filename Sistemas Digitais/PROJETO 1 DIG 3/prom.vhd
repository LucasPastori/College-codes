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
0=> x"4BAA", -- Carrega AA no R[B]
1=> x"4101", -- Carrega 01 no R[1]
2=> x"4000", -- Carrega 00 no R[0]
3=> x"4FFF", -- Carrega FF no R[F]                                          
4=> x"3B00", -- Mostra R[B] no LED
-------------------------------------------- Bloco de carregamento--------------------------------------------------
5=> x"7000", -- RUN
6=> x"2200", -- Carrega valor da chave no R[2]
7=> x"1228", -- Carrega o valor de R[2]na Memória A[28]
8=> x"3200", -- Mostra R[2] no LED

9=> x"F000", -- RUN
10=> x"2300", -- Carrega valor da chave no R[3]
11=>x"1329", -- Carrega o valor de R[3]na Memória A[29]
12=> x"3300", -- Mostra R[3] no LED

13=> x"F000", -- RUN
14=> x"2400", -- Carrega valor da chave no R[4]
15=> x"144A", -- Carrega o valor de R[4]na Memória A[2A]
16=> x"3400", -- Mostra R[4] no LED  

17=> x"F000", -- RUN
18=> x"2500", -- Carrega valor da chave no R[5]
19=> x"1500", -- Carrega o valor de R[5]na Memória A[2B]
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
30=> x"3F00", -- LED mostra R[F]                                                              
31=> x"F000", -- RUN                                                                          

32=> x"7F71", -- R[F] recebe R[7] AND R[1] 
33=> x"E000", -- Faz salto se o bit for par
34=> x"B06C", -- Vai para o Bloco de instrução dígito ímpar (108)                                  

------------------------------------------ Bloco de instrução dígito par--------------------------------------------

                                                     --2--
35=> x"7F21", -- R[F] recebe R[2] AND R[1] 
36=> x"E000", -- Faz salto se o bit for par
37=> x"B02D", -- Vai para a instrução do bit ímpar (45)

-- Instrução do bit par
38=> x"5222", -- R[2] recebe R[2]+R[2]
39=> x"5222", -- R[2] recebe R[2]+R[2]
40=> x"5222", -- R[2] recebe R[2]+R[2]
41=> x"5222", -- R[2] recebe R[2]+R[2]
42=> x"3200", -- LED mostra R[2]
43=> x"F000", -- RUN
44=> x"B02F", -- Vai para 3 (47)                                                                    
-- Instrução do bit ímpar
45=> x"3200", -- LED mostra R[2]
46=> x"F000", -- RUN
                                                     --3--
47=> x"7F31", -- R[F] recebe R[3] AND R[1] 
48=> x"E000", -- Faz salto se o bit for par
49=> x"B039", -- Vai para a instrução do bit ímpar (57)
                                                     
-- Instrução do bit par
50=> x"5333", -- R[3] recebe R[3]+R[3]
51=> x"5333", -- R[3] recebe R[3]+R[3]
52=> x"5333", -- R[3] recebe R[3]+R[3]
53=> x"5333", -- R[3] recebe R[3]+R[3]
54=> x"3300", -- LED mostra R[3]
55=> x"F000", -- RUN
56=> x"B03B", -- Vai para 4 (59)                                                                   
-- Instrução do bit ímpar
57=> x"3300", -- LED mostra R[3]
58=> x"F000", -- RUN
                                                     --4--
59=> x"7F41", -- R[F] recebe R[4] AND R[1] 
60=> x"E000", -- Faz salto se o bit for par
61=> x"B045", -- Vai para a instrução do bit ímpar (69)
                                                     
-- Instrução do bit par
62=> x"5444", -- R[4] recebe R[4]+R[4]
63=> x"5444", -- R[4] recebe R[4]+R[4]
64=> x"5444", -- R[4] recebe R[4]+R[4]
65=> x"5444", -- R[4] recebe R[4]+R[4]
66=> x"3400", -- LED mostra R[4]
67=> x"F000", -- RUN
68=> x"B047", -- Vai para 5 (71)                                                                    
-- Instrução do bit ímpar
69=> x"3400", -- LED mostra R[4]
70=> x"F000", -- RUN
                                                     --5--
71=> x"7F51", -- R[F] recebe R[5] AND R[1] 
72=> x"E000", -- Faz salto se o bit for par
73=> x"B051", -- Vai para a instrução do bit ímpar (81)
                                                     
-- Instrução do bit par
74=> x"5555", -- R[5] recebe R[5]+R[5]
75=> x"5555", -- R[5] recebe R[5]+R[5]
76=> x"5555", -- R[5] recebe R[5]+R[5]
77=> x"5555", -- R[5] recebe R[5]+R[5]
78=> x"3500", -- LED mostra R[5]
79=> x"F000", -- RUN
80=> x"B053", -- Vai para 6 (83)                                                                    
-- Instrução do bit ímpar
81=> x"3500", -- LED mostra R[5]
82=> x"F000", -- RUN
                                                     --6--
83=> x"7F61", -- R[F] recebe R[6] AND R[1] 
84=> x"E000", -- Faz salto se o bit for par
85=> x"B05D", -- Vai para a instrução do bit ímpar (93)
                                                     
-- Instrução do bit par
86=> x"5666", -- R[6] recebe R[6]+R[6]
87=> x"5666", -- R[6] recebe R[6]+R[6]
88=> x"5666", -- R[6] recebe R[6]+R[6]
89=> x"5666", -- R[6] recebe R[6]+R[6]
90=> x"3600", -- LED mostra R[6]
91=> x"F000", -- RUN
92=> x"B05F", -- Vai para 7 (95)                                                                    
-- Instrução do bit ímpar
93=> x"3600", -- LED mostra R[6]
94=> x"F000", -- RUN	
                                                     --7--
95=> x"7F71", -- R[F] recebe R[7] AND R[1] 
96=> x"E000", -- Faz salto se o bit for par
97=> x"B069", -- Vai para a instrução do bit ímpar (105)
                                                     
-- Instrução do bit par
98=> x"5777", -- R[7] recebe R[7]+R[7]
99=> x"5777", -- R[7] recebe R[7]+R[7]
100=> x"5777", -- R[7] recebe R[7]+R[7]
101=> x"5777", -- R[7] recebe R[7]+R[7]
102=> x"3700", -- LED mostra R[7]
103=> x"F000", -- RUN
104=> x"B0B4", -- Vai para o final do programa  (180)                                                
-- Instrução do bit ímpar
105=> x"3700", -- LED mostra R[7]
106=> x"F000", -- RUN	
107=> x"B0B4", -- Vai para o final do programa 															  																	  
------------------------------------------ Bloco de instrução dígito ímpar--------------------------------------------
  
                                                     --2--
108=> x"7F21", -- R[F] recebe R[2] AND R[1] 
109=> x"E000", -- Faz salto se o bit for par
110=> x"B072", -- Vai para a instrução do bit ímpar (114)

-- Instrução do bit par
111=> x"3200", -- LED mostra R[2]
112=> x"F000", -- RUN
113=> x"B078", -- Vai para 3 (120)                                                                    
-- Instrução do bit ímpar
114=> x"5222", -- R[2] recebe R[2]+R[2]
115=> x"5222", -- R[2] recebe R[2]+R[2]
116=> x"5222", -- R[2] recebe R[2]+R[2]
117=> x"5222", -- R[2] recebe R[2]+R[2]
118=> x"3200", -- LED mostra R[2]
119=> x"F000", -- RUN

                                                     --3--
120=> x"7F31", -- R[F] recebe R[3] AND R[1] 
121=> x"E000", -- Faz salto se o bit for par
122=> x"B07E", -- Vai para a instrução do bit ímpar (126) 
                                                     
-- Instrução do bit par
123=> x"3300", -- LED mostra R[3]
124=> x"F000", -- RUN
125=> x"B084", -- Vai para 4 (132)                                                                    
-- Instrução do bit ímpar
126=> x"5333", -- R[3] recebe R[3]+R[3]
127=> x"5333", -- R[3] recebe R[3]+R[3]
128=> x"5333", -- R[3] recebe R[3]+R[3]
129=> x"5333", -- R[3] recebe R[3]+R[3]
130=> x"3300", -- LED mostra R[3]
131=> x"F000", -- RUN
                                                     --4--
132=> x"7F41", -- R[F] recebe R[4] AND R[1] 
133=> x"E000", -- Faz salto se o bit for par
134=> x"B08A", -- Vai para a instrução do bit ímpar (138) 
                                                     
-- Instrução do bit par
135=> x"3400", -- LED mostra R[4]
136=> x"F000", -- RUN
137=> x"B090", -- Vai para 5  (144)                                                                   
-- Instrução do bit ímpar
138=> x"5444", -- R[4] recebe R[4]+R[4]
139=> x"5444", -- R[4] recebe R[4]+R[4]
140=> x"5444", -- R[4] recebe R[4]+R[4]
141=> x"5444", -- R[4] recebe R[4]+R[4]
142=> x"3400", -- LED mostra R[4]
143=> x"F000", -- RUN
                                                     --5--
144=> x"7F51", -- R[F] recebe R[5] AND R[1] 
145=> x"E000", -- Faz salto se o bit for par
146=> x"B096", -- Vai para a instrução do bit ímpar (150)
                                                     
-- Instrução do bit par
147=> x"3500", -- LED mostra R[5]
148=> x"F000", -- RUN
149=> x"B09C", -- Vai para 6 (156)                                                                    
-- Instrução do bit ímpar
150=> x"5555", -- R[5] recebe R[5]+R[5]
151=> x"5555", -- R[5] recebe R[5]+R[5]
152=> x"5555", -- R[5] recebe R[5]+R[5]
153=> x"5555", -- R[5] recebe R[5]+R[5]
154=> x"3500", -- LED mostra R[5]
155=> x"F000", -- RUN
                                                     --6--
156=> x"7F61", -- R[F] recebe R[6] AND R[1] 
157=> x"E000", -- Faz salto se o bit for par
158=> x"B0A2", -- Vai para a instrução do bit ímpar (162) 
                                                     
-- Instrução do bit par
159=> x"3600", -- LED mostra R[6]
160=> x"F000", -- RUN
161=> x"B0A8", -- Vai para 7  (168)                                                                   
-- Instrução do bit ímpar
162=> x"5666", -- R[6] recebe R[6]+R[6]
163=> x"5666", -- R[6] recebe R[6]+R[6]
164=> x"5666", -- R[6] recebe R[6]+R[6]
165=> x"5666", -- R[6] recebe R[6]+R[6]
166=> x"4600", -- LED mostra R[6]
167=> x"F000", -- RUN	
                                                     --7--
168=> x"7F71", -- R[F] recebe R[7] AND R[1] 
169=> x"E000", -- Faz salto se o bit for par
170=> x"B0AE", -- Vai para a instrução do bit ímpar  (174)
                                                     
-- Instrução do bit par
171=> x"3700", -- LED mostra R[7]
172=> x"F000", -- RUN
173=> x"B0B4", -- Vai para o final do programa (180)                                                 
-- Instrução do bit ímpar
174=> x"5777", -- R[7] recebe R[7]+R[7]
175=> x"5777", -- R[7] recebe R[7]+R[7]
176=> x"5777", -- R[7] recebe R[7]+R[7]
177=> x"5777", -- R[7] recebe R[7]+R[7]
178=> x"3700", -- LED mostra R[7]
179=> x"F000", -- RUN

--------------------------------------------- Bloco de finalização---------------------------------------------------

180=> x"3F00", -- LED mostra R[F]
181=> x"F000", -- RUN
182=> x"B000", -- salta para o início reiniciando o programa

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