----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:56:17 05/07/2024 
-- Design Name: 
-- Module Name:    ComputeUnit - Behavioral 
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

entity ComputeUnit is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end ComputeUnit;

architecture Behavioral of ComputeUnit is

component CONTROL is
        Port( INSTRUCTION : in  STD_LOGIC_VECTOR (31 downto 0);
				  CONTROL_OUT : out STD_LOGIC_VECTOR (15 downto 0);
				  clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  ALU_zero : in STD_LOGIC);
end component;

component DATAPATH is
        Port( clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;	 
				  CONTROL_OUT: in STD_LOGIC_VECTOR (15 downto 0);
				  Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
				  ALU_zero : out STD_LOGIC);
end component;


-- control signal
signal CONTROL_OUT: STD_LOGIC_VECTOR (15 downto 0);


-- instruction
signal instruction : std_logic_vector(31 downto 0);
signal zero_flag 	 : std_logic;

begin


sc_datapath: DATAPATH Port map( clk => clk,
										  rst => rst,
										  CONTROL_OUT => CONTROL_OUT,
										  Instruction => instruction,
										  ALU_zero => zero_flag);
										  
										  
sc_control: CONTROL Port map ( INSTRUCTION => instruction,
										 CONTROL_OUT => CONTROL_OUT,
										 clk => clk,
										 rst => rst,
										 ALU_zero => zero_flag);


end Behavioral;

