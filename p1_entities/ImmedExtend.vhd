----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:34 04/29/2024 
-- Design Name: 
-- Module Name:    ImmedExtend - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ImmedExtend is
    Port ( Immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed_signExt : out  STD_LOGIC_VECTOR (31 downto 0));
end ImmedExtend;

architecture Behavioral of ImmedExtend is

begin
process(Opcode,Immediate)
begin
-- if operation is andi / ori then zero fill
-- if operation is li / addi then sign extend

-- Operation: andi / ori
if Opcode = "110010" or Opcode = "110011" then
	Immed_signExt(31 downto 16) <= "0000000000000000";
	Immed_signExt(15 downto  0) <= Immediate;
-- Operation: li / addi
elsif Opcode = "111000" or Opcode = "110000" then
	if Immediate(15) = '1' then
		Immed_signExt(31 downto 16) <= "1111111111111111";
		Immed_signExt(15 downto  0) <= Immediate;
	else
		Immed_signExt(31 downto 16) <= "0000000000000000";
		Immed_signExt(15 downto  0) <= Immediate;
	end if;
--Operation: lui
elsif Opcode = "111001" then
	Immed_signExt(31 downto 16) <= Immediate;
	Immed_signExt(15 downto  0) <= "0000000000000000";
--Opreation: B / beq / bne
elsif Opcode = "111111" or Opcode = "010000" or Opcode = "010001" then
	if Immediate(15) = '1' then
		Immed_signExt(31 downto 18) <= "11111111111111";
		Immed_signExt(17 downto  2) <= Immediate;
		Immed_signExt(1  downto  0) <= "00";
	else
		Immed_signExt(31 downto 18) <= "00000000000000";
		Immed_signExt(17 downto  2) <= Immediate;
		Immed_signExt(1  downto  0) <= "00";
	end if;
--Operation: Lb / Sb / Lw / Sw
elsif Opcode = "000011" or Opcode = "000111" or Opcode = "001111" or Opcode = "011111" then
	Immed_signExt(31 downto 16) <= (others => Immediate(15) );
	Immed_signExt(15 downto  0) <= Immediate;
else
	Immed_signExt <= (others => '0');  -- Default case for safety
end if;
end process;



end Behavioral;

