--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:11:16 05/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/MEMORY_UNIT_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMORY_UNIT
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEMORY_UNIT_test IS
END MEMORY_UNIT_test;
 
ARCHITECTURE behavior OF MEMORY_UNIT_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMORY_UNIT
    PORT(
         a : IN  std_logic_vector(9 downto 0);
         d : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         we : IN  std_logic;
         ByteFlag : IN  std_logic;
         mem_data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(9 downto 0) := (others => '0');
   signal d : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal we : std_logic := '0';
   signal ByteFlag : std_logic := '0';

 	--Outputs
   signal mem_data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMORY_UNIT PORT MAP (
          a => a,
          d => d,
          clk => clk,
          we => we,
          ByteFlag => ByteFlag,
          mem_data_out => mem_data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      we <= '1';
		a  <= "0000000001";
		d  <= (others => '1');
		ByteFlag <= '0';
		
		wait for 10 ns;
		we <= '0';
		ByteFlag <= '1';
		
		wait for 10 ns;
		a <= "0000000000";
		ByteFlag <= '0';

      wait;
   end process;

END;
