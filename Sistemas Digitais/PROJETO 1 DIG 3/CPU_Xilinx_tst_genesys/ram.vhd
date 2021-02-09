-- SDIII Proj2 _FEI
-- Componente VHDL:  memoria ram de 256 x 8 => ram.vhd
-- Prof. Pedro L. Benko - 07/2011
-- Rev 0
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Use ieee.numeric_std.all;

ENTITY RAM is 
--	GENERIC(
---		     Td: TIME:=40ns);		-- retardo de leitura
		    
	PORT( datain  : in  std_logic_vector(7 downto 0); -- entrada de dados na ram
		  Addram  : in  std_logic_vector(7 downto 0);  -- endereço da ram (ponteiro)
		  dataout : out std_logic_vector(7 downto 0);  -- saida de dados da ram
		  rdram, wrram, clk: in std_logic); -- comando escrita e leitura
    end RAM;
    
Architecture behavioral of RAM is
Subtype wordT is std_logic_vector(7 downto 0); -- word da ram
Type storageT is ARRAY(0 to 255) of wordT; 	   -- conjunto de words da ram
signal memory: storageT;
----------------------------------------------------------------------------------
begin
	process(clk, wrram, rdram) -- escrita
	begin
	if clk'event and clk='1' and wrram='1' and rdram='0' then
	 memory(conv_integer(unsigned(Addram))) <= datain; -- dado de entrada armazenado no
	end if;									                  -- endereço apontado por A
	end process;
--
	process(clk, wrram, rdram) -- leitura
	begin
	if clk'event and clk='1' and rdram='1' and wrram='0' then
	 dataout <= memory(conv_integer(unsigned(Addram))); -- removi ))) after Td
	end if;
	end process;
end behavioral; 