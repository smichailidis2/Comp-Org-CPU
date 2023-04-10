----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:07 04/10/2023 
-- Design Name: 
-- Module Name:    Register - Behavioral 
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

entity Register is
    Port ( clk : in  STD_LOGIC;
           DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end Register;

architecture Behavioral of Register is

begin

process
begin

wait until clk'EVENT AND clk='1';

	case rst is
		when '1' =>
			DataOUT <= "0000_0000_0000_0000_0000_0000_0000_0000";
		when '0' =>
			if WE = 1 then
				DataOUT <= DataIN;
			else
				DataOUT <= "0000_0000_0000_0000_0000_0000_0000_0000";
			end if;
		end if;
	end case;

end process;

end Behavioral;

