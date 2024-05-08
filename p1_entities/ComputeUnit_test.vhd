-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY ComputeUnit_test IS
  END ComputeUnit_test;

  ARCHITECTURE behavior OF ComputeUnit_test IS 

  -- Component Declaration
          COMPONENT ComputeUnit
          PORT(
                  clk : IN std_logic;
                  rst : IN std_logic
                  );
          END COMPONENT;

          signal rst :  std_logic := '0';
			 signal clk :  std_logic := '0';
			 
			 
			 constant clk_period : time := 10 ns;


  BEGIN

  -- Component Instantiation
          uut: ComputeUnit PORT MAP(
                  clk => clk,
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


  --  Test Bench Statements
     tb : PROCESS
     BEGIN
		  rst <= '1';
        wait for 100 ns; -- wait until global set/reset completes
		  rst <= '0';



        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
