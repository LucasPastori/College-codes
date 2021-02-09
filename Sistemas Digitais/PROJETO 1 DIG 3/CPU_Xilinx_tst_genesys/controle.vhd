----------------------------------------------------------------------------------
-- Proj2: Processador simplificado - FEI
-- Prof. Pedro L. Benko - SDIII - 07/2011
-- Bloco de controle - Maquina de estado (fsm)
-- módulo: controle.vhd 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--
entity controle is
port(	clock: in std_logic;
		rst: in std_logic;
		Run: in std_logic; -- tira o processador de halt
		Instrucao_word:in std_logic_vector(15 downto 0); -- Instr[15:8]
-- MUX
		mux_crtl  : out std_logic_vector(1 downto 0);
-- regs
		RFwa_crtl : out std_logic_vector(3 downto 0);
		RFr1a_crtl: out std_logic_vector(3 downto 0);
		RFr2a_crtl: out std_logic_vector(3 downto 0);
		RFwe_crtl:  out std_logic;
		RFr1e_crtl: out std_logic;
		RFr2e_crtl: out std_logic;
-- IO
		ENin_crtl  : out std_logic;
		ENout_crtl : out std_logic;	
-- ALU
		ALUop_crtl: out std_logic_vector(2 downto 0);
		Status_crtl:in std_logic_vector(7 downto 0);-- status[7:0]
-- Pcounter
		PCinc_ctrl:  out std_logic;
		PCclr_ctrl:	 out std_logic;
		PCload_crtl: out std_logic;
-- RAM
		RDram_crtl:out std_logic;
		WRram_crtl:out std_logic;
-- PROM
		Mre_ctrl: out std_logic);
end controle;
----------------------------------------------------------------------------------
architecture fsm of controle is
type state_type is (S0,S1,S2,S3,S4,S4a,S4b,S5,S5a,S5b,
S6,S6a,S6b,S7,S7a,S7b,S8, S8a,S8b,S9, S9a, S9b,S9c,S10,S10a,S10b,S10c,
S11,S11a,S11b,S11c,S12, S12a,S12b,S12c,S13,S13a,S13b,S13c,S14,S14a,S14b,S14c,
S15, S16,S16a,S17,S17a,S18,S18a,S19);
signal state: state_type;
begin
process(clock, rst)
variable OPCODE: std_logic_vector(3 downto 0);
begin
if rst='0' then
mux_crtl <= "11"; -- mux
PCclr_ctrl <= '1'; -- Reset State
PCinc_ctrl <= '0'; -- Pcounter
PCload_crtl <= '0';  --
RFwa_crtl <= "0000"; --regs
RFr1a_crtl <= "0000";--
RFr2a_crtl <= "0000";--
RFwe_crtl <= '0';--
RFr1e_crtl <= '0';--
RFr2e_crtl <= '0';--
Mre_ctrl <= '0';-- prom
RDram_crtl <= '0'; -- ram
WRram_crtl <= '0'; -- ram
ALUop_crtl <= "111";-- não faz nada
ENin_crtl <= '0';
ENout_crtl<= '0';
state <= S0;
----------------------------------------------------------------------------------
elsif (clock'event and clock='1') then
 case state is
	when S0 => 	PCclr_ctrl <= '0'; -- Reset State
				state <= S1;
	when S1 => 	PCinc_ctrl <= '0'; 	-- Fetch Instruction
				PCload_crtl <= '0';
				Mre_ctrl <= '1'; 	-- enable instrução prom
				state <= S2;
	when S2 =>  Mre_ctrl <= '0';
				state <= S3;		-- Fetch end ..
	when S3 => OPCODE := instrucao_word(15 downto 12);-- instruções
				case OPCODE is
					when "0000" => state <= S4;-- MOV R,d
					when "0001" => state <= S5;-- MOV d,R
					when "0010" => state <= S6;-- IN R,ch
					when "0011"	=> state <= S7;-- OUT Led,R
					when "0100" => state <= S8;-- MOV R,c
					when "0101" => state <= S9;-- ADD Ra,Rb,Rc
					when "0110" => state <= S10;-- SUB Ra,Rb,Rc
					when "0111" => state <= S11;--AND Ra,Rb,Rc
					when "1000" => state <= S12;--XOR Ra,Rb,Rc
					when "1001" => state <= S13;--OR  Ra,Rb,Rc
					when "1010" => state <= S14;--NOT
					when "1011" => state <= S15;--goto PCounter address
					when "1100" => state <= S16;--JMPC jump se carry
					when "1101" => state <= S17;--JMPF jump se flag negativo
					when "1110" => state <= S18;--JMPZ jump se zero
					when "1111" => state <= S19;--HALT
					when others => state <= S1;
				end case;
----------------------------------------------------------------------------------
	when S4 =>  -- mov R,d [add4] Mem[add8]
				RFwa_crtl <= instrucao_word(11 downto 8); -- coloca o address do REG
				mux_crtl <= "00"; -- seleciona mux canal ram
				RDram_crtl <= '1'; -- habilita leitura da ram
				state <= S4a;
	when S4a => RFwe_crtl <= '1'; -- habilita a escrita no REG
				state <= S4b;
	when S4b => RFwe_crtl <= '0'; -- desabilita escrita no REG
--				mux_crtl <= "11"; -- desabilita MUX
				RDram_crtl <= '0'; -- desabilita leitura da ram
				PCinc_ctrl <='1'; -- hab inc.  Pcounter (proxima instr.)
				state <= S1; -- 
----------------------------------------------------------------------------------
	when S5 => -- mov d,R [add4] Mem[add8]
				RFr1a_crtl <= instrucao_word(11 downto 8); -- seleciona o REG (address)
				RFr1e_crtl <= '1'; -- habilita leitura do REG
				state <= S5a; 
	when S5a => WRram_crtl<='1'; -- habilita escrita na ram 
				state <= S5b; 	 -- write na ram
	when S5b => WRram_crtl <='0';
				RFr1e_crtl<= '0';	-- desabilita leitura do REG 
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)
				state <= S1; --
---------------------------------------------------------------------------------
	when S6 => -- entra com sinais de chaves IO
				RFwa_crtl<= instrucao_word(11 downto 8); -- sel address do REG
				mux_crtl<= "10";
				ENin_crtl<='1';
				state<=S6a;
	when S6a =>	RFWe_crtl<='1';
				state<=S6b;
	when S6b =>	RFWe_crtl<='0';
--				mux_crtl<= "11";
				ENin_crtl<='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)
				state <= S1; -- 
---------------------------------------------------------------------------------
	when S7 => -- sai com sinais para Leds IO
				RFr1a_crtl<= instrucao_word(11 downto 8); -- sel address do REG
				RFr1e_crtl<='1';
				state <= S7a;
	when S7a => ENout_crtl <='1';
				state <= S7b;
	when S7b => RFr1e_crtl<='0';
				ENout_crtl<='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)
				state <= S1; -- fim
---------------------------------------------------------------------------------
	when S8 => -- Mov R, constante
				RFwa_crtl<= instrucao_word(11 downto 8); -- sel address do REG
				mux_crtl<= "11"; -- habilita canal do mux
				state <= s8a;
	when S8a => RFwe_crtl <='1';
				state <= S8b;
	when S8b => RFwe_crtl<='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)	
				state <= S1; --fim 
----------------------------------------------------------------------------------
	when S9 => -- ADD RB + RC => RA
				RFr1a_crtl <= instrucao_word(3 downto 0); -- sel address do REG
				RFr2a_crtl <= instrucao_word(7 downto 4); -- sel address do REG
				RFr1e_crtl <='1';
				RFr2e_crtl <='1';
				state <= S9a;
	when S9a => ALUop_crtl <="000";
				mux_crtl <= "01";
				RFwa_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				state <= S9b;
	when S9b =>	RFwe_crtl <= '1';
				RFr1e_crtl <='0';
				RFr2e_crtl <='0';
				ALUop_crtl <="111";
				state <= S9c;
	when S9c => RFwe_crtl <='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)				
				state <= S1; -- fim 
----------------------------------------------------------------------------------
	when S10 => -- SUB RB - RC => RA
				RFr1a_crtl <= instrucao_word(7 downto 4); -- sel address do REGb
				RFr2a_crtl <= instrucao_word(3 downto 0); -- sel address do REGc
				RFr1e_crtl <='1';
				RFr2e_crtl <='1';
				state <= S10a;
	when S10a => ALUop_crtl <="001";
				mux_crtl <= "01";
				RFwa_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				state <= S10b;
	when S10b =>RFwe_crtl <= '1';
				RFr1e_crtl <='0';
				RFr2e_crtl <='0';
				ALUop_crtl <="111";
				state <= S10c;
	when S10c => RFwe_crtl <='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)				
				state <= S1; -- fim
----------------------------------------------------------------------------------
	when S11 =>  -- AND RB , RC => RA
				RFr1a_crtl <= instrucao_word(3 downto 0); -- sel address do REG
				RFr2a_crtl <= instrucao_word(7 downto 4); -- sel address do REG
				RFr1e_crtl <='1';
				RFr2e_crtl <='1';
				state <= S11a;
	when S11a => ALUop_crtl <="010";
				mux_crtl <= "01";
				RFwa_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				state <= S11b;
	when S11b =>RFwe_crtl <= '1';
				RFr1e_crtl <='0';
				RFr2e_crtl <='0';
				ALUop_crtl <="111";
				state <= S11c;
	when S11c => RFwe_crtl <='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)				
				state <= S1; -- fim
----------------------------------------------------------------------------------
	when S12 =>   -- XOR RB , RC => RA
				RFr1a_crtl <= instrucao_word(3 downto 0); -- sel address do REG
				RFr2a_crtl <= instrucao_word(7 downto 4); -- sel address do REG
				RFr1e_crtl <='1';
				RFr2e_crtl <='1';
				state <= S12a;
	when S12a => ALUop_crtl <="100";
				mux_crtl <= "01";
				RFwa_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				state <= S12b;
	when S12b =>RFwe_crtl <= '1';
				RFr1e_crtl <='0';
				RFr2e_crtl <='0';
				ALUop_crtl <="111";
				state <= S12c;
	when S12c => RFwe_crtl <='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)				
				state <= S1; -- fim
----------------------------------------------------------------------------------
	when S13 =>    -- OR RB , RC => RA
				RFr1a_crtl <= instrucao_word(3 downto 0); -- sel address do REG
				RFr2a_crtl <= instrucao_word(7 downto 4); -- sel address do REG
				RFr1e_crtl <='1';
				RFr2e_crtl <='1';
				state <= S13a;
	when S13a => ALUop_crtl <="011";
				mux_crtl <= "01";
				RFwa_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				state <= S13b;
	when S13b =>RFwe_crtl <= '1';
				RFr1e_crtl <='0';
				RFr2e_crtl <='0';
				ALUop_crtl <="111";
				state <= S13c;
	when S13c => RFwe_crtl <='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)				
				state <= S1; -- fim	
----------------------------------------------------------------------------------
	when S14 => --NOT REGa -> REGa
				RFr1a_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				mux_crtl <= "01";
				RFr1e_crtl<='1';
				state <= S14a;
	when S14a =>ALUop_crtl <="101";
				RFwa_crtl <= instrucao_word(11 downto 8); -- sel address do REG
				state <= S14b;
	when S14b =>RFwe_crtl <= '1';
				RFr1e_crtl<='0';
				ALUop_crtl <="111";
				state <= S14c;
	when S14c =>RFwe_crtl <='0';
				PCinc_ctrl <='1';	-- hab inc.  Pcounter (proxima instr.)				
				state <= S1; -- fim	
----------------------------------------------------------------------------------
	when S15 => -- goto Pc[7..0]
				PCload_crtl <= '1';
				state <= S1; -- fim	
----------------------------------------------------------------------------------
	when S16 => -- JMP carry pcounter <= pcounter+2
				if Status_crtl(1) = '1' then 
				PCinc_ctrl <='1';
				state <= S16a;
				else
				PCinc_ctrl <= '0';
				state <= S16a;
				end if;
	when S16a =>PCinc_ctrl<='1';-- PCinc permanece por 2 clocks -> incrementa 2X
				state <= S1; -- fim 
----------------------------------------------------------------------------------
	when S17 =>  -- JMP Flag negativo pcounter <= pcounter+2
				if Status_crtl(2) = '1' then 
				PCinc_ctrl <='1';
				state <= S17a;
				else
				PCinc_ctrl <= '0';
				state <= S17a;
				end if;
 	when S17a =>PCinc_ctrl<='1';-- PCinc permanece por 2 clocks -> incrementa 2X
				state <= S1; -- fim 
----------------------------------------------------------------------------------
	when S18 => -- JMP Flag Zero pcounter <= pcounter+2
				if Status_crtl(0) = '1' then 
				PCinc_ctrl <='1';
				state <= S18a;
				else
				PCinc_ctrl <= '0';
				state <= S18a;
				end if;
	when S18a =>state <= S1; -- PCinc permanece por 2 clocks -> incrementa 2X
				PCinc_ctrl<='1';-- fim
 
----------------------------------------------------------------------------------
	when S19 =>  -- halt / run
				if run='0' then
				PCinc_ctrl <='0';
				RFwe_crtl <= '0';--
				RFr1e_crtl <= '0';--
				RFr2e_crtl <= '0';--
				ALUop_crtl <= "111";-- não faz nada
				ENin_crtl <= '0';
				ENout_crtl<= '0';
				state <= S19;
				else
				PCinc_ctrl <='1';
				state<=S1;
				end if;
				
----------------------------------------------------------------------------------
	when others =>
 end case;
end if;
end process;
end fsm;
