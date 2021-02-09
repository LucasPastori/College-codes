--********************************************************************************
-- SDIII Proj2 _FEI
-- Componente VHDL: Unidade lógica aritmética ALU => ALU_1.vhd
-- Prof. Pedro L. Benko - 08/2011
-- Rev. 0
-- Especificações: entrada: REGb(7:0), REGc(7:0), ALU_op(2:0), clock, reset
--				   saidas : REGa(7:0), Flag, Zero, Carry
-- ALU realiza as seguintes operações: adição, subtração, and , xor, or, not
-- ALU gera os seguites flags setados em 1 por operação: 
-- STATUS(0)	Zero  ( resultado operação = 0 )
-- STATUS(1)	Carry ( estouro vai 1 na soma )
-- STATUS(2)	Flag  ( operação subtração -> sinal negativo ) 
-- *se o operando não válido ALU_op(2:0), os valores dos flags não se alteram
--********************************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity ALU_1 is
   port
   (
      REGb, REGc 	: in std_logic_vector(7 downto 0);
      ALU_op		: in std_logic_vector(2 downto 0);
      clock,reset	: in std_logic;
	  STATUS		: out std_logic_vector(7 downto 0);
      REGa			: out std_logic_vector(7 downto 0)
   );
end entity ALU_1;
 
architecture Behavioral of ALU_1 is
   signal Temp: std_logic_vector(8 downto 0);
 begin
   process(clock,reset) is-- REGb, REGc, Operation, temp
   begin
   if reset='0' then
   Temp <="000000000";
   STATUS(2) <= '0'; STATUS(0)<='0'; 
   elsif clock'event and clock='1' then
      case ALU_op is
         when "000" => -- REGa = REGb + REGc, flag = STATUS(1) = overflow
            if (REGb = "00000000" and REGc = "00000000") then
				Temp(7 downto 0)<="00000000";
				STATUS(0)<='1';
				STATUS(2)<='0';
				Temp(8)<='0';
			else
				Temp <= std_logic_vector((unsigned("0" & REGb) + unsigned(REGc)));
				STATUS(2) <= '0';
                STATUS(0) <= '0';
			end if;
         when "001" => -- REGa = |REGb - REGc|, STATUS(2) = 1 if REGc > REGb
            if (REGb > REGc) then
               Temp(7 downto 0) <= std_logic_vector(unsigned(REGb) - unsigned(REGc));
               STATUS(2) <= '0';
               STATUS(0) <= '0';
               Temp(8)<='0';
            elsif (REGb = REGc) then
			   Temp(7 downto 0)<="00000000";
			   STATUS(0)<='1';
			   STATUS(2)<='0';
			   Temp(8)<='0';
			elsif (REGb < REGc) then
               Temp(7 downto 0) <= std_logic_vector(unsigned(REGc) - unsigned(REGb));
               STATUS(2) <= '1';
               STATUS(0) <= '0';
               Temp(8)<='0';	
            end if;
         when "010" => -- and
			if (REGb and REGc) = "00000000" then
				Temp(7 downto 0)<="00000000";
				STATUS(0)<='1';
				Temp(8)<='0';
				STATUS(2) <= '0';
			else
				Temp(7 downto 0) <= REGb and REGc;
				STATUS(0)<='0';
				STATUS(2) <= '0';
				Temp(8)<='0';
			end if;
         when "011" => -- or
			if (REGb or REGc) = "00000000" then
				Temp(7 downto 0)<="00000000";
				STATUS(0)<='1';
				STATUS(2) <= '0';
				Temp(8)<='0';
			else
				Temp(7 downto 0) <= REGb or REGc;
				STATUS(0)<='0';
				STATUS(2) <= '0';
				Temp(8)<='0';
			end if;
         when "100" => -- xor
			if (REGb xor REGc) = "00000000" then
				Temp(7 downto 0)<="00000000";
				STATUS(0)<='1';
				STATUS(2) <= '0';
				Temp(8)<='0';
			else
				Temp(7 downto 0)<= REGb xor REGc;
				STATUS(0)<='1';
				STATUS(2) <= '0';
				Temp(8)<='0';
			end if;
         when "101" =>
			if (not REGb = "00000000") then
			STATUS(0)<='1';
            STATUS(2) <= '0';
			Temp(8)<='0';
			Temp(7 downto 0) <= not REGb;-- ******coloquei depois  - tst
			else
            Temp(7 downto 0) <= not REGb;
            STATUS(0)<='0';
            STATUS(2) <= '0';
			Temp(8)<='0';
			end if;
         when others => null; -- REGa = REGb + REGc + 1, STATUS(2) = 0
            Temp <= Temp;
      end case;
      end if;      
   end process;
 REGa  <= Temp(7 downto 0);
 STATUS(1) <= Temp(8);   
end architecture Behavioral;