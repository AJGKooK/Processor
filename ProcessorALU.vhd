library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProcessorALU is

	generic 
	(
		lui_shift : integer := 16;
		N		  : integer := 32;
		SLT_SUB_ON  : integer := 1
	);

	port(
	i_vector 	: in std_logic_vector(3 downto 0);			-- ALU selection
	i_A			: in std_logic_vector(31 downto 0);			-- 32-bit input A
	i_B			: in std_logic_vector(31 downto 0);			-- 32-bit input B
	i_shiftAmt	: in std_logic_vector(4 downto 0);			-- Added shift amount
	o_O_F		: out std_logic_vector(31 downto 0);		-- 32-bit output
	o_overflow  : out std_logic								-- Overflow output
	);
end ProcessorALU;

architecture structural of ProcessorALU is
		component invg				-- 2-bit not gate
	port(
	     i_A  	     : in std_logic;
         o_F        : out std_logic);
  end component;
  
		component org2				-- 2-bit or gate
	port(
		 i_A         : in std_logic;
         i_B         : in std_logic;
         o_F         : out std_logic);
  end component;
  
		component signBit			-- Extracts sign bit from 32-bit number
   port(
		i_sb			: in std_logic_vector(31 downto 0);
		o_sb	   		: out std_logic);

  end component;

		component oneto32bit		-- converts 1-bit to 32-bit number, 1-bit number placed in (0) spot
   port(
		i_ot32b			: in std_logic;
		o_ot32b			: out std_logic_vector(31 downto 0));

  end component;
  
		component and_32bit			-- 32-bit and gate
    port(
         i_and_A : in std_logic_vector(31 downto 0);
         i_and_B : in std_logic_vector(31 downto 0);
         o_and_F : out std_logic_vector(31 downto 0));
  end component;
	
		component or_32bit			-- 32-bit or gate
    port(
         i_or32_A : in std_logic_vector(31 downto 0);
         i_or32_B : in std_logic_vector(31 downto 0);
         o_or32_F : out std_logic_vector(31 downto 0));
  end component;
		
	    component not_32bit			-- 32-bit not gate
    port(
         i_not32_A : in std_logic_vector(31 downto 0);
         o_not32_F : out std_logic_vector(31 downto 0));
  end component;
	
		component xor_32bit			-- 32-bit xor gate
    port(
         i_xor_A : in std_logic_vector(31 downto 0);
         i_xor_B : in std_logic_vector(31 downto 0);
         o_xor_F : out std_logic_vector(31 downto 0));
  end component;
	
		component shift32_left		-- shift left logical
    port(
		i_barll : in STD_LOGIC_VECTOR(31 downto 0);
		i_swll  : in  STD_LOGIC_VECTOR(4 downto 0);
		o_barll : out STD_LOGIC_VECTOR(31 downto 0));
  end component;

		component shift32_right		-- shift right logical
    port(
		i_barlr : in STD_LOGIC_VECTOR(31 downto 0);
		i_swlr  : in STD_LOGIC_VECTOR(4 downto 0);
		o_barlr : out STD_LOGIC_VECTOR(31 downto 0));
  end component;
  
  		component shift32ar_right	-- shift right arithmathetic 
    port(
		i_barar : in STD_LOGIC_VECTOR(31 downto 0);
		i_swar  : in STD_LOGIC_VECTOR(4 downto 0);
		o_barar : out STD_LOGIC_VECTOR(31 downto 0));
  end component;
  
		component AddSub 			-- Adder/Subtractor
	port(
		--Inputs
		i_D_0	:in std_logic_vector (N-1 downto 0);
		i_D_1	:in std_logic_vector (N-1 downto 0);
		i_S_Sub	:in std_logic;
		
		--Outputs
		o_D_Sum :out std_logic_vector (N-1 downto 0);
		o_D_Cout:out std_logic);
  
	end component;
  
    	component mux2t1_32			-- 32-bit Mux
    port(
	   i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
  end component;


	signal s_OR_F 		   : std_logic_vector(N-1 downto 0);
	signal s_SLL16_barll   : std_logic_vector(N-1 downto 0);
	signal s_XOR_F		   : std_logic_vector(N-1 downto 0);
	signal s_AND_F		   : std_logic_vector(N-1 downto 0);
	signal s_SRL_barlr	   : std_logic_vector(N-1 downto 0);
	signal s_SLT_D_Sum	   : std_logic_vector(N-1 downto 0);
	signal s_SLT_D_Cout	   : std_logic;
--	signal s_SLT_switch    : std_logic;									-- Needs to be forced to 1 in order for SUB to work
	signal s_SLT_sb		   : std_logic;
	signal s_SLT_not_ot32b : std_logic_vector(N-1 downto 0);
	signal s_SLT_or_ot32b  : std_logic_vector(N-1 downto 0);
	signal s_ADDSUB_D_S    : std_logic_vector(N-1 downto 0);
	signal s_ADDSUB_D_C    : std_logic;
	signal s_SLL_barll     : std_logic_vector(N-1 downto 0);
	signal s_SRA_barar     : std_logic_vector(N-1 downto 0);
	
	signal s_OR_F_invert   : std_logic_vector(N-1 downto 0);
	signal s_MUX0_0		   : std_logic_vector(N-1 downto 0);
	signal s_MUX1_0		   : std_logic_vector(N-1 downto 0);
	signal s_SLT_sign_b    : std_logic_vector(N-1 downto 0);
	signal s_SLT_or		   : std_logic;
	signal s_SLT_not	   : std_logic;
	signal s_MUX2_0		   : std_logic_vector(N-1 downto 0);
	
	signal s_MUX0_1		   : std_logic_vector(N-1 downto 0);
	signal s_MUX1_1		   : std_logic_vector(N-1 downto 0);
	signal s_MUX2_1		   : std_logic_vector(N-1 downto 0);
	signal s_MUX3_1		   : std_logic_vector(N-1 downto 0);
	
	signal s_MUX0_2	   	   : std_logic_vector(N-1 downto 0);
	signal s_MUX1_2		   : std_logic_vector(N-1 downto 0);
	signal s_MUX1_F		   : std_logic_vector(N-1 downto 0);
	
	begin


	
-- OR command to MUX0_0 
 OR_command : or_32bit
    port map(
        i_or32_A		=> i_A,
        i_or32_B     	=> i_B,
        o_or32_F     	=> s_OR_F
    );

-- OR invert to 32-bit not
 OR_invert : not_32bit
	port map(
        i_not32_A	=> s_OR_F,
        o_not32_F	=> s_OR_F_invert
    );
	
-- SLL command to MUX0_1
  SLL_command : shift32_left
	port map(
		i_barll => i_A,
		i_swll  => "01111",	
		o_barll => s_SLL16_barll
	);

-- XOR command to MUX1_0
 XOR_command : xor_32bit
    port map(
        i_xor_A		=> i_A,
        i_xor_B    	=> i_B,
        o_xor_F    	=> s_XOR_F
    );

-- AND command to MUX1_0
 AND_command : and_32bit
    port map(
        i_and_A		=> i_A,
        i_and_B    	=> i_B,
        o_and_F    	=> s_AND_F
    );	

-- SRL command to MUX1_1
  SRL_command : shift32_right
	port map(
		i_barlr => i_A,
		i_swlr  => i_shiftAmt,
		o_barlr => s_SRL_barlr
	);

-- SLT command to MUX2_0
  SLT_command	:	AddSub
	port map(
		--Inputs
		i_D_0	=> i_A,
		i_D_1	=> i_B,
		i_S_Sub	=> '1',				--Turn on during testing (turn to 1 which = SLT).  Fixed, changed from s_SLT_switch
			
		--Outputs
		o_D_Sum	=> s_SLT_D_Sum,
		o_D_Cout=> s_SLT_D_Cout
	);

-- signBit to OR gate
 SLT_sb	:	signBit
   port map(
       i_sb		=> s_SLT_D_Sum,
	   o_sb     => s_SLT_sb
   );	

-- OR gate to 1to32 converter
 SLT_or	:	org2
   port map(
       i_A		=> s_SLT_sb,
       i_B    	=> s_SLT_D_Cout,
       o_F    	=> s_SLT_or
   );		

-- 1to32 converter to MUX
 SLT_or1to32	:	oneto32bit
   port map(
       i_ot32b		=> s_SLT_or,
	   o_ot32b		=> s_SLT_or_ot32b
   );

-- NOT gate to 1to32 converter
	SLT_not	:	invg
	  port map(
        i_A	=> s_SLT_D_Cout,
        o_F	=> s_SLT_not
	);

-- 1to32 to MUX
 SLT_not1to32	:	oneto32bit
   port map(
       i_ot32b		=> s_SLT_not,
	   o_ot32b		=> s_SLT_not_ot32b
   );

-- ADD/SUB command to MUX2_1
	ADDSUM_command : AddSub 
	port map(
		--Inputs
		i_D_0	=> i_A,
		i_D_1	=> i_B,
		i_S_Sub	=> i_vector(0),
		
		--Outputs
		o_D_Sum	=> s_ADDSUB_D_S,
		o_D_Cout=> o_overflow      --NOT CURRENTLY USED. DO WE NEED IT?
	);
	
-- SLL command to MUX3_1
  SLL_command2 : shift32_left
	port map(
		i_barll => i_A,
		i_swll  => i_shiftAmt,				--i_B only requires 5 bits for shift amount (Will throw error if larger)
		o_barll => s_SLL_barll
	);

-- SRA command to MUX3_1
  SRA_command : shift32ar_right
    port map(
		i_barar => i_A,
		i_swar  => i_shiftAmt,
		o_barar => s_SRA_barar
	);
	
-- MUX0_0
  MUX0_0 : mux2t1_32	
	port map(
		i_S 	=> i_vector(0),
		i_D0	=> s_OR_F_invert,
		i_D1	=> s_OR_F,
		o_O		=> s_MUX0_0
	);	
	
-- MUX1_0
  MUX1_0 : mux2t1_32	
	port map(
		i_S 	=> i_vector(0),
		i_D0	=> s_AND_F,
		i_D1	=> s_XOR_F,
		o_O		=> s_MUX1_0
	);

-- MUX2_0
    MUX2_0	:	mux2t1_32	
	port map(
		i_S 	=> i_vector(0),
		i_D0	=> s_SLT_not_ot32b,
		i_D1	=> s_SLT_or_ot32b,
		o_O		=> s_MUX2_0
	);

-- MUX0_1
  MUX0_1 : mux2t1_32	
	port map(
		i_S 	=> i_vector(1),
		i_D0	=> s_SLL16_barll,
		i_D1	=> s_MUX0_0,
		o_O		=> s_MUX0_1
	);

-- MUX1_1 
  MUX1_1	:	mux2t1_32	
	port map(
		i_S 	=> i_vector(1),
		i_D0	=> s_SRL_barlr,
		i_D1	=> s_MUX1_0,
		o_O		=> s_MUX1_1
	);

-- MUX2_1
  MUX2_1	:	mux2t1_32	
	port map(
		i_S 	=> i_vector(1),
		i_D0	=> s_ADDSUB_D_S,
		i_D1	=> s_MUX2_0,
		o_O		=> s_MUX2_1
	);

-- MUX3_1
  MUX3_1 : mux2t1_32	
	port map(
		i_S 	=> i_vector(1),
		i_D0	=> s_SLL_barll,
		i_D1	=> s_SRA_barar,
		o_O		=> s_MUX3_1
	);

-- MUX0_2
  MUX0_2 : mux2t1_32	
	port map(
		i_S 	=> i_vector(2),
		i_D0	=> s_MUX1_1,
		i_D1	=> s_MUX0_1,
		o_O		=> s_MUX0_2
	);

-- MUX1_2
  MUX1_2 : mux2t1_32	
	port map(
		i_S 	=> i_vector(2),
		i_D0	=> s_MUX3_1,
		i_D1	=> s_MUX2_1,
		o_O		=> s_MUX1_2
	);
	
-- MUX_F
  MUX_F : mux2t1_32	
	port map(
		i_S 	=> i_vector(3),
		i_D0	=> s_MUX1_2,
		i_D1	=> s_MUX0_2,
		o_O		=> o_O_F
	);	





end structural;