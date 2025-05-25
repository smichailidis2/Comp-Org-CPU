
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register_comp5 is
    Port ( clk : in  STD_LOGIC;
           DataIN : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end Register_comp5;

architecture Behavioral of Register_comp5 is

signal tmp : std_logic_vector(4 downto 0) := "00000";

begin

process
begin

wait until clk'EVENT AND clk='1';

	case rst is
		when '1' =>
			tmp <= "00000";
		when '0' =>
			if WE='1' then
				tmp <= DataIN;
			end if;
		when others =>
			tmp <= "XXXXX";
	end case;

end process;

DataOUT <= tmp;

end Behavioral;

