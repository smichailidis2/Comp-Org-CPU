--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:58:39 04/11/2023
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/Register_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Register_comp
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
 
ENTITY Register_test IS
END Register_test;
 
ARCHITECTURE behavior OF Register_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register_comp
    PORT(
         clk : IN  std_logic;
         DataIN : IN  std_logic_vector(31 downto 0);
         DataOUT : OUT  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal DataIN : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal DataOUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register_comp PORT MAP (
          clk => clk,
          DataIN => DataIN,
          DataOUT => DataOUT,
          WE => WE,
          rst => rst
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
	
		wait for 100 ns;
	
      DataIN <= "00000000000000000000000000000001";
		WE <= '1';
      wait for 100 ns;	

      DataIN <= "00000000000000000000000000000001";
		WE <= '0';
		wait for 100 ns;
		
		DataIN <= "00000000000000000000000000000010";
		rst <= '1';
		WE <= '1';
		wait for 100ns;
		
		DataIN <= "00000000000000000000000000000010";
		rst <= '1';
		WE <= '0';
		wait for 100ns;


		DataIN <= "00000000000000000000000000000011";
		rst <= '0';
		WE <= '1';
		wait for 100ns;
		
		DataIN <= "00000000000000000000000000000011";
		rst <= '0';
		WE <= '0';
		wait for 100ns;
	


      wait for clk_period*10;

      wait;
   end process;

END;
