----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:53:56 04/10/2023 
-- Design Name: 
-- Module Name:    Comparator - Behavioral 
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

entity Comparator is
    Port ( sel1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel2 : in  STD_LOGIC_VECTOR (4 downto 0);
           comp_out : out  STD_LOGIC);
end Comparator;

architecture Behavioral of Comparator is

begin

process(sel1,sel2)

begin

	 if sel1 = sel2 then
		comp_out <= '1';
	 else 
		comp_out <= '0';
		
	 end if;
	 
end process;

end Behavioral;

