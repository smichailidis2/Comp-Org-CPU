-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY RF_test IS
  END RF_test;

  ARCHITECTURE behavior OF RF_test IS 

  -- Component Declaration
          COMPONENT RF
				 Port ( Ard1 	: in  STD_LOGIC_VECTOR (4 downto 0);
						  Ard2 	: in  STD_LOGIC_VECTOR (4 downto 0);
						  Awr 	: in  STD_LOGIC_VECTOR (4 downto 0);
						  Dout1  : out  STD_LOGIC_VECTOR (31 downto 0);
						  Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0);
						  Din 	: in  STD_LOGIC_VECTOR (31 downto 0);
						  WrEn 	: in  STD_LOGIC;
						  clk 	: in  STD_LOGIC;
						  rst 	: in STD_LOGIC);
          END COMPONENT;

			 signal Ard1 	:  STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
          signal Ard2 	:  STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
          signal Awr 	:  STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
          signal Dout1  :  STD_LOGIC_VECTOR (31 downto 0);
          signal Dout2 	:  STD_LOGIC_VECTOR (31 downto 0);
          signal Din 	:  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
          signal WrEn 	:  STD_LOGIC := '0';
          signal clk 	:  STD_LOGIC := '0';
			 signal rst 	:  STD_LOGIC := '0';
			 
			 constant Clk_period : time := 10 ns;

          

  BEGIN

  -- Component Instantiation
          uut: RF PORT MAP(
                  Ard1 => Ard1,
						Ard2 => Ard2,
						Awr => Awr,
						Dout1 => Dout1,
						Dout2 => Dout2,
						Din => Din,
						WrEn => WrEn,
						clk => clk,
						rst => rst
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
		  wait for 100 ns;
		  rst <= '0';

		  -- supose we have addition
		  Ard1 <= "00001";
		  Ard2 <= "00010";
		  Awr  <= "00011";
		  WrEn <= '1';
		  Din  <= "00000001001000010110100000001111";
		  
		  wait for 10 ns;
		  Ard1 <= "10000";
		  Ard2 <= "10001";
		  Awr  <= "10010";
		  WrEn <= '0';
		  Din  <= "11110001001000010110100000001111";
		  
		  wait for 10 ns;
		  Ard1 <= "10111";
		  Ard2 <= "11111";
		  Awr  <= "10011";
		  WrEn <= '1';
		  Din  <= "11110001111000010110100011111111";
		  rst <= '1';
		  
		  wait for 10 ns;
		  rst <= '0';
		  Ard1 <= "01010";
		  Ard2 <= "01011";
		  Awr  <= "00001";
		  WrEn <= '0';
		  Din  <= "10101010000100100000111101000000";
		  
		  wait for 10 ns;
		  Ard1 <= "11010";
		  Ard2 <= "11011";
		  Awr  <= "00010";
		  WrEn <= '0';
		  Din  <= "11001010111100100000111101001111";		  
		  
		  
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
