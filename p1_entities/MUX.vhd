----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:03 04/10/2023 
-- Design Name: 
-- Module Name:    MUX32 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX32 is
    Port ( R0  : in  STD_LOGIC_VECTOR (31 downto 0);
           R1  : in  STD_LOGIC_VECTOR (31 downto 0);
           R2  : in  STD_LOGIC_VECTOR (31 downto 0);
           R3  : in  STD_LOGIC_VECTOR (31 downto 0);
           R4  : in  STD_LOGIC_VECTOR (31 downto 0);
           R5  : in  STD_LOGIC_VECTOR (31 downto 0);
           R6  : in  STD_LOGIC_VECTOR (31 downto 0);
           R7  : in  STD_LOGIC_VECTOR (31 downto 0);
           R8  : in  STD_LOGIC_VECTOR (31 downto 0);
           R9  : in  STD_LOGIC_VECTOR (31 downto 0);
           R10 : in  STD_LOGIC_VECTOR (31 downto 0);
           R11 : in  STD_LOGIC_VECTOR (31 downto 0);
           R12 : in  STD_LOGIC_VECTOR (31 downto 0);
           R13 : in  STD_LOGIC_VECTOR (31 downto 0);
           R14 : in  STD_LOGIC_VECTOR (31 downto 0);
           R15 : in  STD_LOGIC_VECTOR (31 downto 0);
           R16 : in  STD_LOGIC_VECTOR (31 downto 0);
           R17 : in  STD_LOGIC_VECTOR (31 downto 0);
           R18 : in  STD_LOGIC_VECTOR (31 downto 0);
           R19 : in  STD_LOGIC_VECTOR (31 downto 0);
           R20 : in  STD_LOGIC_VECTOR (31 downto 0);
           R21 : in  STD_LOGIC_VECTOR (31 downto 0);
           R22 : in  STD_LOGIC_VECTOR (31 downto 0);
           R23 : in  STD_LOGIC_VECTOR (31 downto 0);
           R24 : in  STD_LOGIC_VECTOR (31 downto 0);
           R25 : in  STD_LOGIC_VECTOR (31 downto 0);
           R26 : in  STD_LOGIC_VECTOR (31 downto 0);
           R27 : in  STD_LOGIC_VECTOR (31 downto 0);
           R28 : in  STD_LOGIC_VECTOR (31 downto 0);
           R29 : in  STD_LOGIC_VECTOR (31 downto 0);
           R30 : in  STD_LOGIC_VECTOR (31 downto 0);
           R31 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC_VECTOR (4 downto 0);
           D_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32;

architecture Behavioral of MUX32 is

begin

with SEL select
	
	D_OUT <= R0  when "00000",
				R1  when "00001",
			   R2  when "00010",
				R3  when "00011",
				R4  when "00100",
				R5  when "00101",
				R6  when "00110",
				R7  when "00111",
				R8  when "01000",
				R9  when "01001",
				R10 when "01010",
				R11 when "01011",
				R12 when "01100",
				R13 when "01101",
				R14 when "01110",
				R15 when "01111",
				R16 when "10000",
				R17 when "10001",
				R18 when "10010",
				R19 when "10011",
				R20 when "10100",
				R21 when "10101",
				R22 when "10110",
				R23 when "10111",
				R24 when "11000",
				R25 when "11001",
				R26 when "11010",
				R27 when "11011",
				R28 when "11100",
				R29 when "11101",
				R30 when "11110",
				R31 when "11111",
				"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" when others;

end Behavioral;

