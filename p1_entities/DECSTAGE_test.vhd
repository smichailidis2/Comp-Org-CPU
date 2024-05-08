-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY DECSTAGE_test IS
  END DECSTAGE_test;

  ARCHITECTURE behavior OF DECSTAGE_test IS 

  -- Component Declaration
          COMPONENT DECSTAGE
					 Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
							  RF_WrEn : in  STD_LOGIC;
							  ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
							  MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
							  RF_WrData_sel : in  STD_LOGIC;
							  RF_B_sel : in  STD_LOGIC;
							  clk : in  STD_LOGIC;
							  rst : in  STD_LOGIC;
							  Immed : out  STD_LOGIC_VECTOR (31 downto 0);
							  RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
							  RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
          END COMPONENT;

			 signal  Instr :  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			 signal  RF_WrEn :  STD_LOGIC := '0';
			 signal  ALU_out :  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			 signal  MEM_out :  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			 signal  RF_WrData_sel :  STD_LOGIC := '0';
			 signal  RF_B_sel :  STD_LOGIC := '0';
			 signal  clk :  STD_LOGIC := '0';
			 signal  rst :  STD_LOGIC := '0';
			 signal  Immed :  STD_LOGIC_VECTOR (31 downto 0);
	  		 signal  RF_A :  STD_LOGIC_VECTOR (31 downto 0);
		 	 signal  RF_B :  STD_LOGIC_VECTOR (31 downto 0);
			 
			 constant Clk_period : time := 10 ns;

          

  BEGIN

  -- Component Instantiation
          uut: DECSTAGE PORT MAP(
                  Instr => Instr,
						RF_WrEn => RF_WrEn,
						ALU_out => ALU_out,
						MEM_out => MEM_out,
						RF_WrData_sel => RF_WrData_sel,
						RF_B_sel => RF_B_sel,
						clk => clk,
						rst => rst,
						Immed => Immed,
						RF_A => RF_A,
						RF_B => RF_B
						
          );
			 
			 
		clk_process : process
		begin
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		end process;


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes
        -- Add user defined stimulus here
		  rst <= '1';
		  wait for 20 ns;
		  rst <= '0';
		  -- instruction: RF[2] <= RF[1] + RF[3]
		  Instr <= "10000000001000110001000000110000";
		  ALU_out <= "11110001010001011101101011001000";
		  -- R-type, RF B select is LOW
		  RF_B_sel <= '0';
		  -- ALU result, RF write data select LOW
		  RF_WrData_sel <= '0';
		  
		  wait for 10 ns;
		  -- instruction: RF[4] <= RF[5] - RF[6]
		  Instr <= "10000000101001000011000000110001";
		  ALU_out <= "11110001010010011101101010001111";
		  -- R-type, RF B select is LOW
		  RF_B_sel <= '0';
		  -- ALU result, RF write data select LOW
		  RF_WrData_sel <= '0';
		  -- Register File Write Enable HIGH
		  RF_WrEn <= '1';

		  wait for 10 ns;
		  -- instruction: RF[10] <= 2^10(+RF[0])
		  Instr <= "11100000000010100000010000000000";
		  ALU_out <= "00000000000000000000010000000000";
		  -- I-type, RF B select is HIGH
		  RF_B_sel <= '1';
		  -- ALU result, RF write data select LOW
		  RF_WrData_sel <= '0';		  
		  

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
