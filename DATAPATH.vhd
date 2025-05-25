----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:58 05/06/2024 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;	 
			  CONTROL_OUT: in STD_LOGIC_VECTOR (15 downto 0);
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC);
end DATAPATH;


architecture Behavioral of DATAPATH is

component DECSTAGE is
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
end component;

component IFSTAGE is
    Port ( PC_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           INSTR : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EXECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
			  selectOperand1 : in  STD_LOGIC;
			  selectOperand2 : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_ForwardINsource : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_ForwardINtarget : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC);
end component;


component MEMORY_UNIT is
	Port ( a : in std_logic_vector(9 downto 0);
			 d : in std_logic_vector(31 downto 0);
			 clk : in std_logic;
			 we : in std_logic;
			 ByteFlag : in std_logic;
			 mem_data_out : out std_logic_vector(31 downto 0));
end component;


component Register_comp is
	Port ( clk : in  STD_LOGIC;
			 DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
			 DataOUT : out  STD_LOGIC_VECTOR (31 downto 0);
			 WE : in  STD_LOGIC;
			 rst : in  STD_LOGIC);
end component;

component Register_comp1 is
	Port ( clk : in  STD_LOGIC;
			 DataIN : in  STD_LOGIC;
			 DataOUT : out  STD_LOGIC;
			 WE : in  STD_LOGIC;
			 rst : in  STD_LOGIC);
end component;

component FWD_Unit is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           INSTR : in  STD_LOGIC_VECTOR (31 downto 0);
           selectOperand1 : out  STD_LOGIC;
           selectOperand2 : out  STD_LOGIC;
           selectDelaySource : out  STD_LOGIC;
			  selectDelayTarget : out STD_LOGIC);
end component;


component MUX2 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC);
end component;


-- signals
signal DECSTAGE_out_Immed32 : std_logic_vector(31 downto 0);
signal DECSTAGE_out_RFB		 : std_logic_vector(31 downto 0);
signal DECSTAGE_out_RFA		 : std_logic_vector(31 downto 0);
signal EXECSTAGE_out_aluout : std_logic_vector(31 downto 0);
signal IFSTAGE_out_INSTR	 : std_logic_vector(31 downto 0);
signal MEMSTAGE_out_memout  : std_logic_vector(31 downto 0);

signal DECregister_IMMEDout : std_logic_vector(31 downto 0);
signal DECregister_B_out	 : std_logic_vector(31 downto 0);
signal DECregister_A_out	 : std_logic_vector(31 downto 0);
signal EXECregister_aluout  : std_logic_vector(31 downto 0);
signal EXECregister_aluout_interm : std_logic_vector(31 downto 0);
signal IFregister_out   	 : std_logic_vector(31 downto 0);
signal MEMregister_memout   : std_logic_vector(31 downto 0);
signal DEC_ADDR_out			 : std_logic_vector(31 downto 0);

-- control register signals
signal cin 	 : std_logic_vector(31 downto 0);
signal cout1 : std_logic_vector(31 downto 0);
signal cout2 : std_logic_vector(31 downto 0);
signal cout3 : std_logic_vector(31 downto 0);
signal cout4 : std_logic_vector(31 downto 0);


signal selectOperand1 : STD_LOGIC;
signal selectOperand2 : STD_LOGIC;
signal selectDelaySource 	 : STD_LOGIC;
signal selectDelayTarget 	 : STD_LOGIC;

signal selectOperand1delayed : STD_LOGIC;
signal selectOperand2delayed : STD_LOGIC;
signal selectDelaySource_delayed 	 : STD_LOGIC;
signal selectDelayTarget_delayed 	 : STD_LOGIC;

signal selectOperand1delayed2 : STD_LOGIC;
signal selectOperand2delayed2 : STD_LOGIC;
signal selectDelaySource_delayed2 	 : STD_LOGIC;
signal selectDelayTarget_delayed2 	 : STD_LOGIC;

signal selectOperand1delayed3 : STD_LOGIC;
signal selectOperand2delayed3 : STD_LOGIC;
signal selectDelaySource_delayed3 	 : STD_LOGIC;
signal selectDelayTarget_delayed3 	 : STD_LOGIC;

signal FW_mux_out_source : std_logic_vector(31 downto 0);
signal FW_mux_out_target : std_logic_vector(31 downto 0);


begin
-- =================== INSTRUCTION FETCH STAGE =================== --
Instruction_Fetch: IFSTAGE port map(PC_immed => DECregister_IMMEDout,
												PC_sel => CONTROL_OUT(15),
												PC_LdEn => CONTROL_OUT(14),
												rst => rst,
												clk => clk,
												INSTR => IFSTAGE_out_INSTR);
-- IF STAGE REGISTER
IF_register: Register_comp port map (clk => clk,
												 DataIN => IFSTAGE_out_INSTR,
												 DataOUT => IFregister_out,
												 WE => CONTROL_OUT(3),
												 rst => rst);

-- =================== INSTRUCTION DECODE STAGE =================== -- cout1/4
Instruction_Decode: DECSTAGE port map( Instr => IFregister_out,
													RF_WrEn => cout3(13),
													ALU_out => EXECregister_aluout,
													MEM_out => MEMregister_memout,
													RF_WrData_sel => cout4(12),
													RF_B_sel => cout1(11),
													clk => clk,
													rst => rst,
													Immed => DECSTAGE_out_Immed32,
													RF_A => DECSTAGE_out_RFA,
													RF_B => DECSTAGE_out_RFB );
----- DEC STAGE REGISTERS -----
-- for immediate cloud
DEC_registerIMMED: Register_comp port map ( clk => clk,
														  DataIN => DECSTAGE_out_Immed32,
														  DataOUT => DECregister_IMMEDout,
														  WE => cout1(2),
														  rst => rst);
-- for R_A
DEC_registerA: 	 Register_comp port map ( clk => clk,
														  DataIN => DECSTAGE_out_RFA,
														  DataOUT => DECregister_A_out,
														  WE => cout1(2),
														  rst => rst);

-- for R_B
DEC_registerB:		 Register_comp port map ( clk => clk,
														  DataIN => DECSTAGE_out_RFB,
														  DataOUT => DECregister_B_out,
														  WE => cout1(2),
														  rst => rst);

-- =================== INSTRUCTION EXECUTE STAGE =================== -- cout2		
Instruction_Execute: EXECSTAGE port map(RF_A => DECregister_A_out,
													 RF_B => DECregister_B_out,
													 Immed => DECregister_IMMEDout,
													 ALU_Bin_sel => cout2(10),
													 selectOperand1 => selectOperand1,
													 selectOperand2 => selectOperand2,
													 ALU_func => cout2(9 downto 6),
													 ALU_ForwardINsource => FW_mux_out_source,
													 ALU_ForwardINtarget => FW_mux_out_target,
													 ALU_out => EXECSTAGE_out_aluout,
													 ALU_zero => ALU_zero);
-- EXEC stage register
EXEC_ALUout_register: Register_comp port map (clk => clk,
															 DataIN => EXECSTAGE_out_aluout,
															 DataOUT => EXECregister_aluout_interm,
															 WE => cout2(1),
															 rst => rst);

F_mux_2DSource: MUX2 port map( In0 => EXECregister_aluout_interm,
										 In1 => EXECregister_aluout,
										 Mux_out => FW_mux_out_source,
										 SEL => selectDelaySource);
										 
F_mux_2DTarget: MUX2 port map( In0 => EXECregister_aluout_interm,
										 In1 => EXECregister_aluout,
										 Mux_out => FW_mux_out_target,
										 SEL => selectDelayTarget);						  
															 
EXEC_ALUdelayed_register: Register_comp port map (clk => clk,
																  DataIN => EXECregister_aluout_interm,
																  DataOUT => EXECregister_aluout,
																  WE => cout2(0),
																  rst => rst);
														
-- Dec data memory := DECSTAGE_out_RFB , has to have the same delay with exec stage register out
DEC_DATA_MEM_register: Register_comp port map (clk => clk,
															  DataIN => DECSTAGE_out_RFB,
															  DataOUT => DEC_ADDR_out,
															  WE => cout2(1),
															  rst => rst);

-- ====================== MEMORY ACCESS STAGE ====================== --	cout3											 
Memory_Access : MEMORY_UNIT port map(a => EXECregister_aluout(9 downto 0),
											  	 d => DEC_ADDR_out,
												 we => cout3(5),
												 clk => clk,
												 ByteFlag => cout3(4),
												 mem_data_out => MEMSTAGE_out_memout);

-- MEM stage register			-- cout4
MEM_register: Register_comp port map (clk => clk,
												  DataIN => MEMSTAGE_out_memout,
												  DataOUT => MEMregister_memout,
												  WE => cout4(0),
												  rst => rst);
					
-- FORWARDING CONTROL UNIT					
FWU:  FWD_Unit port map ( clk => clk,
								  rst => rst,
								  INSTR => IFSTAGE_out_INSTR, -- or IFregister_out
								  selectOperand1 => selectOperand1,
								  selectOperand2 => selectOperand2,
								  selectDelayTarget => selectDelayTarget,
								  selectDelaySource => selectDelaySource);
								  
selOp1:	   Register_comp1 port map ( clk => clk,
												  DataIN => selectOperand1,
												  DataOUT => selectOperand1delayed,
												  WE => '1',
												  rst => rst);
												  
selOp2:	   Register_comp1 port map ( clk => clk,
												  DataIN => selectOperand2,
												  DataOUT => selectOperand2delayed,
												  WE => '1',
												  rst => rst);
												  
												  
selDelTarget:	   Register_comp1 port map ( clk => clk,
														  DataIN => selectDelayTarget,
														  DataOUT => selectDelayTarget_delayed,
														  WE => '1',
														  rst => rst);

selDelSource:	   Register_comp1 port map ( clk => clk,
														  DataIN => selectDelaySource,
														  DataOUT => selectDelaySource_delayed,
														  WE => '1',
														  rst => rst);
--------

selOp1_2:	   Register_comp1 port map ( clk => clk,
												  DataIN => selectOperand1delayed,
												  DataOUT => selectOperand1delayed2,
												  WE => '1',
												  rst => rst);
												  
selOp2_2:	   Register_comp1 port map ( clk => clk,
												  DataIN => selectOperand2delayed,
												  DataOUT => selectOperand2delayed2,
												  WE => '1',
												  rst => rst);
												  
												  
selDelTarget_2:	   Register_comp1 port map ( clk => clk,
														  DataIN => selectDelayTarget_delayed,
														  DataOUT => selectDelayTarget_delayed2,
														  WE => '1',
														  rst => rst);

selDelSource_2:	   Register_comp1 port map ( clk => clk,
														  DataIN => selectDelaySource_delayed,
														  DataOUT => selectDelaySource_delayed2,
														  WE => '1',
														  rst => rst);
														  
--------

selOp1_3:	   Register_comp1 port map ( clk => clk,
												  DataIN => selectOperand1delayed2,
												  DataOUT => selectOperand1delayed3,
												  WE => '1',
												  rst => rst);
												  
selOp2_3:	   Register_comp1 port map ( clk => clk,
												  DataIN => selectOperand2delayed2,
												  DataOUT => selectOperand2delayed3,
												  WE => '1',
												  rst => rst);
												  
												  
selDelTarget_3:	   Register_comp1 port map ( clk => clk,
														  DataIN => selectDelayTarget_delayed2,
														  DataOUT => selectDelayTarget_delayed3,
														  WE => '1',
														  rst => rst);

selDelSource_3:	   Register_comp1 port map ( clk => clk,
														  DataIN => selectDelaySource_delayed2,
														  DataOUT => selectDelaySource_delayed3,
														  WE => '1',
														  rst => rst);

------- output for control ----------\
Instruction <= IFSTAGE_out_INSTR; --- |
--Instruction <= IFregister_out;
-------------------------------------/

cin   <= "0000000000000000" & CONTROL_OUT;

control_DECreg: Register_comp port map (clk => clk,
													 DataIN  => cin,
													 DataOUT => cout1,
													 WE => '1',
													 rst => rst);

control_EXECreg: Register_comp port map (clk => clk,
													  DataIN  => cout1,
													  DataOUT => cout2,
													  WE => '1',
													  rst => rst);

control_MEMCreg: Register_comp port map (clk => clk,
													  DataIN  => cout2,
													  DataOUT => cout3,
													  WE => '1',
													  rst => rst);

control_WBCreg: Register_comp port map (clk => clk,
													 DataIN  => cout3,
													 DataOUT => cout4,
													 WE => '1',
													 rst => rst);
													  





end Behavioral;

