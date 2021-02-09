----------------------------------------------------------------------------------
-- Proj2 - processador simplificado - FEI
-- Prof. Pedro L. Benko
-- Program Counter - 07/2011 
-- PCounter.vhd
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PCounter is
port(clock	: in std_logic;-- clock
	 PCld	: in std_logic; -- enable para carga de offset
	 PCinc	: in std_logic;-- enable para incrementar o PCounter
	 PCclr	: in std_logic;-- reset
	 PCin	: in std_logic_vector(7 downto 0);-- entrada de off-set
	 PCout	: out std_logic_vector(7 downto 0)-- saida do PCounter
);
end PCounter;
architecture behv of PCounter is
signal tmp_PC: std_logic_vector(7 downto 0);
begin
process(clock, PCclr)
begin
	if PCclr='1' then
	tmp_PC <= "00000000";
	elsif (clock'event and clock = '1') then
	  if PCld='1' then
		tmp_PC <= PCin;
	  elsif (PCld='0' and PCinc = '1') then
	    tmp_PC <= tmp_PC + 1;
	  else
		tmp_PC<=tmp_PC;
	  end if;
	end if;
end process;
PCout <= tmp_PC;
end behv;