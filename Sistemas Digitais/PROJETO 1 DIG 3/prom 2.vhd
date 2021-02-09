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
0 => x"4BAA", -- Carrega AA no R[B]
1 => x"4101", -- Carrega 01 no R[1]
2 => x"4000", -- Carrega 00 no R[0]
3 => x"3B00", -- Mostra R[B] no LED
-------------------------------------------- Bloco de carregamento--------------------------------------------------
4 => x"7000", -- RUN
5 => x"2200", -- Carrega valor da chave no R[2]
6 => x"1228", -- Carrega o valor de R[2]na Memória A[28]
7 => x"3200", -- Mostra R[2] no LED

8 => x"F000", -- RUN
9 => x"2300", -- Carrega valor da chave no R[3]
10 =>x"1329", -- Carrega o valor de R[3]na Memória A[29]
11=> x"3300", -- Mostra R[3] no LED

12=> x"F000", -- RUN
13=> x"2400", -- Carrega valor da chave no R[4]
14=> x"144A", -- Carrega o valor de R[4]na Memória A[2A]
15=> x"3400", -- Mostra R[4] no LED  

16=> x"F000", -- RUN
17=> x"2500", -- Carrega valor da chave no R[5]
18=> x"1500", -- Carrega o valor de R[5]na Memória A[2B]
19=> x"3500", -- Mostra R[5] no LED

20=> x"F000", -- RUN
21=> x"2600", -- Carrega valor da chave no R[6]
22=> x"162C", -- Carrega o valor de R[6]na Memória A[2C]
23=> x"3600", -- Mostra R[6] no LED  
 
24=> x"F000", -- RUN
25=> x"2700", -- Carrega valor da chave no R[7]
26=> x"172D", -- Carrega o valor de R[7]na Memória A[2D]
27=> x"3700", -- Mostra R[7] no LED
 
28=> x"7F71", -- R[F] recebe R[7] AND R[1] 
29=> x"E000", -- Faz salto se o bit for par
30=> x"B098", -- Vai para o Bloco de instrução dígito ímpar (?)

------------------------------------------ Bloco de instrução dígito par--------------------------------------------

                                                     --2--
31=> x"7F21", -- R[F] recebe R[2] AND R[1] 
32=> x"E000", -- Faz salto se o bit for par
33=> x"B000", -- Vai para a instrução do bit ímpar (?)

-- Instrução do bit par
34 => x"5222", -- R[2] recebe R[2]+R[2]
35 => x"5222", -- R[2] recebe R[2]+R[2]
36 => x"5222", -- R[2] recebe R[2]+R[2]
37 => x"5222", -- R[2] recebe R[2]+R[2]
38 => x"3200", -- LED mostra R[2]
39 => x"F000", -- RUN
-- Instrução do bit ímpar
40 => x"3200", -- LED mostra R[2]
41 => x"F000", -- RUN
                                                     --3--
42=> x"7F31", -- R[F] recebe R[3] AND R[1] 
43=> x"E000", -- Faz salto se o bit for par
44=> x"B000", -- Vai para a instrução do bit ímpar (?)
                                                     
-- Instrução do bit par
45 => x"5333", -- R[3] recebe R[3]+R[3]
46 => x"5333", -- R[3] recebe R[3]+R[3]
47 => x"5333", -- R[3] recebe R[3]+R[3]
48 => x"5333", -- R[3] recebe R[3]+R[3]
49 => x"3300", -- LED mostra R[3]
50 => x"F000", -- RUN
-- Instrução do bit ímpar
51 => x"3300", -- LED mostra R[3]
52 => x"F000", -- RUN
                                                     --4--
53=> x"7F41", -- R[F] recebe R[4] AND R[1] 
54=> x"E000", -- Faz salto se o bit for par
55=> x"B000", -- Vai para a instrução do bit ímpar (?)
                                                     
-- Instrução do bit par
56 => x"5444", -- R[4] recebe R[4]+R[4]
57 => x"5444", -- R[4] recebe R[4]+R[4]
58 => x"5444", -- R[4] recebe R[4]+R[4]
59 => x"5444", -- R[4] recebe R[4]+R[4]
60 => x"3400", -- LED mostra R[4]
61 => x"F000", -- RUN
-- Instrução do bit ímpar
62 => x"3400", -- LED mostra R[4]
63 => x"F000", -- RUN
                                                     --5--
64=> x"7F51", -- R[F] recebe R[5] AND R[1] 
65=> x"E000", -- Faz salto se o bit for par
66=> x"B000", -- Vai para a instrução do bit ímpar (?)
                                                     
-- Instrução do bit par
67 => x"5555", -- R[5] recebe R[5]+R[5]
68 => x"5555", -- R[5] recebe R[5]+R[5]
69 => x"5555", -- R[5] recebe R[5]+R[5]
70 => x"5555", -- R[5] recebe R[5]+R[5]
71 => x"3500", -- LED mostra R[5]
72 => x"F000", -- RUN
-- Instrução do bit ímpar
73 => x"3500", -- LED mostra R[5]
74 => x"F000", -- RUN
                                                     --6--
75=> x"7F61", -- R[F] recebe R[6] AND R[1] 
76=> x"E000", -- Faz salto se o bit for par
77=> x"B000", -- Vai para a instrução do bit ímpar
                                                     
-- Instrução do bit par
78 => x"5666", -- R[6] recebe R[6]+R[6]
79 => x"5666", -- R[6] recebe R[6]+R[6]
80 => x"5666", -- R[6] recebe R[6]+R[6]
81 => x"5666", -- R[6] recebe R[6]+R[6]
82 => x"3600", -- LED mostra R[6]
83 => x"F000", -- RUN
-- Instrução do bit ímpar
84 => x"3600", -- LED mostra R[6]
85 => x"F000", -- RUN	
                                                     --7--
86=> x"7F71", -- R[F] recebe R[7] AND R[1] 
87=> x"E000", -- Faz salto se o bit for par
88=> x"B000", -- Vai para a instrução do bit ímpar
                                                     
-- Instrução do bit par
89 => x"5777", -- R[7] recebe R[7]+R[7]
90 => x"5777", -- R[7] recebe R[7]+R[7]
91 => x"5777", -- R[7] recebe R[7]+R[7]
92 => x"5777", -- R[7] recebe R[7]+R[7]
93 => x"3700", -- LED mostra R[7]
94 => x"F000", -- RUN
-- Instrução do bit ímpar
95 => x"3700", -- LED mostra R[7]
96 => x"F000", -- RUN	
97 => x"B000", -- Vai para o final do programa (?)															  																	  
------------------------------------------ Bloco de instrução dígito ímpar--------------------------------------------
  
                                                     --2--
98=> x"7F21", -- R[F] recebe R[2] AND R[1] 
99=> x"E000", -- Faz salto se o bit for par
100=> x"B000", -- Vai para a instrução do bit ímpar (?)

-- Instrução do bit par
101=> x"3200", -- LED mostra R[2]
102=> x"F000", -- RUN
-- Instrução do bit ímpar
103=> x"5222", -- R[2] recebe R[2]+R[2]
104=> x"5222", -- R[2] recebe R[2]+R[2]
105=> x"5222", -- R[2] recebe R[2]+R[2]
106=> x"5222", -- R[2] recebe R[2]+R[2]
107=> x"3200", -- LED mostra R[2]
108=> x"F000", -- RUN

                                                     --3--
109=> x"7F31", -- R[F] recebe R[3] AND R[1] 
110=> x"E000", -- Faz salto se o bit for par
111=> x"B000", -- Vai para a instrução do bit ímpar  (?)
                                                     
-- Instrução do bit par
112=> x"3300", -- LED mostra R[3]
113=> x"F000", -- RUN
-- Instrução do bit ímpar
114=> x"5333", -- R[3] recebe R[3]+R[3]
115=> x"5333", -- R[3] recebe R[3]+R[3]
116=> x"5333", -- R[3] recebe R[3]+R[3]
117=> x"5333", -- R[3] recebe R[3]+R[3]
118=> x"3300", -- LED mostra R[3]
119=> x"F000", -- RUN
                                                     --4--
120=> x"7F41", -- R[F] recebe R[4] AND R[1] 
121=> x"E000", -- Faz salto se o bit for par
122=> x"B000", -- Vai para a instrução do bit ímpar  (?)
                                                     
-- Instrução do bit par
123=> x"3400", -- LED mostra R[4]
124=> x"F000", -- RUN
-- Instrução do bit ímpar
125=> x"5444", -- R[4] recebe R[4]+R[4]
126=> x"5444", -- R[4] recebe R[4]+R[4]
127=> x"5444", -- R[4] recebe R[4]+R[4]
128=> x"5444", -- R[4] recebe R[4]+R[4]
129=> x"3400", -- LED mostra R[4]
130=> x"F000", -- RUN
                                                     --5--
131=> x"7F51", -- R[F] recebe R[5] AND R[1] 
132=> x"E000", -- Faz salto se o bit for par
133=> x"B000", -- Vai para a instrução do bit ímpar (?)
                                                     
-- Instrução do bit par
134=> x"3500", -- LED mostra R[5]
135=> x"F000", -- RUN
-- Instrução do bit ímpar
136=> x"5555", -- R[5] recebe R[5]+R[5]
137=> x"5555", -- R[5] recebe R[5]+R[5]
138=> x"5555", -- R[5] recebe R[5]+R[5]
139=> x"5555", -- R[5] recebe R[5]+R[5]
140=> x"3500", -- LED mostra R[5]
141=> x"F000", -- RUN
                                                     --6--
142=> x"7F61", -- R[F] recebe R[6] AND R[1] 
143=> x"E000", -- Faz salto se o bit for par
144=> x"B000", -- Vai para a instrução do bit ímpar  (?)
                                                     
-- Instrução do bit par
145=> x"3600", -- LED mostra R[6]
146=> x"F000", -- RUN
-- Instrução do bit ímpar
147=> x"5666", -- R[6] recebe R[6]+R[6]
148=> x"5666", -- R[6] recebe R[6]+R[6]
149=> x"5666", -- R[6] recebe R[6]+R[6]
150=> x"5666", -- R[6] recebe R[6]+R[6]
151=> x"4600", -- LED mostra R[6]
152=> x"F000", -- RUN	
                                                     --7--
153=> x"7F71", -- R[F] recebe R[7] AND R[1] 
154=> x"E000", -- Faz salto se o bit for par
155=> x"B000", -- Vai para a instrução do bit ímpar  (?)
                                                     
-- Instrução do bit par
156=> x"3700", -- LED mostra R[7]
157=> x"F000", -- RUN
-- Instrução do bit ímpar
158=> x"5777", -- R[7] recebe R[7]+R[7]
159=> x"5777", -- R[7] recebe R[7]+R[7]
160=> x"5777", -- R[7] recebe R[7]+R[7]
161=> x"5777", -- R[7] recebe R[7]+R[7]
162=> x"3700", -- LED mostra R[7]
163=> x"F000", -- RUN

--------------------------------------------- Bloco de finalização---------------------------------------------------

164=> x"4FFF", -- Carrega R[F] com o valor FF
165=> x"3F00", -- LED mostra R[F]
166=> x"F000", -- RUN
167=> x"B000", -- salta para o início reiniciando o programa

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