--------------------------------------------------------
-- Projeto: Processador simplificado
-- modulo: multiplex 4 x 1
-- Prof. Pedro l. benko - FEI - 2011
-- quatro 8-bit inputs and one 8-bit output
-- mux_cpu.vhd
--------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity mux_cpu is
	port( mem		: in std_logic_vector(7 downto 0);
		  ES		: in std_logic_vector(7 downto 0);
		  ALU_REGa	: in std_logic_vector(7 downto 0);
		  instrucao	: in std_logic_vector(7 downto 0);
		  sel_mux	: in std_logic_vector(1 downto 0);
		  Muxout	: out std_logic_vector(7 downto 0)
);
end mux_cpu;
architecture behv of mux_cpu is
begin
process(mem, ES, ALU_REGa, instrucao, sel_mux)
begin
case sel_mux is
	when "00" => Muxout <= mem;
	when "01" => Muxout <=ALU_REGa;
	when "10" => Muxout <= ES;
	when "11" => Muxout <= instrucao;
	when others =>
end case;
end process;
end behv;