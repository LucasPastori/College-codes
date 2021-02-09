-------------------------------------------------------------------------------
-- Company : FEI
-- Site : Sao Bernardo
-------------------------------------------------------------------------------
-- Title :debounce
-- Project :VHDL
-------------------------------------------------------------------------------
-- File : debounce.vhd
-- Author : Pedro Luiz Benko
-- Created : 25/08/2011 (d/m/y)
-------------------------------------------------------------------------------
-- Description :
-- realiza debounce de chave push-button em ambos sentidos "0->1" e "1->0" 
-- Para simulação: contador<=2; para download contador<=500000;
--
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
--
ENTITY debounce IS
		PORT(
				pb, clock, reset: IN  STD_LOGIC;
				pb_rise			: OUT STD_LOGIC);
END debounce;

ARCHITECTURE a OF debounce IS
	SIGNAL SHIFT_PB		: STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal state		: STD_LOGIC;
	signal cke			: STD_LOGIC;
	signal previous		: STD_LOGIC;
	signal pb_debounced	: STD_LOGIC;
	signal contador		: integer range 0 to 1000000; 
BEGIN
-- Clock enable de ~ 32msec. 
PROCESS(clock,reset)
	BEGIN
	if reset='0' then state<='0'; pb_debounced<='0';
	elsif clock'event and clock='1' then
		IF cke = '1' THEN
-- Usa um shift register para filtro de-bounce de contatos		
  		SHIFT_PB(2) <= PB;
		SHIFT_PB(1 DOWNTO 0) <= SHIFT_PB(2DOWNTO 1);
	  		case shift_pb is
			when "000" =>
				state <= '0';
			when "111" =>
				state <= '1';
			when others =>
				state <= state;
		end case;
		pb_debounced <= state;
		END IF;
	end if;
END PROCESS;
----------------------------------------------------------------------------------
PROCESS(clock,reset)-- gera um pulso de clock enable, detecta borda de subida
	Begin
	if reset = '0' then
		previous <= '1';
		pb_rise <= '0';
	elsif clock'event and clock = '1' then
		if previous = '0' and pb_debounced = '1' then
			pb_rise <= '1';
		else
			pb_rise <= '0';
		end if;
		previous <= pb_debounced;
	end if;
	end process;
 --------------------------------------------------------------------------------- 
process(clock, reset)-- timing de 10 mseg
	begin
 if reset='0' then
	contador<=0;
	cke<='0';
 elsif clock'event and clock='1' then
		if contador=1 then -- 1000000 gera 10 mseg
		cke<='1';
		contador<=0;
		else
		cke<='0';
		contador<=contador+1;
		end if;
 end if;
end process; 
END a;
