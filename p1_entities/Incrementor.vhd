----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:55 05/04/2024 
-- Design Name: 
-- Module Name:    Incrementor - Behavioral 
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

entity Incrementor is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Out0 : out  STD_LOGIC_VECTOR (31 downto 0));
end Incrementor;

architecture Behavioral of Incrementor is

begin

process(In0)
begin
Out0 <= In0 + "00000000000000000000000000000010";
end process;

end Behavioral;

