--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:32:28 04/11/2023
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/Dec_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
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
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL; USE IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Dec_test IS
END Dec_test;
 
ARCHITECTURE behavior OF Dec_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         Dec_IN  : IN  std_logic_vector(4 downto 0);
         Dec_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Dec_IN : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Dec_OUT : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          Dec_IN => Dec_IN,
          Dec_OUT => Dec_OUT
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      
		Dec_In <= "00000";
		wait for 100 ns;	
		
		for i in 0 to 30 loop
			
			Dec_In <= Dec_In + "00001";
			wait for 100 ns;
			
		end loop;

      wait;
   end process;

END;
