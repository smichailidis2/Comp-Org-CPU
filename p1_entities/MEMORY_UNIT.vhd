----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:57:45 05/08/2024 
-- Design Name: 
-- Module Name:    MEMORY_UNIT - Behavioral 
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

entity MEMORY_UNIT is
    Port ( a : in  STD_LOGIC_VECTOR (9 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
           ByteFlag : in  STD_LOGIC;
           mem_data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMORY_UNIT;

architecture Behavioral of MEMORY_UNIT is

component MEMSTAGE is
	Port (a : in std_logic_vector(9 downto 0);
			d : in std_logic_vector(31 downto 0);
			clk : in std_logic;
			we : in std_logic;
			spo : out std_logic_vector(31 downto 0));
end component;	

component MUX2 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC);
end component;


signal memory_word_out : std_logic_vector(31 downto 0);
signal memory_byte_out : std_logic_vector(31 downto 0);

begin

memory_byte_out <= "000000000000000000000000" & memory_word_out(7 downto 0);

RAM : MEMSTAGE port map(a => a,
								d => d,
								we => we,
								clk => clk,
								spo => memory_word_out);
								
mux_32b : MUX2 port map(In0 => memory_word_out,
								In1 => memory_byte_out,
								Mux_out => mem_data_out,
								SEL => ByteFlag);


end Behavioral;

