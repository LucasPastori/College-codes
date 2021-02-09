----------------------------------------------------------------------------------
-- Projeto: Processador simplificado
-- modulo: Entrada chaves / saidas leds - placa Starter KIT Spartan 3 Xilinx
-- Prof. Pedro l. benko - FEI - 2011
-- quatro 8-bit inputs and one 8-bit output
-- IO.vhd
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity ES is
	port( chaves	: in std_logic_vector(7 downto 0);
		  Regs		: in std_logic_vector(7 downto 0);
		  clock		: in std_logic;
		  reset		: in std_logic;
		  en_in		: in std_logic;
		  en_out	: in std_logic;
		  IO_entrada: out std_logic_vector(7 downto 0);
		  Leds		: out std_logic_vector(7 downto 0)
);
end ES;
architecture behv of ES is
begin
process(clock, reset)
begin
if reset='0' then
leds <= "00001111"; IO_entrada<="00000000";
elsif clock'event and clock='1' then
 if en_in = '1' and en_out = '0' then
	IO_entrada<=chaves;
 elsif en_in = '0' and en_out = '1' then
	Leds<=Regs;
 end if;
end if;
end process;
end behv;
	
