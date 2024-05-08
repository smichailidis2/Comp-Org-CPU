-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY IFSTAGE_test IS
  END IFSTAGE_test;

  ARCHITECTURE behavior OF IFSTAGE_test IS 

  -- Component Declaration
          COMPONENT IFSTAGE
          PORT(
                  PC_immed : IN std_logic_vector(31 downto 0);
                  PC_sel   : IN std_logic;       
                  PC_LdEn  : IN std_logic;
						rst		: IN std_logic;
						clk		: IN std_logic;
						INSTR	   : OUT std_logic_vector(31 downto 0)
                  );
          END COMPONENT;

		signal PC_immed : std_logic_vector(31 downto 0) := (others => '0');
		signal PC_sel   : std_logic := '0';
		signal PC_LdEn  : std_logic := '0';
		signal rst	    : std_logic := '0';
		signal clk 	    : std_logic := '0';
		signal INSTR	 : std_logic_vector(31 downto 0);
          
		constant Clk_period : time := 10 ns;

  BEGIN

  -- Component Instantiation
          uut: IFSTAGE PORT MAP(
                  PC_immed => PC_immed,
                  PC_sel => PC_sel,
						PC_LdEn => PC_LdEn,
						rst => rst,
						clk => clk,
						INSTR => INSTR
          );


		clk_process : process
		begin
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		end process;
		
  --  Test Bench Statements
     stim_proc : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes
		  
			-- hold reset state for 100 ns.
			rst <='1';
			wait for 100 ns;
			rst <= '0';
			
			PC_Sel<='0';
			PC_LdEn<='1';
			wait for clk_period*2;
			PC_Immed <="00000000000000000000000000000000";
			
			PC_Sel<='1';	
			PC_Immed<= "00000000000000000000000000001000";
			wait for clk_period*2;
			PC_Immed <="00000000000000000000000000000000";
		   wait for clk_period*10;

         wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

  END;
