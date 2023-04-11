--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:37:04 04/11/2023
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/Comparator_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comparator
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
 
ENTITY Comparator_test IS
END Comparator_test;
 
ARCHITECTURE behavior OF Comparator_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comparator
    PORT(
         sel1 : IN  std_logic_vector(4 downto 0);
         sel2 : IN  std_logic_vector(4 downto 0);
         comp_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sel1 : std_logic_vector(4 downto 0) := (others => '0');
   signal sel2 : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal comp_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comparator PORT MAP (
          sel1 => sel1,
          sel2 => sel2,
          comp_out => comp_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
			
		sel1 <= "01010";
		sel2 <= "01010";
		
      wait for 100 ns;

		sel1 <= "01010";
		sel2 <= "01011";
		
		wait for 100 ns;

      wait;
   end process;

END;
