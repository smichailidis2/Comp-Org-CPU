--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:37:41 05/01/2024
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/ALUentity_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUentity
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
 
ENTITY ALUentity_test IS
END ALUentity_test;
 
ARCHITECTURE behavior OF ALUentity_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUentity
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         ALU_Out : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_Out : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUentity PORT MAP (
          A => A,
          B => B,
          Op => Op,
          ALU_Out => ALU_Out,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   -- <clock>_process :process
   -- begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 10 ns.
      wait for 20 ns;	
      -- wait for <clock>_period*10;

      -- insert stimulus here 
		wait for 10 ns;
		-- ADDITION ---------------------------
		Op <= "0000";
		-- 2 + 3 = 5
		A <= "00000000000000000000000000000010";
		B <= "00000000000000000000000000000011";
		
		wait for 10 ns;
		-- addition with overflow
		A <= "01000000000000000000000000000010";
		B <= "01000000000000000000000000000011";
		
		wait for 10 ns;
		-- addition with carry out
		A <= "01000000000000000000000000000010";
		B <= "11000000000000000000000000000010";
		
		wait for 10 ns;
		-- SUBTRACTION  -------------------------
		Op <= "0001"; 
		-- 15 - 8 = 7
		A <= "00000000000000000000000000001111";
		B <= "00000000000000000000000000001000";
		
		wait for 10 ns;
		-- check zero flag
		-- 2 - 2 = 0
		A <= "00000000000000000000000000000010";
		B <= "00000000000000000000000000000010";
		
		
		wait for 10 ns;
		-- LOGICAL AND --------------------------
		Op <= "0010";
		-- 4 & 15 = 4
		A <= "00000000000000000000000000000100";
		B <= "00000000000000000000000000001111";
		wait for 10 ns;
		-- LOGICAL OR ---------------------------
		Op <= "0011";
		-- 4 | 15 = 15
		A <= "00000000000000000000000000000100";
		B <= "00000000000000000000000000001111";
		wait for 10 ns; -- do nothing, zero=HIGH
		--set B to zeros, not used later
		B <= "00000000000000000000000000000000";
		--set A to all zeros
		A <= "00000000000000000000000000000000";
		wait for 10 ns;
		-- NOT ----------------------------------
		Op <= "0100";
		-- not(0) = -1
		A  <= "00000000000000000000000000000000";
		wait for 10 ns;
		A  <= "11100000000000111000000000000111";
		

		wait for 10ns;
		-- SHIFT RIGHT ARITHMETIC ---------------
		Op <= "1000";
		A  <= "10000000000000000000000000000000";

		
		wait for 10ns;
		-- SHIFT RIGHT LOGICAL -----------------
		Op <= "1001";
		-- 214 / 2 = 107 
		A  <= "00000000000000000000000011010110";
		
		
		wait for 10ns;
		-- SHIFT LEFT LOGICAL ------------------
		Op <= "1010";
		-- 214 * 2 = 428 
		A  <= "00000000000000000000000011010110";
		
		wait for 10ns;
		-- SHIFT LEFT ROTATE -------------------
		Op <= "1100";
		A  <= "10110000000000000000000011010100";
		
		wait for 10ns;
		-- SHIFT RIGHT ROTATE ------------------
		Op <= "1101";
		A  <= "00001100011100000000000011010111";
		
      wait;
   end process;

END;
